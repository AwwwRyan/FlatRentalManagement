<%@ page import="java.sql.*" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
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
                <h2>Login</h2>
                <p>Sign in to continue</p>
                <p>Dont have an account?? <a href="signup.jsp">Click Here</a></p>
                <form method="post">
                    <label>I am</label>
                    <div class="radio-group">
                        <input type="radio" id="buyer" name="role" value="buyer" required>
                        <label for="buyer">Buyer</label>
                        <input type="radio" id="seller" name="role" value="seller" required>
                        <label for="seller">Seller</label>
                        <input type="radio" id="admin" name="role" value="admin" required>
                        <label for="admin">Admin</label>
                    </div>

                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>

                    <button type="submit">Login</button>
                </form>
                <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    Connection con = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        // Load JDBC Driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Retrieve parameters from request
                        String email = request.getParameter("email");
                        String password = request.getParameter("password");
                        String role = request.getParameter("role");

                        // Establish Connection
                        con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

                        // Prepare SQL query
                        String query = "SELECT user_id, password FROM users WHERE email = ? AND role = ?";
                        pstmt = con.prepareStatement(query);
                        pstmt.setString(1, email);
                        pstmt.setString(2, role);

                        // Execute Query
                        rs = pstmt.executeQuery();

                        // Check if user exists and password matches
                        if (rs.next() && rs.getString("password").equals(password)) {
                            int userId = rs.getInt("user_id");
                            // Redirect based on role
                            if ("buyer".equalsIgnoreCase(role)) {
                                response.sendRedirect("available_properties.jsp?user_id=" + userId);
                            } else if ("seller".equalsIgnoreCase(role)) {
                                response.sendRedirect("seller_dashboard.jsp?user_id=" + userId);
                            } else if ("admin".equalsIgnoreCase(role)) {
                                response.sendRedirect("admin_dashboard.jsp?user_id=" + userId);
                            }
                        } else {
            %>
                    <script>
                        alert('Invalid email, password, or role. Please try again.');
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
                }
            %>
            </div>
        </div>
    </body>

    </html>