from fastapi import APIRouter, status
from database import results_collection
from pydantic import BaseModel
from typing import List

router = APIRouter(prefix="/api/results", tags=["Results"])

class ResultIn(BaseModel):
    userId: str
    quizId: str
    score: int

@router.post("/", status_code=status.HTTP_201_CREATED)
async def submit_result(result_in: ResultIn):
    result_dict = result_in.dict()
    res = await results_collection.insert_one(result_dict)
    result_dict["_id"] = str(res.inserted_id)
    return {"message": "Result submitted successfully", "result": result_dict}
