<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Hash the password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Database connection
    $conn = new mysqli('localhost', 'root', '', 'todolist');

    if ($conn->connect_error) {
        die('Database connection error: ' . $conn->connect_error);
    } else {
        // Insert data with hashed password
        if (!empty($name) && !empty($email) && !empty($password)) {
            $sql = "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$hashed_password')";
            if ($conn->query($sql) === TRUE) {
                echo 'User created successfully';
                header("Location: index.html");
            } else {
                echo 'Error: ' . $sql . '<br>' . $conn->error;
            }
        } else {
            echo 'All fields are required';
        }

        $conn->close();
    }
}
?>





<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Form</title>
    <link rel="stylesheet" href="signup.css">

</head>
<body>

    <div class="form-container">
        <h2>Signup</h2>
        <form action="" method="post">
            <!-- Name Field -->
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" required placeholder="Enter your full name">
            </div>

            <!-- Email Field -->
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email address">
            </div>

            <!-- Password Field -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter a password">
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <input type="submit" value="Sign Up">
            </div>
        </form>

        <!-- Footer Link -->
        <div class="form-footer">
            <p>Already have an account? <a href="#">Login here</a></p>
        </div>
    </div>

</body>
</html>
