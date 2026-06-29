<?php
session_start(); // Start the session to store user data after login

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Capture user input from the form
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Database connection
    $conn = new mysqli('localhost', 'root', '', 'todolist'); // Make sure your database name is correct

    if ($conn->connect_error) {
        die('Database connection error: ' . $conn->connect_error);
    } else {
        // Check if the email exists in the database
        $sql = "SELECT * FROM users WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $email); // 's' stands for string
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows == 1) {
            // Fetch the user data
            $user = $result->fetch_assoc();

            // Verify the password using password_verify (use this to compare the hashed password)
            if (password_verify($password, $user['password'])) {
                // If credentials are correct, store user info in the session
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['user_name'] = $user['name'];
                $_SESSION['user_email'] = $user['email'];

                // Redirect to index.html or any other page
                header("Location: index.html");
                exit();
            } else {
                echo 'Invalid password.';
            }
        } else {
            echo 'No user found with that email.';
        }

        $stmt->close();
        $conn->close();
    }
}
?>







<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>

    <div class="form-container">
        <h2>Login</h2>
        <form action="login.php" method="post">
            <!-- Email Field -->
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email address">
            </div>

            <!-- Password Field -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <input type="submit" value="Login">
            </div>
        </form>

        <!-- Footer Link -->
        <div class="form-footer">
            <p>Don't have an account? <a href="signup.php">Sign up here</a></p>
        </div>
    </div>

</body>
</html>
