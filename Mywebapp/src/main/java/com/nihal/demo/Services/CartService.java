package com.nihal.demo.Services;

import com.nihal.demo.Models.CartModel;
import com.nihal.demo.Models.ItemModel;
import org.springframework.stereotype.Service;
import com.nihal.demo.Exceptions.ElementNotFoundException;
import com.nihal.demo.Exceptions.InvalidQuantityException;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class CartService {
    private final CartModel cart = new CartModel();

    private Optional<ItemModel> findItemById(String ItemId) {
        if(cart.getItemList() != null) {
            return cart.getItemList().stream()
                    .filter(item -> item.getId().equals(ItemId))
                    .findFirst();
        }
        return Optional.empty();
    }
    public void addItemToCart(ItemModel item) {
        if(cart.getItemList() == null) {
            cart.setItemList(new ArrayList<>());
        }

        Optional<ItemModel> exist = findItemById(item.getId());
        if(exist.isPresent()) {
            exist.get().setQuantity(exist.get().getQuantity() + item.getQuantity());
        }
        else {
            cart.getItemList().add(item);
        }
    }

    public void removeItemFromCart(String itemId) {
        Optional<ItemModel> item = findItemById(itemId);
        item.ifPresent(cart.getItemList()::remove);
    }

    public void updateQuantity(String itemId, int change) {
        Optional<ItemModel> exist = findItemById(itemId);
        if(exist.isPresent()) {
            int temp = exist.get().getQuantity() + change;
            if(temp == 0) {
                removeItemFromCart(itemId);
            }
            if(temp < 0) {
                throw new InvalidQuantityException("The given quantity is invalid!");
            }
            exist.get().setQuantity(temp);
        }
        else {
            throw new ElementNotFoundException("Item not found in cart: " + itemId);
        }
    }

    public CartModel viewCart() {
        return cart;
    }
}
