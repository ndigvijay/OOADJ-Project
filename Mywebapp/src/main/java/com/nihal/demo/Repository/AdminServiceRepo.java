package com.nihal.demo.Repository;

public interface AdminServiceRepo extends MongoRepository<AdminModel, ObjectId>{
    void addItemToMenu(MenuItem item);
    void removeItemFromMenu(String itemName);
    void updateMenuItem(String itemName, String newName, float price, String desc, String category);
    List<Order> viewOrders();
}




