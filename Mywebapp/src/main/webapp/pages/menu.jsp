<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oishi Asagohan - Home</title>
    <style>
        /* CSS styles can be added here */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #f2c94c;
            padding: 20px;
            text-align: center;
            align-items: center;
        }
        h1 {
            margin: 0;
            color: #333;
            cursor: pointer;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .featured-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .featured-item {
            background-color: #fff;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        footer {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .add_cart_button {
            display: inline-block;
            background-color: blue;
            color: white;
            font-weight: bold;
            padding: 10px;
            margin:10px;
            border-radius: 10px;
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
        #cartIcon {
            border-radius: 100%;
            width: 50px;
            height: 50px;
            cursor: pointer;
        }
        #menuheader {
            display: inline-block;
        }
    </style>

    <script>
        async function getItems() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/admin/view-items')
                .then(response => {
                    if(response.ok) {
                        response.json().then(items => {
                            displayItems(items);
                        })
                    }
                    else {
                        alert("Failed to fetch Menu Items!");
                    }
                })
                .catch(error => {
                    console.error("Error: ", error);
                    alert("Error occurred while fetching menu items!");
                })
            }
            catch(error) {
                console.error("Error receiving response: ", error);
            }
        }

        function addItemToCart(item) {
            fetch('<%= request.getContextPath() %>/cart/add', {
                method: 'POST',
                headers: {
                'Content-Type': 'application/json'
                },
                body: JSON.stringify(item)
            })
            .then(response => {
                alert("Added item to your cart!");
            })
            .catch(error => {
                console.error("Error: ", error);
                alert("Error while adding item to cart!");
            })
        }

        function displayItems(items) {
            if(items.length > 0) {
                const cardsHTML = items.map(item => {
                            console.log(item.name);
                            item.quantity = 1;
                            ItemModel = JSON.stringify(item);
                            return `
                                <div class="card">
                                    <div class="left">
                                        <h2>\${item.name}</h2>
                                        <p>Price: \$\${item.price.toFixed(2)}</p>
                                        <button type="button" onclick='addItemToCart(\${ItemModel})'>Add to Cart</button>
                                    </div>
                                    <div class="right">
                                        <img src="\${item.image}" alt="\${item.name} Image">
                                    </div>
                                </div>
                            `;
                        }).join('');
                document.getElementById('featured-items').innerHTML = cardsHTML;
            }
            else {
                console.log("There are no items in the menu yet!");
                document.getElementById('featured-items').innerHTML = `<p>There are no Items in the Menu yet!</p>`;
            }
        }
        
        window.onload = getItems;
    </script>
</head>
<body>
    <header>
        <div>
            <h1 onclick="window.location.href = '/'">Welcome to Oishi Asagohan</h1>
            <img id="cartIcon" src="${pageContext.request.contextPath}/Files/cartImage.png" alt="Cart Icon" onclick="window.location.href = '/cart/mycart'" />
        </div>
        <p>Start your day with delicious breakfast options!</p>
    </header>

    <div class="container">
        <h2>Featured Breakfast Items</h2>
        <div class="featured-items" id="featured-items">
            
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Oishi Asagohan. All rights reserved.</p>
    </footer>
</body>
</html>
