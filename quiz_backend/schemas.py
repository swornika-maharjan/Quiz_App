from pydantic import BaseModel, EmailStr, Field, ConfigDict, BeforeValidator
from typing import List, Optional, Annotated
from bson import ObjectId

# Helper for ObjectId validation
PyObjectId = Annotated[str, BeforeValidator(lambda v: str(v))]

class UserBase(BaseModel):
    name: str
    email: EmailStr

class UserCreate(UserBase):
    password: str

class UserResponse(UserBase):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    name: str
    email: EmailStr

    model_config = ConfigDict(
        populate_by_name=True,
        arbitrary_types_allowed=True,
    )

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class Token(BaseModel):
    message: str
    token: str
    access_token: str
    token_type: str
    user: UserResponse

class Question(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    questionText: str
    options: List[str]
    correctAnswer: str

    model_config = ConfigDict(
        populate_by_name=True,
        arbitrary_types_allowed=True,
    )

class QuizBase(BaseModel):
    title: str
    description: str
    quizTypeId: PyObjectId
    questions: List[Question]

class QuizResponse(QuizBase):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    quizType: Optional[dict] = None

    model_config = ConfigDict(
        populate_by_name=True,
        arbitrary_types_allowed=True,
    )

class QuizTypeBase(BaseModel):
    name: str
    description: str

class QuizTypeResponse(QuizTypeBase):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)

    model_config = ConfigDict(
        populate_by_name=True,
        arbitrary_types_allowed=True,
    )
