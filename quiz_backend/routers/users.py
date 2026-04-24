from fastapi import APIRouter, HTTPException, Depends, status
from database import users_collection
from schemas import UserCreate, UserResponse, LoginRequest, Token
from auth import get_password_hash, verify_password, create_access_token, get_current_user
from bson import ObjectId

router = APIRouter(prefix="/api/users", tags=["Users"])

@router.post("/register", response_model=dict, status_code=status.HTTP_201_CREATED)
async def register(user_in: UserCreate):
    existing_user = await users_collection.find_one({"email": user_in.email})
    if existing_user:
        raise HTTPException(status_code=400, detail="User already exists")
    
    hashed_password = get_password_hash(user_in.password)
    user_dict = user_in.dict()
    user_dict["password"] = hashed_password
    
    result = await users_collection.insert_one(user_dict)
    user_dict["_id"] = str(result.inserted_id)
    
    return {"message": "User registered successfully", "user": user_dict}

@router.post("/login", response_model=Token)
async def login(login_in: LoginRequest):
    user = await users_collection.find_one({"email": login_in.email})
    if not user:
        raise HTTPException(status_code=400, detail="Invalid credentials")
    
    if not verify_password(login_in.password, user["password"]):
        raise HTTPException(status_code=400, detail="Invalid credentials")
    
    access_token = create_access_token(data={"id": str(user["_id"])})
    
    # Format user for response
    user["_id"] = str(user["_id"])
    return {
        "message": "Login successful",
        "token": access_token,
        "access_token": access_token, # For OAuth2 compatibility
        "token_type": "bearer",
        "user": user
    }

@router.get("/profile", response_model=UserResponse)
async def profile(current_user: dict = Depends(get_current_user)):
    current_user["_id"] = str(current_user["_id"])
    return current_user
