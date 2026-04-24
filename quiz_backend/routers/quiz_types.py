from fastapi import APIRouter, HTTPException, status
from database import quiz_types_collection
from schemas import QuizTypeBase, QuizTypeResponse
from bson import ObjectId
from typing import List

router = APIRouter(prefix="/api/quiz-types", tags=["Quiz Types"])

@router.post("/", response_model=QuizTypeResponse)
async def create_quiz_type(quiz_type_in: QuizTypeBase):
    result = await quiz_types_collection.insert_one(quiz_type_in.dict())
    quiz_type = quiz_type_in.dict()
    quiz_type["_id"] = str(result.inserted_id)
    return quiz_type

@router.get("/", response_model=List[QuizTypeResponse])
async def get_quiz_types():
    types = []
    async for t in quiz_types_collection.find():
        t["_id"] = str(t["_id"])
        types.append(t)
    return types
