import com.nihal.demo.AdminFunctionality.AdminService;
import com.nihal.demo.Models.ItemModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminAddRemoveItemsController {

    private final AdminService adminService;

    @Autowired
    public AdminAddRemoveItemsController(AdminService adminService) {
        this.adminService = adminService;
    }

    @PostMapping("/addItems")
    public ResponseEntity<String> addItemToMenu(@RequestBody ItemModel item) {
        try {
            adminService.addItemToMenu(item);
            return ResponseEntity.ok("Item added to menu successfully!");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @DeleteMapping("/removeItem/{itemName}")
    public ResponseEntity<String> removeItemFromMenu(@PathVariable String itemName) {
        try {
            adminService.removeItemFromMenu(itemName);
            return ResponseEntity.ok("Item removed from menu successfully!");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @PutMapping("/updateItem/{itemName}")
    public ResponseEntity<String> updateMenuItem(@PathVariable String itemName,
                                                 @RequestParam String newName,
                                                 @RequestParam float price,
                                                 @RequestParam String desc,
                                                 @RequestParam String category) {
        try {
            adminService.updateMenuItem(itemName, newName, price, desc, category);
            return ResponseEntity.ok("Item updated successfully!");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }

    @GetMapping("/viewOrders")
    public ResponseEntity<List<Order>> viewOrders() {
        try {
            List<Order> orders = adminService.viewOrders();
            return ResponseEntity.ok(orders);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error: " + e.getMessage());
        }
    }
}
