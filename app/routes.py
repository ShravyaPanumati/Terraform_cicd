from flask import render_template
from app import app, db
from app.models import Item

@app.route('/')
def home():
    items = Item.query.all()
    return render_template('index.html', items=items)

@app.route('/add_item', methods=['POST'])
def add_item():
    new_item = Item(name='Example Item', description='This is a sample item')
    db.session.add(new_item)
    db.session.commit()
    return 'Item added'
