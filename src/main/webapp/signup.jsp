<%@ page import="java.sql.*" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up</title>
        <link rel="stylesheet" href="style.css">
        <style>
          input[type="radio"] {
            margin-right: 10px;
          }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="image-section">
                <img src="illustration.png" alt="House Image">
            </div>
            <div class="form-section">
                <h2>Create new Account</h2>
                <p>Already Registered? <a href="index.jsp">Login</a></p>
                <form method="post">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>

                    <label>I am a</label>
                    <div class="radio-group">
                        <input type="radio" id="buyer" name="role" value="buyer" required>
                        <label for="buyer">Buyer</label>
                        <input type="radio" id="seller" name="role" value="seller" required>
                        <label for="seller">Seller</label>
                    </div>

                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>


                    <label for="number">Mobile Number</label>
                    <input type="text" id="number" name="number" required>

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>

                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" id="confirm-password" name="confirm-password" required>

                    <button type="submit">Sign Up</button>
                </form>
                <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                Connection con = null;
                PreparedStatement pstmt = null;
                try {
                    // Load JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Retrieve parameters from request
                    String username = request.getParameter("username");
                    String email = request.getParameter("email");
                    String number = request.getParameter("number");
                    String password = request.getParameter("password");
                    String confirmPassword = request.getParameter("confirm-password");
                    String role = request.getParameter("role");

                    // Check if passwords match
                    if (!password.equals(confirmPassword)) {
            %>
                    <script>
                        alert('Passwords do not match. Please try again.');
                    </script>
                    <%
                    } else {
                        // Establish Connection
                        con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

                        // Prepare SQL query
                        String query = "INSERT INTO users (name, email, phone, password, role) VALUES (?, ?, ?, ?, ?)";
                        pstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                        pstmt.setString(1, username);
                        pstmt.setString(2, email);
                        pstmt.setString(3, number);
                        pstmt.setString(4, password);
                        pstmt.setString(5, role);

                        // Execute Update
                        int rows = pstmt.executeUpdate();

                        if (rows > 0) {
                            // Retrieve generated user_id
                            ResultSet generatedKeys = pstmt.getGeneratedKeys();
                            if (generatedKeys.next()) {
                                int userId = generatedKeys.getInt(1);

                                // Redirect based on role with user_id
                                if ("buyer".equalsIgnoreCase(role)) {
                                    response.sendRedirect("available_properties.jsp?user_id=" + userId);
                                } else if ("seller".equalsIgnoreCase(role)) {
                                    response.sendRedirect("seller_dashboard.jsp?user_id=" + userId);
                                }
                            }
                        } else {
            %>
                        <script>
                            alert('Registration failed. Please try again.');
                        </script>
                        <%
                        }
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
            </div>
        </div>
    </body>

    </html>