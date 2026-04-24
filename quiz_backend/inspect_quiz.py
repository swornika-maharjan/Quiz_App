import asyncio
import os
import certifi
from motor.motor_asyncio import AsyncIOMotorClient
from dotenv import load_dotenv
from bson import ObjectId

load_dotenv()

def serialize(obj):
    if isinstance(obj, ObjectId):
        return str(obj)
    if isinstance(obj, dict):
        return {k: serialize(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [serialize(v) for v in obj]
    return obj

async def main():
    uri = os.getenv("MONGO_URI")
    try:
        client = AsyncIOMotorClient(uri, tlsCAFile=certifi.where())
        db = client.get_database()
        quiz = await db.quizzes.find_one()
        if quiz:
            import json
            print(json.dumps(serialize(quiz), indent=2))
        else:
            print("No quizzes found.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    asyncio.run(main())
