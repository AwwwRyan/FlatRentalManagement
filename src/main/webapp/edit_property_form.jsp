<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit Property</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background: linear-gradient(135deg, #ffffff, #ffcccc);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                }
                
                .container {
                    background-color: #fff;
                    padding: 40px;
                    border-radius: 12px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                    width: 600px;
                    text-align: center;
                }
                
                h2 {
                    color: #d9534f;
                    margin-bottom: 20px;
                }
                
                input[type="text"],
                input[type="number"],
                textarea,
                select {
                    width: 100%;
                    padding: 10px;
                    margin: 10px 0;
                    border: 1px solid #ddd;
                    border-radius: 6px;
                }
                
                textarea {
                    height: 100px;
                }
                
                button {
                    width: 100%;
                    padding: 12px;
                    background-color: #d9534f;
                    color: white;
                    border: none;
                    border-radius: 6px;
                    font-size: 16px;
                    cursor: pointer;
                    margin-top: 10px;
                }
                
                button:hover {
                    background-color: #c9302c;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <h2>Edit Property</h2>
                <%
        int propertyId = Integer.parseInt(request.getParameter("property_id"));
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String propertyName = "", description = "", address = "", propertyType = "", status = "available";
        double price = 0.0;
        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish Connection
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

            // Prepare SQL query to fetch property details
            String query = "SELECT property_name, description, address, price, property_type, status FROM properties WHERE property_id = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, propertyId);

            // Execute Query
            rs = pstmt.executeQuery();

            // Fetch property details
            if (rs.next()) {
                propertyName = rs.getString("property_name");
                description = rs.getString("description");
                address = rs.getString("address");
                price = rs.getDouble("price");
                propertyType = rs.getString("property_type");
                status = rs.getString("status");
            } else {
        %>
                    <p>Property not found.</p>
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
        
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String newPropertyName = request.getParameter("property_name");
            String newDescription = request.getParameter("description");
            String newAddress = request.getParameter("address");
            double newPrice = Double.parseDouble(request.getParameter("price"));
            String newPropertyType = request.getParameter("property_type");
            String newStatus = request.getParameter("status");

            try {
                // Establish Connection
                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

                // Prepare SQL query to update property
                String updateQuery = "UPDATE properties SET property_name = ?, description = ?, address = ?, price = ?, property_type = ?, status = ? WHERE property_id = ?";
                pstmt = con.prepareStatement(updateQuery);
                pstmt.setString(1, newPropertyName);
                pstmt.setString(2, newDescription);
                pstmt.setString(3, newAddress);
                pstmt.setDouble(4, newPrice);
                pstmt.setString(5, newPropertyType);
                pstmt.setString(6, newStatus);
                pstmt.setInt(7, propertyId);

                // Execute Update
                int rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("admin_viewAllProperties.jsp");
                    return; // Ensure no further code is executed
                } else {
        %>
                                    <script>
                                        alert('Failed to update property. Please try again.');
                                    </script>
                                    <%
                }
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
                                                <form method="post">
                                                    <label for="property_name">Property Name</label>
                                                    <input type="text" id="property_name" name="property_name" value="<%= propertyName %>" required>

                                                    <label for="description">Description</label>
                                                    <textarea id="description" name="description"><%= description %></textarea>

                                                    <label for="address">Address</label>
                                                    <input type="text" id="address" name="address" value="<%= address %>" required>

                                                    <label for="price">Price</label>
                                                    <input type="number" id="price" name="price" value="<%= price %>" step="0.01" required>

                                                    <label for="property_type">Property Type</label>
                                                    <input type="text" id="property_type" name="property_type" value="<%= propertyType %>" required>

                                                    <label for="status">Status</label>
                                                    <select id="status" name="status">
                <option value="available" <%= "available".equals(status) ? "selected" : "" %>>Available</option>
                <option value="sold" <%= "sold".equals(status) ? "selected" : "" %>>Sold</option>
            </select>

                                                    <button type="submit">Update Property</button>
                                                </form>
            </div>
        </body>

        </html>