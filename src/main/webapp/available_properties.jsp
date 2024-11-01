<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.sql.*" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Javabrokers - Property Listings</title>
            <link rel="stylesheet" href="styles.css">
            <style>
                /* Include all the CSS styles from the provided HTML */

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    align-items: center;
                }

                body {
                    font-family: Arial, sans-serif;
                    background-color: #fff;
                    color: #0c0b0b;
                }
                /* ... other styles ... */
            </style>
        </head>

        <body>
            <header>
                <div class="logo">
                    <h1 onclick="reloadPage()">Javabrokers</h1>
                </div>
                <div class="search-container">
                    <input type="text" placeholder="Search property..." id="searchProperty">
                    <div class="budget-dropdown">
                        <select id="budget">
                            <option value="">Budget</option>
                            <option value="1">Under 10,000</option>
                            <option value="2">10,000 - 20,000</option>
                            <option value="3">20,000 - 30,000</option>
                            <option value="4">Over 30,000</option>
                        </select>
                    </div>
                    <button onclick="searchProperties()">Search</button>
                </div>
                <div class="login-signup">
                    <a href="index.jsp">Logout</a>
                </div>
            </header>
            <!-- Slideshow Section -->
            <div class="slideshow-container">
                <div class="slides fade">
                    <img src="12.webp" alt="Image 2">
                </div>
                <div class="slides fade">
                    <img src="13.webp" alt="Image 3">
                </div>
                <!-- Next and previous buttons -->
                <a class="prev" onclick="changeSlide(-1)">&#10094;</a>
                <a class="next" onclick="changeSlide(1)">&#10095;</a>
            </div>
            <main>
                <h2 class="underline">AVAILABLE PROPERTIES</h2>
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

                            String search = request.getParameter("search");
                            String budget = request.getParameter("budget");

                            // Prepare SQL query to fetch available properties with filters
                            StringBuilder queryBuilder = new StringBuilder("SELECT property_id, property_name, description, address, price, property_type FROM properties WHERE status = 'available'");

                            if (search != null && !search.isEmpty()) {
                                queryBuilder.append(" AND property_name LIKE ?");
                            }
                            if (budget != null && !budget.isEmpty()) {
                                switch (budget) {
                                    case "1":
                                        queryBuilder.append(" AND price < 10000");
                                        break;
                                    case "2":
                                        queryBuilder.append(" AND price BETWEEN 10000 AND 20000");
                                        break;
                                    case "3":
                                        queryBuilder.append(" AND price BETWEEN 20000 AND 30000");
                                        break;
                                    case "4":
                                        queryBuilder.append(" AND price > 30000");
                                        break;
                                }
                            }

                            pstmt = con.prepareStatement(queryBuilder.toString());

                            int paramIndex = 1;
                            if (search != null && !search.isEmpty()) {
                                pstmt.setString(paramIndex++, "%" + search + "%");
                            }

                            // Execute Query
                            rs = pstmt.executeQuery();

                            // Display available properties
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
                            <!-- Pass the property_id directly in the function call -->
                            <button class="buy-btn" onclick="redirectToProperty(<%= property_id %>)">Buy Now</button>
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

                                        <script>
                                            function redirectToProperty(propertyId) {
                                                window.location.href = "property.jsp?property_id=" + propertyId;
                                            }
                                        </script>

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
                    <p>&copy; 2024 Javabrokers. All Rights Reserved. | Designed with ❤ by Javabrokers Team.</p>
                </div>
            </footer>
            <script>
                // Include all the JavaScript functions from the provided HTML
                let slideIndex = 0;
                showSlides();

                function showSlides() {
                    let i;
                    let slides = document.getElementsByClassName("slides");
                    for (i = 0; i < slides.length; i++) {
                        slides[i].style.display = "none";
                    }
                    slideIndex++;
                    if (slideIndex > slides.length) {
                        slideIndex = 1;
                    }
                    slides[slideIndex - 1].style.display = "block";
                    setTimeout(showSlides, 4000); // Change image every 4 seconds
                }

                function changeSlide(n) {
                    slideIndex += n;
                    if (slideIndex < 1) {
                        slideIndex = slides.length;
                    }
                    if (slideIndex > slides.length) {
                        slideIndex = 1;
                    }
                    showSlides();
                }

                function searchProperties() {
                    let searchQuery = document.getElementById('searchProperty').value;
                    let selectedBudget = document.getElementById('budget').value;

                    // Redirect to the same page with query parameters
                    window.location.href = `available_properties.jsp?search=${encodeURIComponent(searchQuery)}&budget=${encodeURIComponent(selectedBudget)}`;
                }

                function reloadPage() {
                    // Reload the page without any query parameters
                    window.location.href = "available_properties.jsp";
                }
            </script>
        </body>

        </html>