<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
        <%@ page import="java.math.BigDecimal" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Javabrokers - Manage Your Property</title>
                <link rel="stylesheet" href="styles.css">
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
                    
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #ffffff;
                        color: #0c0b0b;
                    }
                    
                    header {
                        background-color: #d9534f;
                        color: white;
                        padding: 2rem 4rem;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        position: relative;
                    }
                    
                    header .logo h1 {
                        margin-left: 20px;
                    }
                    
                    nav ul {
                        list-style-type: none;
                        display: flex;
                        margin: 0;
                    }
                    
                    nav ul li {
                        margin-right: 20px;
                        position: relative;
                    }
                    
                    nav ul li a {
                        color: white;
                        text-decoration: none;
                    }
                    
                    nav .dropdown {
                        position: relative;
                    }
                    
                    .dropdown-content {
                        display: none;
                        position: absolute;
                        background-color: #f9f9f9;
                        min-width: 160px;
                        z-index: 1;
                    }
                    
                    .dropdown-content a {
                        color: black;
                        padding: 12px 16px;
                        text-decoration: none;
                        display: block;
                    }
                    
                    .dropdown:hover .dropdown-content {
                        display: block;
                    }
                    
                    .login-signup {
                        margin-right: 20px;
                    }
                    
                    .login-signup a {
                        color: white;
                        text-decoration: none;
                        margin-left: 10px;
                    }
                    
                    footer {
                        background-color: #2e2e2e;
                        color: #ffffff;
                        padding: 40px 0;
                        text-align: center;
                    }
                    
                    .footer-container {
                        max-width: 1200px;
                        margin: 0 auto;
                    }
                    
                    .footer-bottom {
                        background-color: #1f1f1f;
                        text-align: center;
                        padding: 10px 0;
                        font-size: 14px;
                        margin-top: 20px;
                        border-top: 1px solid #444444;
                    }
                    
                    .footer-bottom p {
                        margin: 0;
                    }
                    
                    .footer-bottom p a {
                        color: #ffbb33;
                        text-decoration: none;
                    }
                    
                    .footer-bottom p a:hover {
                        text-decoration: underline;
                    }
                    
                    main {
                        padding: 2rem;
                        text-align: center;
                    }
                    
                    h2 {
                        margin-bottom: 2rem;
                        color: #d9534f;
                    }
                    
                    .upload-form {
                        background-color: #ffffff;
                        padding: 20px;
                        border-radius: 10px;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                        color: #000;
                        max-width: 800px;
                        width: 100%;
                        margin-left: 310px;
                    }
                    
                    .upload-form input,
                    .upload-form select,
                    .upload-form button {
                        width: 100%;
                        margin-bottom: 10px;
                        padding: 10px;
                        border: 2px solid #ccc;
                        border-radius: 5px;
                    }
                    
                    .upload-form button {
                        background-color: #d9534f;
                        color: white;
                        border: none;
                        cursor: pointer;
                    }
                    
                    .upload-form button:hover {
                        background-color: #d9534f;
                    }
                    
                    header .logo {
                        position: absolute;
                        left: 50%;
                        transform: translateX(-50%);
                    }
                    
                    nav {
                        margin-left: auto;
                    }
                </style>
            </head>

            <body>
                <header>
                    <div class="logo">
                        <h1>Javabrokers</h1>
                    </div>
                </header>
                <main>
                    <h2>Upload Your Property</h2>
                    <form class="upload-form" method="post">
                        <div class="form-section">
                            <input type="text" name="propertyName" placeholder="Property Name" required>
                            <input type="text" name="location" placeholder="Location" required>
                            <input type="number" name="price" placeholder="Price (₹)" required>
                        </div>
                        <div class="form-section">
                            <select name="propertyType" required>
                    <option value="">Select Property Type</option>
                    <option value="Apartment">Apartment</option>
                    <option value="House">House</option>
                    <option value="Commercial">Commercial</option>
                    <option value="Villa">Villa</option>
                    <option value="Penthouse">Penthouse</option>
                    <option value="Studio">Studio</option>
                    <option value="Farmhouse">Farmhouse</option>
                </select>
                            <input type="text" name="rooms" placeholder="Number of Rooms" required>
                            <select name="furnishingStatus" required>
                    <option value="">Furnishing Status</option>
                    <option value="Furnished">Furnished</option>
                    <option value="Semi-Furnished">Semi-Furnished</option>
                    <option value="Non-Furnished">Non-Furnished</option>
                </select>
                            <input type="number" name="propertySize" placeholder="Property Size (sq ft)" required>
                            <select name="parking" required>
                    <option value="">Parking Available</option>
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                </select>
                        </div>
                        <button type="submit">Upload Property</button>
                    </form>
                    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            Connection con = null;
            PreparedStatement pstmt = null;
            try {
                // Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Retrieve parameters from request
                String propertyName = request.getParameter("propertyName");
                String location = request.getParameter("location");
                String price = request.getParameter("price");
                String propertyType = request.getParameter("propertyType");
                String rooms = request.getParameter("rooms");
                String furnishingStatus = request.getParameter("furnishingStatus");
                String propertySize = request.getParameter("propertySize");
                String parking = request.getParameter("parking");

                // Establish Connection
                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

                // Prepare SQL query
                String query = "INSERT INTO properties (seller_id, property_name, address, price, property_type, number_of_rooms, furnished_status, property_size) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(query);

                // Assuming seller_id is available in session
                int sellerId = Integer.parseInt(request.getParameter("user_id"));
                pstmt.setInt(1, sellerId);
                pstmt.setString(2, propertyName);
                pstmt.setString(3, location); // Assuming location is used as address
                pstmt.setBigDecimal(4, new BigDecimal(price));
                pstmt.setString(5, propertyType);
                pstmt.setString(6, rooms);
                pstmt.setString(7, furnishingStatus);
                pstmt.setBigDecimal(8, new BigDecimal(propertySize));

                // Execute Update
                int rows = pstmt.executeUpdate();

                if (rows > 0) {
                    // Redirect to seller_dashboard.jsp with user_id parameter
                    response.sendRedirect("seller_dashboard.jsp?user_id=" + sellerId);
                } else {
%>
                        <script>
                            alert('Property upload failed. Please try again.');
                        </script>
                        <%
                }
            } catch (ClassNotFoundException e) {
%>
                            <p>Driver not found:
                                <%= e.getMessage() %>
                            </p>
                            <%
            } catch (SQLException e) {
%>
                                <p>SQL Error:
                                    <%= e.getMessage() %>
                                </p>
                                <%
            } finally {
                // Close resources
                try {
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
%>
                                    <p>Closing Error:
                                        <%= e.getMessage() %>
                                    </p>
                                    <%
                }
            }
        }
        %>
                </main>
                <footer>
                    <div class="footer-container">
                        <p>&copy; 2024 Javabrokers. All Rights Reserved. | Designed with ❤️ by Javabrokers Team.</p>
                    </div>
                    <div class="footer-bottom">
                        <p>&copy; 2024 Javabrokers. All Rights Reserved.</p>
                    </div>
                </footer>
            </body>

            </html>