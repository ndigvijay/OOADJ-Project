<%-- admin-signup.jsp --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Signup</title>
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
        .error-message {
            color: red;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="card">
    <h1>Admin Signup</h1>
    <form id="signupForm">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <div id="passwordError" class="error-message"></div>
        </div>
        <div class="form-group">
            <input type="submit" onclick="submitSignupForm(event)" value="Signup">
        </div>
    </form>
</div>

<script>
    function submitSignupForm(event) {
        event.preventDefault();
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            document.getElementById('passwordError').innerText = "Passwords do not match";
            return;
        } else {
            document.getElementById('passwordError').innerText = "";
        }

        const formData = {
            username: username,
            password: password
        };
        fetch('${pageContext.request.contextPath}/admin/signup', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => {
                if (response.ok) {
                    alert('Signup successful');
                    window.location.replace('${pageContext.request.contextPath}/admin/login');
                } else {
                    alert('Error: ' + response.statusText);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while signing up');
            });
    }
</script>
</body>
</html>
