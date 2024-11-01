<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #f94b20, #feb47b);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        /* Logout button */
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #d9534f;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            text-decoration: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .logout-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            background-color: #c9302c;
        }

        /* Decorative shapes */
        .shape {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            animation: float 6s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 200px;
            height: 200px;
            bottom: 5%;
            left: 10%;
        }

        .shape:nth-child(2) {
            width: 150px;
            height: 150px;
            top: 10%;
            right: 5%;
        }

        @keyframes float {
            0% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
            100% {
                transform: translateY(0);
            }
        }

        .container {
            width: 100%;
            max-width: 500px;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            z-index: 10;
            position: relative;
        }

        h2 {
            margin-bottom: 30px;
            font-size: 28px;
            color: #0c0b0b;
        }

        .dashboard-buttons {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
        }

        .dashboard-buttons a {
            flex: 1;
            margin: 0 10px;
            padding: 15px 0;
            background-color: #d9534f;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            text-decoration: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .dashboard-buttons a:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            background-color: #c9302c;
        }

        .dashboard-buttons a:active {
            transform: translateY(0);
        }
    </style>
</head>

<body>

    <!-- Decorative shapes -->
    <div class="shape"></div>
    <div class="shape"></div>

    <!-- Logout button at the top right -->
    <a href="index.jsp" class="logout-btn">Logout</a>

    <div class="container">
        <h2>Admin Dashboard</h2>

        <div class="dashboard-buttons">
            <a href="admin_viewAllUsers.jsp">Edit Users</a>
            <a href="admin_viewAllProperties.jsp">Edit Properties</a>
        </div>
    </div>

</body>

</html>