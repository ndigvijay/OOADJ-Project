<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generated Bill</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Heading Styles */
        .heading {
            text-align: center;
            color: #333;
            margin-bottom: 20px; /* Added margin for better separation */
        }

        /* Bill Details Styles */
        #bill-details {
            margin-top: 20px;
        }

        .bill-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .bill-item:last-child {
            border-bottom: none;
        }

        .item-name {
            flex: 1;
        }

        .item-price {
            margin-left: 20px;
        }

        /* Total Price Styles */
        .total-price {
            text-align: right; /* Align total price to the right */
            font-size: 18px; /* Increase font size for emphasis */
            font-weight: bold; /* Make total price bold */
            margin-top: 20px; /* Add some space above the total price */
            padding-top: 10px; /* Add padding for better spacing */
            border-top: 1px solid #ddd; /* Add top border for separation */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="heading">Generated Bill</h1>
        <div id="billDetails">
            </div>
    </div>

    <script>
       
       
        let order={}
        const orderId=localStorage.getItem("orderId")
        async function generateBill(){

            // alert(orderId)
            try {
                const responseOrderId=await fetch(`<%= request.getContextPath() %>/user/order/\${orderId}`)
                const order=await responseOrderId.json()
                // console.log(order)
                // console.log(orderId)
                // const response=await fetch(`<%= request.getContextPath() %>/user/order/\${orderId}`);
                viewOrders
               
            } catch (error) {
                
            }
            
        }
        function viewOrders(){
        fetch('<%= request.getContextPath() %>/user/order/'+orderId)
            .then(response => {
                if (response.ok) {
                    response.json()
                    .then(order => {
                        // console.log(order)
                        // console.log(order.orderId)
                        displayOrder(order);
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
        <p>\${order[0].items.map(item => `\${item.name}: \${item.quantity}`).join(', ')}</p>
    `;
}
    const items=[]
    function displayOrder(order){
    const container = document.getElementById("billDetails");
    let total = 0;

    if (order.length > 0 && order[0].items && order[0].items.length > 0) {
        const itemsHTML = order[0].items.map(item => {
            const itemTotal = item.quantity * item.price;
            total += itemTotal;
            return `<p class="bill-item"><p class="item-name"> Item: \${item.name}</p> <p> Quantity: \${item.quantity}</p> <p> Price per unit: \${item.price}</p>  <p>Total Price: \${itemTotal}</p> </p>`;
        }).join('');

        container.innerHTML = itemsHTML;
        container.innerHTML += `<p class="total-price">Total: \${total}</p>`;
    } else {
        container.innerHTML = "<p>No items found in the order.</p>";
    }
}



   

       // Call both functions when the window loads
    window.onload = async function() {
        await generateBill();
        await viewOrders();
        // await getBillDetails();
    };

    </script>
</body>
</html>
