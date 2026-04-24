from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import users, quizzes, quiz_types, results
import uvicorn
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(
    title="Quiz App API",
    description="API documentation for the Quiz App backend (FastAPI)",
    version="1.0.0",
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include Routers
app.include_router(users.router)
app.include_router(quizzes.router)
app.include_router(quiz_types.router)
app.include_router(results.router)

@app.get("/")
async def root():
    return {"message": "✅ Quiz Backend API (FastAPI) is running..."}

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8080))
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=True)
