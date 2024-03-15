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
        .featured-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
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
    </style>
</head>
<body>
    <header>
        <h1>Welcome to Oishi Asagohan</h1>
        <p>Start your day with delicious breakfast options!</p>
    </header>

    <div class="container">
        <h2>Featured Breakfast Items</h2>
        <div class="featured-items">
            <!-- Featured breakfast items will be displayed here -->
            <div class="featured-item">
                <h3>Japanese Breakfast Set</h3>
                <p>Enjoy a traditional Japanese breakfast with miso soup, grilled fish, rice, and pickles.</p>
            </div>
            <div class="featured-item">
                <h3>Pancakes & Fresh Berries</h3>
                <p>Indulge in fluffy pancakes topped with a generous serving of fresh berries and maple syrup.</p>
            </div>
            <div class="featured-item">
                <h3>Avocado Toast</h3>
                <p>Start your day with a healthy and delicious avocado toast topped with cherry tomatoes and feta cheese.</p>
            </div>
            <!-- Add more featured items as needed -->
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Oishi Asagohan. All rights reserved.</p>
    </footer>
</body>
</html>
