package com.nihal.demo.Services;

import com.nihal.demo.Models.CartModel;
import com.nihal.demo.Models.ItemModel;
import com.nihal.demo.Repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nihal.demo.Exceptions.ElementNotFoundException;
import com.nihal.demo.Exceptions.InvalidQuantityException;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class CartService {
    public final CartModel cart = new CartModel();
    @Autowired
    private ItemRepository itemRepo;
    private Optional<ItemModel> findItemByName(String ItemName) {
        if(cart.getItemList() != null) {
            return cart.getItemList().stream()
                    .filter(item -> item.getName().equals(ItemName))
                    .findFirst();
        }
        return Optional.empty();
    }
    public void addItemToCart(String name, int quantity) {
        if(cart.getItemList() == null) {
            cart.setItemList(new ArrayList<>());
        }

        Optional<ItemModel> item = findItemByName(name);
        if(item.isEmpty()) {
            ItemModel repoItem = itemRepo.getItemByName(name);
            ItemModel newItem = null;
            if(repoItem.getName().equals(name)) {
                try {
                    newItem = (ItemModel) repoItem.clone();
                    newItem.setQuantity(quantity);
                    cart.getItemList().add(newItem);
                } catch (CloneNotSupportedException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

    public void removeItemFromCart(String itemName) {
        Optional<ItemModel> item = findItemByName(itemName);
        item.ifPresent(cart.getItemList()::remove);
    }

    public void updateQuantity(String itemName, int change) {
        Optional<ItemModel> exist = findItemByName(itemName);
        if(exist.isPresent()) {
            int temp = exist.get().getQuantity() + change;
            if(temp == 0) {
                removeItemFromCart(itemName);
            }
            if(temp < 0) {
                throw new InvalidQuantityException("The given quantity is invalid!");
            }
            exist.get().setQuantity(temp);
        }
        else {
            throw new ElementNotFoundException("Item not found in cart: " + itemName);
        }
    }

    public CartModel viewCart() {
        return cart;
    }
}
