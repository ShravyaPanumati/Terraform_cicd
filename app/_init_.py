#from flask import Flask
#from flask_sqlalchemy import SQLAlchemy

# Initialize Flask app and a SQLAlchemy
#app = Flask(__name__)

# Set up SQLAlchemy database URI (use Cloud SQL instance details)
#app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://username:password@cloudsql/YOUR_PROJECT_ID:YOUR_REGION:YOUR_INSTANCE_NAME/dbname'
#app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize SQLAlchemy
#db = SQLAlchemy(app)

#from app import routes



import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

# Initialize Flask app
app = Flask(__name__)

# Load environment variables
db_user = os.getenv('DB_USERNAME', 'default_user')  # Replace 'default_user' with a fallback
db_password = os.getenv('DB_PASSWORD', 'default_password')  # Replace with a fallback
db_name = os.getenv('DB_NAME', 'default_dbname')  # Replace with a fallback
project_id = os.getenv('DB_PROJECT_ID')
region = os.getenv('DB_REGION')
instance_name = os.getenv('DB_INSTANCE_NAME')

# Set up SQLAlchemy database URI
app.config['SQLALCHEMY_DATABASE_URI'] = (
    f"mysql+pymysql://{db_user}:{db_password}@cloudsql/"
    f"{project_id}:{region}:{instance_name}/{db_name}"
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize SQLAlchemy
db = SQLAlchemy(app)

from app import routes
