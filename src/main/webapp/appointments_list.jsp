<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - View Appointments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Font Awesome -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        
        header {
            background-color: #d9534f;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        
        .container {
            margin: 20px auto;
            max-width: 1200px;
        }
        
        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            /* Responsive grid */
            gap: 20px;
        }
        
        .appointment-card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        
        .appointment-card:hover {
            transform: translateY(-5px);
            /* Slight hover effect */
        }
        
        .property-title {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        
        .form-field {
            margin-bottom: 15px;
        }
        
        .form-label {
            font-weight: bold;
        }
        
        .property-price,
        .property-location {
            color: #d9534f;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <header>
        <h1>View Appointments</h1>
    </header>
    <div class="container">
        <br>
        <div class="grid-container">
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <%@ page import="java.sql.*" %>
                    <%
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    // Load JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish Connection
                    con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

                    // Prepare SQL query to fetch appointments
                    String query = "SELECT a.name, a.email, a.phone, a.appointment_date, a.appointment_time, a.message, p.property_name, p.address, p.price " +
                                   "FROM appointments a JOIN properties p ON a.property_id = p.property_id " +
                                   "WHERE p.seller_id = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("user_id")));

                    // Execute Query
                    rs = pstmt.executeQuery();

                    // Display appointments
                    while (rs.next()) {
            %>
                        <div class="appointment-card">
                            <div class="property-title">
                                <%= rs.getString("property_name") %>
                            </div>
                            <div class="form-field">
                                <span class="form-label">Name:</span>
                                <%= rs.getString("name") %>
                            </div>
                            <div class="form-field">
                                <span class="form-label">Email:</span>
                                <%= rs.getString("email") %>
                            </div>
                            <div class="form-field">
                                <span class="form-label">Phone:</span>
                                <%= rs.getString("phone") %>
                            </div>
                            <div class="form-field">
                                <span class="form-label">Appointment Date:</span>
                                <%= rs.getDate("appointment_date") %>
                            </div>
                            <div class="form-field">
                                <span class="form-label">Appointment Time:</span>
                                <%= rs.getTime("appointment_time") %>
                            </div>
                            <div class="form-field">
                                <span class="form-label">Message:</span>
                                <%= rs.getString("message") %>
                            </div>
                            <div class="form-field property-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <%= rs.getString("address") %>
                            </div>
                            <div class="form-field property-price">
                                ₹
                                <%= rs.getDouble("price") %>
                            </div>
                        </div>
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
                        if (rs != null) rs.close();
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
            %>
        </div>
    </div>
</body>

</html>