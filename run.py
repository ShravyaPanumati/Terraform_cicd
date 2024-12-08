# run.py

from app import app, db
from app.models import Item

# Create tables
with app.app_context():
    db.create_all()

# Run Flask app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
