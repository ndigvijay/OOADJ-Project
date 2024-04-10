<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generated Bill</title>
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

        .bill-details {
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
    </style>
</head>
<body>
    <div class="container">
        <h1 class="heading">Generated Bill</h1>
        <div class="bill-details">
            <!-- Bill items will be appended here -->
        </div>
    </div>

    <script>
        // Get bill details from server-side
        async function getBillDetails() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/bill/view');
                const responseData = await response.text(); // Retrieve response as text
                console.log(responseData); // Log response from server

                // Parse response data as JSON
                const data = JSON.parse(responseData);
                console.log(data.billItems);

                billItems = data.billItems;

                // Generate HTML for each bill item
                const billHTML = billItems.map(item => {
                    return `
                        <div class="bill-item">
                            <div class="item-name">${item.name}</div>
                            <div class="item-price">$${item.price.toFixed(2)}</div>
                        </div>
                    `;
                }).join(''); // Join the array of HTML strings into a single string

                // Append the generated HTML to the container
                document.querySelector('.bill-details').innerHTML = billHTML;
            } catch(error) {
                console.log(error);
            }
        }

        // Call getBillDetails() after the DOM has fully loaded
        window.onload = getBillDetails;
    </script>
</body>
</html>
