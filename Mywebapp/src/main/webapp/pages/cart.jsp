<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <style>
        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin: 10px;
            width: 200px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div>
        <h1>Cart Items:</h1>
        <div id="cartContainer">
            <!-- Cards will be appended here -->
        </div>
    </div>

    <script>
        async function getCart() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/cart/view');
                const responseData = await response.text(); // Retrieve response as text
                console.log(responseData); // Log response from server

                // Parse response data as JSON
                const data = JSON.parse(responseData);
                console.log(data.itemList);

                itemList = data.itemList;

                // Generate HTML for each cart item
                const cardsHTML = itemList.map(item => {
                    console.log(item.name);
                    return `
                        <div class="card">
                            <h2>\${item.name}</h2>
                            <p>ID: \${item.id}</p>
                            <p>Price: \$\${item.price.toFixed(2)}</p>
                            <p>Quantity: \${item.quantity}</p>
                        </div>
                    `;
                }).join(''); // Join the array of HTML strings into a single string

                // Append the generated HTML cards to the container
                document.getElementById('cartContainer').innerHTML = cardsHTML;
            } catch(error) {
                console.log(error);
            }
        }

        // Call getCart() after the DOM has fully loaded
        window.onload = getCart;
    </script>

</body>
</html>