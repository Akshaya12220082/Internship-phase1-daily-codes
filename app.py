from flask import Flask, request, jsonify

app = Flask(__name__)

# In-memory database (list of dictionaries)
database = []

# Creating (Insert) a new item
@app.route('/item', methods=['POST'])
def create_item():
    data = request.get_json()
    new_item = {
        "id": len(database) + 1,
        "name": data.get("name"),
        "description": data.get("description")
    }
    database.append(new_item)
    return jsonify({"message": "Item created successfully!", "item": new_item}), 201

# Reading (Get) all items
@app.route('/items', methods=['GET'])
def get_items():
    return jsonify(database), 200

# Reading (Get) a single item by ID
@app.route('/item/<int:item_id>', methods=['GET'])
def get_item(item_id):
    item = next((item for item in database if item["id"] == item_id), None)
    if item:
        return jsonify(item), 200
    else:
        return jsonify({"message": "Item not found"}), 404

# Updating an existing item by ID
@app.route('/item/<int:item_id>', methods=['PUT'])
def update_item(item_id):
    data = request.get_json()
    item = next((item for item in database if item["id"] == item_id), None)
    if item:
        item["name"] = data.get("name", item["name"])
        item["description"] = data.get("description", item["description"])
        return jsonify({"message": "Item updated successfully!", "item": item}), 200
    else:
        return jsonify({"message": "Item not found"}), 404

# Deleting an item by ID
@app.route('/item/<int:item_id>', methods=['DELETE'])
def delete_item(item_id):
    global database
    database = [item for item in database if item["id"] != item_id]
    return jsonify({"message": "Item deleted successfully!"}), 200

if __name__ == '__main__':
    app.run(debug=True)
