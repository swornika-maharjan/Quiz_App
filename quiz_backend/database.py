import os
import certifi
from motor.motor_asyncio import AsyncIOMotorClient
from dotenv import load_dotenv

load_dotenv()

MONGO_URI = os.getenv("MONGO_URI")
client = AsyncIOMotorClient(MONGO_URI, tlsCAFile=certifi.where())
db = client.get_database() # Uses the DB name from the URI or default

# Collections
users_collection = db.get_collection("users")
quizzes_collection = db.get_collection("quizzes")
quiz_types_collection = db.get_collection("quiztypes")
results_collection = db.get_collection("results")
