import os
from dotenv import load_dotenv

# Load .env file
load_dotenv()

class Config:

    # Flask secret key
    SECRET_KEY=os.getenv("SECRET_KEY")

    # MySQL config
    MYSQL_HOST=os.getenv("MYSQL_HOST")

    MYSQL_USER=os.getenv("MYSQL_USER")

    MYSQL_PASSWORD=os.getenv("MYSQL_PASSWORD")

    MYSQL_DB=os.getenv("MYSQL_DB")