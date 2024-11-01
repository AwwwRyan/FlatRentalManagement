<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.sql.*" %>
        <%
    int propertyId = Integer.parseInt(request.getParameter("user_id"));
%>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Javabrokers - Manage Your Property</title>
                <link rel="stylesheet" href="styles.css">
            </head>

            <body>
                <header>
                    <div class="logo">
                        <h1 onclick="reloadPage()">Javabrokers</h1>
                    </div>
                    <div class="login-signup">
                        <a href="upload_property.jsp?user_id=<%= propertyId %>">Upload New Property</a>
                    </div>
                    <div class="login-signup">
                        <a href="appointments_list.jsp?user_id=<%= propertyId %>">My Appointments</a>
                    </div>
                    <div class="login-signup">
                        <a href="index.jsp">Logout</a>
                    </div>
                </header>
                <!-- Slideshow Section -->
                <div class="slideshow-container">
                    <!-- Removed image slides -->
                    <!-- Next and previous buttons -->
                    <a class="prev" onclick="changeSlide(-1)">&#10094;</a>
                    <a class="next" onclick="changeSlide(1)">&#10095;</a>
                </div>
                <main>
                    <h2 class="underline">Your Properties</h2>
                    <div class="property-grid">
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

                String userId = request.getParameter("user_id");

                // Prepare SQL query to fetch properties listed by the user
                String query = "SELECT property_id, property_name, description, address, price, property_type, status FROM properties WHERE seller_id = ? AND status = 'available'";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, userId);

                // Execute Query
                rs = pstmt.executeQuery();

                // Display properties
                while (rs.next()) {
                    int property_id = rs.getInt("property_id");
            %>
                            <div class="property-card">
                                <h3>
                                    <%= rs.getString("property_name") %>
                                </h3>
                                <p>Location:
                                    <%= rs.getString("address") %>
                                </p>
                                <p class="price">Price: ₹
                                    <%= rs.getDouble("price") %>
                                </p>
                                <p>Status:
                                    <%= rs.getString("status") %>
                                </p>
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
                </main>
                <footer>
                    <div class="footer-container">
                        <div class="footer-section about">
                            <h3>About Javabrokers</h3>
                            <p>Javabrokers is your trusted real estate partner. We bring you the best properties at affordable prices, with unparalleled customer service and an easy buying process. Your dream home is just a click away.</p>
                        </div>
                        <div class="footer-section contact">
                            <h3>Contact Us</h3>
                            <p>Email: <a href="mailto:info@javabrokers.com">info@javabrokers.com</a></p>
                            <p>Phone: +91-123-456-7890</p>
                            <p>Address: 1234, Real Estate Avenue, City, Country</p>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>&copy; 2024 Javabrokers. All Rights Reserved. | Designed with ❤️ by Javabrokers Team.</p>
                    </div>
                </footer>
                <script>
                    // Include your JavaScript functions here
                    // ... existing scripts ...
                </script>
            </body>

            </html>