<%-- admin-login.jsp --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
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
        input[type="password"] {
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
    <h1>Admin Login</h1>
    <form id="loginForm">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" onclick="submitLoginForm(event)" value="Login">
        </div>
    </form>
</div>

<script>
    function submitLoginForm(event) {
        event.preventDefault();
        const formData = {
            username: document.getElementById('username').value,
            password: document.getElementById('password').value
        };
        fetch('${pageContext.request.contextPath}/admin/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => {
                if (response.ok) {
                    alert('Login successful');
                } else {
                    alert('Error: ' + response.statusText);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while logging in');
            });
    }
</script>
</body>
</html>
