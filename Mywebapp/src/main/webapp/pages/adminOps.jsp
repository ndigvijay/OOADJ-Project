<%-- admin_ops.jsp --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Operations</title>
    <style>
        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            width: 900px;
            margin: 20px auto;
            background-color: #f9f9f9;
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            grid-column-gap: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="number"] {
            width: calc(100% - 16px); /* Adjusted width to accommodate padding */
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
            margin-bottom: 8px; /* Added margin between input fields and buttons */
        }
        button[type="submit"] {
            width: calc(100% - 16px); /* Adjusted width to accommodate padding */
            padding: 10px;
            border: none;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .item-list {
            list-style-type: none;
            padding: 0;
        }
        .item-list li {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="card">
    <!-- Add Item -->
    <form id="addItemForm" class="form-group" >
        <h2>Add Item</h2>
        <div>
            <label for="itemName">Name:</label>
            <input type="text" id="itemName" name="itemName" required>
        </div>
        <div>
            <label for="itemImage">Image:</label>
            <input type="text" id="itemImage" name="itemImage" required>
        </div>
        <div>
            <label for="itemPrice">Price:</label>
            <input type="number" id="itemPrice" name="itemPrice" required>
        </div>
        <div>
            <label for="itemCategory">Category:</label>
            <input type="text" id="itemCategory" name="itemCategory" required>
        </div>
        <div>
            <label for="itemQuantity">Quantity:</label>
            <input type="number" id="itemQuantity" name="itemQuantity" required>
        </div>
        <button  onclick="addItem(event)">Add Item</button>
    </form>

    <!-- Edit Item -->
    <form id="updateItemForm" class="form-group" >
        <h2>Edit Item</h2>
        <div>
            <label for="updateItemId">ID:</label>
            <input type="text" id="updateItemId" name="updateItemId" required>
        </div>
        <!-- Fields to update -->
        <div>
            <label for="newItemName">New Name:</label>
            <input type="text" id="newItemName" name="newItemName">
        </div>
        <div>
            <label for="newItemImage">New Image:</label>
            <input type="text" id="newItemImage" name="newItemImage">
        </div>
        <div>
            <label for="newItemPrice">New Price:</label>
            <input type="number" id="newItemPrice" name="newItemPrice">
        </div>
        <div>
            <label for="newItemCategory">New Category:</label>
            <input type="text" id="newItemCategory" name="newItemCategory">
        </div>
        <div>
            <label for="newItemQuantity">New Quantity:</label>
            <input type="number" id="newItemQuantity" name="newItemQuantity">
        </div>
        <button  onclick="updateItem(event)">Update Item</button>
    </form>

    <!-- Remove Item -->
    <form id="removeItemForm" class="form-group" >
        <h2>Remove Item</h2>
        <div>
            <label for="removeItemId">ID:</label>
            <input type="text" id="removeItemId" name="removeItemId" required>
        </div>
        <input type="submit" onclick="removeItem(event)">Remove Item</input>
    </form>

    <!-- View All Items -->
    <div id="viewItemForm" class="form-group" onclick="viewItems()">
        <h2>View All Items</h2>
        <button type="button">View Items</button>
    </div>

    <!-- Get Item -->
    <form id="getItemForm" class="form-group" >
        <h2>Get Item</h2>
        <div>
            <label for="getItemId">ID:</label>
            <input type="text" id="getItemId" name="getItemId" required>
        </div>
        <input type="submit" onclick="getItem(event)">Get Item</input>
        <div id="itemDetails"></div>
    </form>

    <!-- List to display all items -->
    <ul id="itemList" class="item-list" style="grid-column: span 5;"></ul>


</div>

<script>
    // Functions for CRUD operations go here...

    // Function to view all items
    function viewItems() {
        fetch('/admin/view-items')
            .then(response => {
                if (response.ok) {
                    response.json().then(items => {
                        displayItems(items);
                    });
                } else {
                    alert('Failed to fetch items');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while fetching items');
            });
    }

    // Function to display items in the list
    function displayItems(items) {
        const itemList = document.getElementById('itemList');
        itemList.innerHTML = ''; // Clear previous items
        items.forEach(item => {
            const li = document.createElement('li');
            li.textContent = ` ID :\${item.id}, Name: \${item.name}, Price: \${item.price}, Category: \${item.category}, Quantity: \${item.quantity}`;
            itemList.appendChild(li);
        });
    }

    // Add Item
    function addItem(event) {
        event.preventDefault();
        const formData = {
            itemName: document.getElementById('itemName').value,
            itemImage: document.getElementById('itemImage').value,
            itemPrice: parseFloat(document.getElementById('itemPrice').value),
            itemCategory: document.getElementById('itemCategory').value,
            itemQuantity: parseInt(document.getElementById('itemQuantity').value)

        };
        // alert(formData.itemImage,formData.itemCategory,formData.itemPrice,formData.itemQuantity)
        fetch('/admin/add-item', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => {
                if (response.ok) {
                    alert('Item added successfully');
                    document.getElementById('addItemForm').reset();
                } else {
                    response.json().then(data => {
                        alert('Error: ' + data);
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while adding item');
            });
    }

    // Update Item
    function updateItem(event) {
        event.preventDefault();
        const itemId = document.getElementById('updateItemId').value;
        console.log(itemId)
        const formData = {
            itemName: document.getElementById('itemName').value,
            itemImage: document.getElementById('itemImage').value,
            itemPrice: parseFloat(document.getElementById('itemPrice').value),
            itemCategory: document.getElementById('itemCategory').value,
            itemQuantity: parseInt(document.getElementById('itemQuantity').value)
        };
        fetch(`/admin/update-item?itemId=${itemId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })

                .then(response => {
                if (response.ok) {
                    alert('Item updated successfully');
                    document.getElementById('updateItemForm').reset();
                } else {
                    response.json().then(data => {
                        alert(response.status)
                        alert('Error: ' + data);
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while updating item');
            });
    }

    // Remove Item
    function removeItem(event) {
        event.preventDefault();
        const itemId = document.getElementById('removeItemId').value;
        fetch(`/admin/remove-item/\${itemId}`, {
            method: 'DELETE'
        })
            .then(response => {
                if (response.ok) {
                    alert('Item removed successfully');
                    document.getElementById('removeItemForm').reset();
                } else {
                    response.json().then(data => {
                        alert('Error: ' + data);
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while removing item');
            });
    }

    // Get Item
    function getItem(event) {
        event.preventDefault();
        const itemId = document.getElementById('getItemId').value;
        fetch(`/admin/get-item/\${itemId}`)
            .then(response => {
                if (response.ok) {
                    response.json().then(item => {
                        const itemData = `
                        <h2>Item Details</h2>
                        <ul>
                            <li>ID: \${item.id}</li>
                            <li>Name: \${item.name}</li>
                            <li>Price: \${item.price}</li>
                            <li>Category: \${item.category}</li>
                            <li>Quantity: \${item.quantity}</li>
                        </ul>`;
                        document.getElementById('itemDetails').innerHTML = itemData;
                    });
                } else {
                    alert('Item not found');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while fetching item');
            });
    }
</script>
</body>
</html>
