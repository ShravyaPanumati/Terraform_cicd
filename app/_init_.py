from flask import Flask
from flask_sqlalchemy import SQLAlchemy

# Initialize Flask app and a SQLAlchemy
app = Flask(__name__)

# Set up SQLAlchemy database URI (use Cloud SQL instance details)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://username:password@cloudsql/YOUR_PROJECT_ID:YOUR_REGION:YOUR_INSTANCE_NAME/dbname'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize SQLAlchemy
db = SQLAlchemy(app)

from app import routes
