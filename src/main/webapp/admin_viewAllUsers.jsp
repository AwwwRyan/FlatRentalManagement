<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Users</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            /* Light background */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            width: 100%;
            max-width: 900px;
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        
        h2 {
            margin-bottom: 20px;
            font-size: 26px;
            color: #0c0b0b;
            /* Darker text */
            text-align: center;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        table,
        th,
        td {
            border: 1px solid #ddd;
        }
        
        th,
        td {
            padding: 12px;
            text-align: left;
        }
        
        th {
            background-color: #d9534f;
            /* Header background color (red) */
            color: white;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .edit-btn {
            padding: 8px 12px;
            background-color: #d9534f;
            /* Button background color (red) */
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s;
        }
        
        .edit-btn:hover {
            background-color: #c9302c;
            /* Darker red on hover */
        }
        
        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #d9534f;
            /* Button background color (red) */
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s;
            margin-top: 10px;
        }
        
        .back-btn:hover {
            background-color: #c9302c;
            /* Darker red on hover */
        }
    </style>
</head>

<body>

    <div class="container">
        <h2>Edit Users</h2>

        <%@ page import="java.sql.*" %>
            <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");
                stmt = conn.createStatement();
                String sql = "SELECT user_id, name, email, phone, role FROM users WHERE role IN ('seller', 'buyer')";
                rs = stmt.executeQuery(sql);
        %>
                <table>
                    <tr>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                    <%
                while (rs.next()) {
                    StringBuilder row = new StringBuilder();
                    row.append("<tr>");
                    row.append("<td>").append(rs.getInt("user_id")).append("</td>");
                    row.append("<td>").append(rs.getString("name")).append("</td>");
                    row.append("<td>").append(rs.getString("email")).append("</td>");
                    row.append("<td>").append(rs.getString("phone")).append("</td>");
                    row.append("<td>").append(rs.getString("role")).append("</td>");
                    row.append("<td><a href=\"edit_user_form.jsp?user_id=").append(rs.getInt("user_id")).append("\" class=\"edit-btn\">Edit</a></td>");
                    row.append("</tr>");
                    out.print(row.toString());
                }
            %>
                </table>
                <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>

                    <a href="admin_dashboard.jsp" class="back-btn">Back to Dashboard</a>
    </div>

</body>

</html>