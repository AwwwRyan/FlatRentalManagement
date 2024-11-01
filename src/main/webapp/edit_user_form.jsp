<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit User</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #f8f9fa;
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
                    width: 500px;
                    text-align: center;
                }
                
                h2 {
                    color: #d9534f;
                    margin-bottom: 20px;
                }
                
                input[type="text"],
                input[type="email"],
                input[type="tel"],
                input[type="password"],
                select {
                    width: 100%;
                    padding: 10px;
                    margin: 10px 0;
                    border: 1px solid #ddd;
                    border-radius: 6px;
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
                <h2>Edit User</h2>
                <%
        int userId = Integer.parseInt(request.getParameter("user_id"));
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userName = "", userEmail = "", userPhone = "", userPassword = "";
        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish Connection
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

            // Prepare SQL query to fetch user details
            String query = "SELECT name, email, phone, password FROM users WHERE user_id = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);

            // Execute Query
            rs = pstmt.executeQuery();

            // Fetch user details
            if (rs.next()) {
                userName = rs.getString("name");
                userEmail = rs.getString("email");
                userPhone = rs.getString("phone");
                userPassword = rs.getString("password");
            } else {
        %>
                    <p>User not found.</p>
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
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");

            if (!password.equals(confirmPassword)) {
        %>
                                    <script>
                                        alert('Passwords do not match. Please try again.');
                                    </script>
                                    <%
            } else if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
        %>
                                        <script>
                                            alert('Invalid email format. Please try again.');
                                        </script>
                                        <%
            } else if (!phone.matches("^\\+?[0-9]{10,15}$")) {
        %>
                                            <script>
                                                alert('Invalid phone number. Please enter a valid number.');
                                            </script>
                                            <%
            } else {
                try {
                    // Establish Connection
                    con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

                    // Prepare SQL query to update user
                    String updateQuery = "UPDATE users SET name = ?, email = ?, phone = ?, password = ? WHERE user_id = ?";
                    pstmt = con.prepareStatement(updateQuery);
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, phone);
                    pstmt.setString(4, password);
                    pstmt.setInt(5, userId);

                    // Execute Update
                    int rowsUpdated = pstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        response.sendRedirect("admin_viewAllUsers.jsp");
                        return; // Ensure no further code is executed
                    } else {
        %>
                                                <script>
                                                    alert('Failed to update user. Please try again.');
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
        }
        %>
                                                            <form method="post">
                                                                <label for="name">Name</label>
                                                                <input type="text" id="name" name="name" value="<%= userName %>" required>

                                                                <label for="email">Email</label>
                                                                <input type="email" id="email" name="email" value="<%= userEmail %>" required>

                                                                <label for="phone">Phone</label>
                                                                <input type="tel" id="phone" name="phone" value="<%= userPhone %>">

                                                                <label for="password">New Password</label>
                                                                <input type="password" id="password" name="password" value="<%= userPassword %>" required>

                                                                <label for="confirm_password">Confirm New Password</label>
                                                                <input type="password" id="confirm_password" name="confirm_password" required>

                                                                <button type="submit">Update User</button>
                                                            </form>
            </div>
        </body>

        </html>