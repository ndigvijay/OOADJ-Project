<!-- #add admin items form

#remove item by id

#update items by id

#get an item by id

# model
public class ItemModel {
    private String id;

    private String name;

    public String image;

    private float price;

    private String category;

    public int quantity;
}
 -->

 <!-- adminOps.jsp -->

<%@ page import="com.nihal.demo.Models.ItemModel" %>

<!-- Add admin items form -->
<form id="addItemForm">
    <h2>Add Item</h2>
    <div>
        <label for="itemId">ID:</label>
        <input type="text" id="itemId" name="itemId" required>
    </div>
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
    <button type="submit">Add Item</button>
</form>

<!-- Remove item by id form -->
<form id="removeItemForm">
    <h2>Remove Item</h2>
    <div>
        <label for="removeItemId">ID:</label>
        <input type="text" id="removeItemId" name="removeItemId" required>
    </div>
    <button type="submit">Remove Item</button>
</form>

<!-- Update item by id form -->
<form id="updateItemForm">
    <h2>Update Item</h2>
    <div>
        <label for="updateItemId">ID:</label>
        <input type="text" id="updateItemId" name="updateItemId" required>
    </div>
    <!-- Fields to update -->
    <!-- For example: -->
    <!-- <div>
        <label for="newItemName">New Name:</label>
        <input type="text" id="newItemName" name="newItemName">
    </div> -->
    <button type="submit">Update Item</button>
</form>

<!-- Get item by id form -->
<form id="getItemForm">
    <h2>Get Item</h2>
    <div>
        <label for="getItemId">ID:</label>
        <input type="text" id="getItemId" name="getItemId" required>
    </div>
    <button type="submit">Get Item</button>
</form>



