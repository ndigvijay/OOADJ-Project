<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <style>
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

        .heading {
            text-align: center;
            color: #333;
        }

        .card {
            width: 400px;
            height: 200px;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .card h2 {
            margin-top: 0;
            font-size: 1.2em;
            color: #333;
        }

        .card p {
            margin: 5px 0;
            font-size: 0.9em;
            color: #666;
        }
        .right img {
            display: inline-block;
            width: 200px;
            height: 200px;
        }
        .left {
            display: inline-block;
        }
        .card {
            display: flex;
            width: 750px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .left {
            flex: 1;
            padding: 15px;
        }

        .right img {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
        }
        .quantity-manager {
            display: flex;
        }
        #placeorder {
            margin-left: 45%;
            margin-top: 20px;
            background-color: blue;
            color: white;
            font-weight: bold;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
        }
        #backToMenu {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <p id="backToMenu" onclick="window.location.href = '/menu'">&lt; Back to Menu</p>
        <h1 class="heading">Your Cart</h1>
        <div id="cartContainer">
            <!-- Cards will be appended here -->
        </div>
        <button  id="placeorder" onclick="placeOrder()" >Submit</button>
    </div>


    <script>
        function incrementQuantity(item) {
            updateItem(item, 1);
        }

        function decrementQuantity(item) {
            updateItem(item, -1);
        }


        async function placeOrder(){
            const response= await fetch('<%= request.getContextPath() %>/cart/view')
            const data = await response.json()
            const response1= await fetch('<%= request.getContextPath() %>/user/order', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: data
            })
            if(response1.ok){
                alert("Order placed successfully");
                const orderId = await response1.text();
                // alert(orderId)
                // // Store the JWT token in local storage
                localStorage.setItem('orderId', orderId);
                window.location.href = "/pages/billgenerator.jsp"; 
            }
            else{
                alert("error order not saved")
            }
        }



        function updateItem(item, quantityChange) {
            // console.log(quantityChange);
            fetch('<%= request.getContextPath() %>/cart/update-quantity/' + item.name + '?quantityChange=' + encodeURIComponent(quantityChange), {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json'
                },
            })
            .then(response => {
                if(response.ok) {
                    // console.log("updated!");
                    const quantityElement = document.getElementById(item.name);
                    if (quantityElement) {
                        currentQuantity = parseInt(quantityElement.textContent)
                        quantityElement.textContent = currentQuantity + quantityChange;
                    }
                }
            })
            .catch(error => {
                console.error("Error: ", error);
                alert("Error while updating item quantity!");
            });
        }

        async function getCart() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/cart/view');
                const responseData = await response.text(); // Retrieve response as text
                // console.log(responseData); // Log response from server

                // Parse response data as JSON
                const data = JSON.parse(responseData);
                // console.log(data.itemList);

                itemList = data.itemList;

                // Generate HTML for each cart item
                const cardsHTML = itemList.map(item => {
                    // console.log(item.name);
                    ItemModel = JSON.stringify(item);
                    return `
                        <div class="card">
                            <div class="left">
                                <h2>\${item.name}</h2>
                                <p>Price: \$\${item.price.toFixed(2)}</p>
                                <div class="quantity-manager">
                                    <p>Quantity: </p>
                                    <button type="button" onclick='decrementQuantity(\${ItemModel})'>-</button>
                                    <p id="\${item.name}">\${item.quantity}</p>
                                    <button type="button" onclick='incrementQuantity(\${ItemModel})'>+</button>
                                </div>
                            </div>
                            <div class="right">
                                <img src="${pageContext.request.contextPath}/Files/\${item.image}" alt="\${item.name} Image">
                            </div>
                        </div>
                    `;
                }).join(''); // Join the array of HTML strings into a single string

                // Append the generated HTML cards to the container
                document.getElementById('cartContainer').innerHTML = cardsHTML;
            } catch(error) {
                // console.log(error);
            }
        }

        // Call getCart() after the DOM has fully loaded
        window.onload = getCart;
    </script>
</body>
</html>
