<%-- feedback.jsp --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback Form</title>
    <style>
        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            width: 400px;
            margin: 0 auto;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        textarea,
        input[type="number"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="card">
    <h1>Feedback Form</h1>
    <form id="feedbackform">
        <div class="form-group">
            <label for="orderId">Order ID:</label>
            <input type="text" id="orderId" name="orderId" required>
        </div>
        <div class="form-group">
            <label for="feedback">Feedback:</label>
            <textarea id="feedback" name="feedback" required></textarea>
        </div>
        <div class="form-group">
            <label for="rating">Rating:</label>
            <input type="number" id="rating" name="rating" min="1" max="5" required>
        </div>
        <div class="form-group">
            <input type="submit" onclick="submitForm(event)" value="Submit">
        </div>
    </form>
</div>

<script>
    function submitForm(event) {
        event.preventDefault();
        const formData = {
            orderId: document.getElementById('orderId').value,
            feedback: document.getElementById('feedback').value,
            rating: parseInt(document.getElementById('rating').value)
        };
        if(formData.orderId ==='' || formData.feedback ===''){
            alert("please fill the feedback form");
            return;
        }
        fetch('${pageContext.request.contextPath}/user/feedback', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => {
                // alert(response)
                if (response.ok) {
                    alert('Feedback submitted successfully');
                    document.getElementById('feedbackform').reset();
                } else {
                    alert('Error: ' + response.statusText);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while submitting feedback');
            });
    }
</script>
</body>
</html>
