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
        }
        h1 {
            margin: 0;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .restaurant-info {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .cta-button {
            display: inline-block;
            background-color: #f2c94c;
            color: #333;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .cta-button:hover {
            background-color: #f3d36e;
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
        .homeadmin {
            max-width: 800px;
            text-align: center;
            margin: 20px auto;
            color: blue;
        }
        
    </style>
</head>
<body>
    <header>
        <h1>Welcome to Oishi Asagohan</h1>
        <p>Experience the taste of authentic Japanese breakfast!</p>
    </header>

    <div class="container">
        <div class="restaurant-info">
            <h2>About Us</h2>
            <p>Oishi Asagohan is dedicated to bringing the flavors of traditional Japanese breakfast to your table. Our chefs meticulously prepare each dish with fresh and authentic ingredients to ensure an unforgettable dining experience.</p>
            <p>From classic Japanese breakfast sets to modern twists on traditional favorites, we offer a diverse menu that caters to every palate.</p>
            <p>Join us for breakfast and start your day with a delicious journey through Japanese cuisine!</p>
            <a href="/menu" class="cta-button">Order Now</a>
        </div>
    </div>
    <div class="homeadmin">
        <a href="/admin/login">Are you an admin?</a> <br /> <br />
        <a href="/admin/signup">Want to be admin?</a>
    </div>

    <footer>
        <p>&copy; 2024 Oishi Asagohan. All rights reserved.</p>
    </footer>
</body>
</html>
