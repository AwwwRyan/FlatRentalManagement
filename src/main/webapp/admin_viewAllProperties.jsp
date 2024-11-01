<%@ page import="java.sql.*" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Properties</title>
        <style>
            /* Your existing CSS here */
            
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                height: 100vh;
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
                color: white;
            }
            
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            
            .edit-btn,
            .back-btn {
                padding: 8px 12px;
                background-color: #d9534f;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                transition: background-color 0.3s;
                display: inline-block;
            }
            
            .edit-btn:hover,
            .back-btn:hover {
                background-color: #c9302c;
            }
            
            .back-btn {
                margin-top: 10px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2>Edit Properties</h2>

            <table>
                <tr>
                    <th>Property Name</th>
                    <th>Seller Name</th>
                    <th>Address</th>
                    <th>Price </th>
                    <th>Property Type</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>

                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    StringBuilder tableRows = new StringBuilder();

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");
                        stmt = conn.createStatement();
                        String sql = "SELECT p.property_id, p.property_name, u.name AS seller_name, p.address, p.price, p.property_type, p.status " +
                                     "FROM properties p " +
                                     "JOIN users u ON p.seller_id = u.user_id";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            tableRows.append("<tr>")
                                     .append("<td>").append(rs.getString("property_name")).append("</td>")
                                     .append("<td>").append(rs.getString("seller_name")).append("</td>")
                                     .append("<td>").append(rs.getString("address")).append("</td>")
                                     .append("<td>").append(rs.getDouble("price")).append("</td>")
                                     .append("<td>").append(rs.getString("property_type")).append("</td>")
                                     .append("<td>").append(rs.getString("status")).append("</td>")
                                     .append("<td><a href=\"edit_property_form.jsp?property_id=").append(rs.getInt("property_id")).append("\" class=\"edit-btn\">Edit</a></td>")
                                     .append("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
                    <%= tableRows.toString() %>
            </table>

            <a href="admin_dashboard.jsp" class="back-btn">Back to Dashboard</a>
        </div>
    </body>

    </html>