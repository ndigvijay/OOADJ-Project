<%-- admin_ops.jsp --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Operations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9; /* Added background color */
        }
        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            max-width: 800px; /* Updated max-width */
            margin: 20px auto;
            background-color: #fff; /* Updated background color */
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
        button[type="submit"],
        button {
            width: calc(100% - 16px); /* Adjusted width to accommodate padding */
            padding: 10px;
            border: none;
            border-radius: 3px;
            background-color: #f2c94c; /* Updated button color */
            color: #333;
            cursor: pointer;
            transition: background-color 0.3s ease; /* Added transition effect */
        }
        button[type="submit"]:hover,
        button:hover {
            background-color: #ab8511;
        }
        .item-list {
            list-style-type: none;
            padding: 0;
        }
        .item-list li {
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2c94c;
            color: #333;
        }
        tr:nth-child(even) {
            background-color: #ffffcc;
        }
        tr:nth-child(odd) {
            background-color: #ffffff;
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
        <button  onclick="updateItem()">Update Item</button>
    </form>

    <!-- Remove Item -->
    <form id="removeItemForm" class="form-group" >
        <h2>Remove Item</h2>
        <div>
            <label for="removeItemId">ID:</label>
            <input type="text" id="removeItemId" name="removeItemId" required>
        </div>
        <button  onclick="removeItem(event)">Remove Item</button>
    </form>

    <!-- View All Items -->
    <div id="viewItemForm" class="form-group" >
        <h2>View All Items</h2>
        <button onclick="viewItems()">View Items</button>

        <!-- List to display all items -->
        <ul id="itemList" class="item-list" style="grid-column: span 5;"></ul>


        <table id="itemTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Category</th>
                <th>Quantity</th>
            </tr>
            </thead>
            <tbody id="itemList"></tbody>
        </table>
    </div>

    <!-- Get Item -->
    <form id="getItemForm" class="form-group" >
        <h2>Get Item</h2>
        <div>
            <label for="getItemId">ID:</label>
            <input type="text" id="getItemId" name="getItemId" required>
        </div>
        <button   onclick="getItem(event)">Get Item</button>
        <div id="itemDetails"></div>
    </form>
   

    <!-- View Orders -->
    <div id="viewOrderForm" class="form-group" onclick="viewOrders()">
        <h2>View Orders</h2>
        <button type="button">View Orders</button>
    </div>
    <table id="orderTable">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>description</th>
            </tr>
        </thead>
        <tbody id ="order"></tbody>
    </table>
    





</div>

<script>
    // Functions for CRUD operations go here...

    // Function to view all items
    function viewItems() {
        fetch('<%= request.getContextPath() %>/admin/view-items')
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
        itemList.innerHTML = '';
        items.forEach((item, index) => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>\${item.id}</td>
                <td>\${item.name}</td>
                <td>\${item.price}</td>
                <td>\${item.category}</td>
                <td>\${item.quantity}</td>
            `;
            itemList.appendChild(row);
        });
    }



    // Add Item
    function addItem(event) {
        event.preventDefault();
        const formData = {
            name: document.getElementById('itemName').value,
            image: document.getElementById('itemImage').value,
            price: parseFloat(document.getElementById('itemPrice').value),
            category: document.getElementById('itemCategory').value,
            quantity: parseInt(document.getElementById('itemQuantity').value)

        };
        // alert(formData.itemImage,formData.itemCategory,formData.itemPrice,formData.itemQuantity)
        fetch('<%= request.getContextPath() %>/admin/add-item', {
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
    function updateItem() {
        event.preventDefault();
        const itemId = document.getElementById('updateItemId').value;
        // console.log(itemId)
        const formData = {
            name: document.getElementById('newItemName').value,
            image: document.getElementById('newItemImage').value,
            price: parseFloat(document.getElementById('newItemPrice').value),
            category: document.getElementById('newItemCategory').value,
            quantity: parseInt(document.getElementById('newItemQuantity').value)
        };
        // console.log(formData);
        fetch("<%= request.getContextPath() %>/admin/update-item?itemId="+itemId, {
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

    // async function viewOrders(){
    //     const response= await fetch("<%= request.getContextPath() %>/admin/order")
    //     const data = await response.json()
    //     data.map(item=>{
    //         // console.log(item)

    //     })
    // }
    // Function to view all orders
    function viewOrders(){
        fetch('<%= request.getContextPath() %>/admin/order')
            .then(response => {
                if (response.ok) {
                    response.json().
                    then(orders => {
                        displayOrders(orders);
                    });
                } else {
                    alert('Failed to fetch orders');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while fetching orders');
            });
    }



    function helper(order){
    return `
        <p>\${order.items.map(item => `\${item.name}: \${item.quantity}`).join(', ')}</p>
    `;
}

    // Function to display orders in the table
    function displayOrders(orders) {
        const orderTable = document.getElementById('order');
        orderTable.innerHTML = ''; // Clear previous data
        
        orders.forEach(order => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>\${order.orderId}</td>
                <td>\${helper(order)}</td>                
            `;
            orderTable.appendChild(row);
        });
    }






</script>
</body>
</html>