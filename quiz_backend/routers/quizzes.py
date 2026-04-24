from fastapi import APIRouter, HTTPException, Depends, status
from database import quizzes_collection, quiz_types_collection
from schemas import QuizBase, QuizResponse
from bson import ObjectId
from typing import List

router = APIRouter(prefix="/api/quizzes", tags=["Quizzes"])

@router.post("/", response_model=dict)
async def create_or_update_quiz(quiz_in: QuizBase):
    # Find quiz by quizTypeId
    quiz = await quizzes_collection.find_one({"quizTypeId": quiz_in.quizTypeId})
    
    quiz_dict = quiz_in.dict()
    
    if quiz:
        # Update existing
        await quizzes_collection.update_one(
            {"_id": quiz["_id"]},
            {"$set": quiz_dict}
        )
        quiz_id = quiz["_id"]
    else:
        # Create new
        result = await quizzes_collection.insert_one(quiz_dict)
        quiz_id = result.inserted_id
        
    # Populate quizType info for response
    populated_quiz = await quizzes_collection.find_one({"_id": quiz_id})
    quiz_type = await quiz_types_collection.find_one({"_id": ObjectId(quiz_in.quizTypeId)})
    
    populated_quiz["_id"] = str(populated_quiz["_id"])
    populated_quiz["quizTypeId"] = str(populated_quiz["quizTypeId"])
    if quiz_type:
        quiz_type["_id"] = str(quiz_type["_id"])
        populated_quiz["quizType"] = quiz_type
        
    return {
        "message": "Quiz created/updated successfully",
        "quiz": populated_quiz
    }

@router.get("/", response_model=List[QuizResponse])
async def get_quizzes():
    quizzes = []
    async for quiz in quizzes_collection.find():
        # Populate quizType
        quiz_type = await quiz_types_collection.find_one({"_id": ObjectId(quiz["quizTypeId"])})
        
        quiz["_id"] = str(quiz["_id"])
        quiz["quizTypeId"] = str(quiz["quizTypeId"])
        if quiz_type:
            quiz_type["_id"] = str(quiz_type["_id"])
            quiz["quizType"] = quiz_type
        
        # Ensure questions have string IDs
        for i, q in enumerate(quiz.get("questions", [])):
            if "_id" in q:
                q["_id"] = str(q["_id"])
            else:
                # If no _id, use index as a temporary ID
                q["_id"] = f"q_{i}"
        
        quizzes.append(quiz)
    return quizzes
