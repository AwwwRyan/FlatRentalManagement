<%@ page import="java.sql.*" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Property Details - Javabrokers</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
                    display: flex;
                    justify-content: space-between;
                    margin: 20px;
                }

                .property-info {
                    width: 60%;
                    padding: 20px;
                    background-color: white;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }

                .booking-form {
                    width: 35%;
                    padding: 20px;
                    background-color: white;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }

                .booking-form h2 {
                    margin-bottom: 20px;
                }

                .booking-form input,
                .booking-form textarea {
                    width: 100%;
                    padding: 10px;
                    margin-bottom: 15px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                }

                .booking-form button {
                    background-color: #d9534f;
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 5px;
                    cursor: pointer;
                }

                .booking-form button:hover {
                    background-color: #c93c36;
                }
            </style>
        </head>

        <body>
            <header>
                <h1>Property Details</h1>
            </header>
            <div class="container">
                <div class="property-info">
                    <%
                int propertyId = Integer.parseInt(request.getParameter("property_id"));
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");
                    String query = "SELECT property_name, description, address, price, property_type, status, number_of_rooms, furnished_status, property_size FROM properties WHERE property_id = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, propertyId);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
            %>
                        <h2>
                            <%= rs.getString("property_name") %>
                        </h2><br>
                        <div class="property-description">
                            <p>
                                <%= rs.getString("description") %>
                            </p><br>
                            <p><strong>Address:</strong>
                                <%= rs.getString("address") %>
                            </p><br>
                            <p><strong>Price:</strong> ₹
                                <%= rs.getDouble("price") %>
                            </p><br>
                            <p><strong>Type:</strong>
                                <%= rs.getString("property_type") %>
                            </p><br>
                            <p><strong>Status:</strong>
                                <%= rs.getString("status") %>
                            </p><br>
                            <p><strong>Number of Rooms:</strong>
                                <%= rs.getString("number_of_rooms") %>
                            </p><br>
                            <p><strong>Furnished Status:</strong>
                                <%= rs.getString("furnished_status") %>
                            </p><br>
                            <p><strong>Property Size:</strong>
                                <%= rs.getDouble("property_size") %> sq ft</p>
                        </div>
                        <%
                    } else {
            %>
                            <p>Property not found.</p>
                            <%
                    }
                } catch (Exception e) {
            %>
                                <p>Error:
                                    <%= e.getMessage() %>
                                </p>
                                <pre>
                <%
                    e.printStackTrace(new java.io.PrintWriter(out));
                %>
            </pre>
                                <%
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                }
            %>
                </div>

                <div class="booking-form">
                    <h2>Book an Appointment</h2>
                    <form method="post">
                        <input type="hidden" name="property_id" value="<%= propertyId %>">
                        <input type="text" name="name" placeholder="Your Name" required>
                        <input type="email" name="email" placeholder="Your Email" required>
                        <input type="tel" name="phone" placeholder="Your Phone" required>
                        <input type="text" name="appointment_date" placeholder="YYYY-MM-DD" required>
                        <input type="text" name="appointment_time" placeholder="HH:MM:SS" required>
                        <textarea name="message" placeholder="Your Message" rows="4"></textarea>
                        <button type="submit">Submit</button>
                    </form>

                    <%
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    String name = request.getParameter("name");
                                    String email = request.getParameter("email");
                                    String phone = request.getParameter("phone");
                                    String appointmentDate = request.getParameter("appointment_date");
                                    String appointmentTime = request.getParameter("appointment_time");
                                    String message = request.getParameter("message");

                                    if (name != null && !name.isEmpty() &&
                                        email != null && !email.isEmpty() &&
                                        phone != null && !phone.isEmpty() &&
                                        appointmentDate != null && !appointmentDate.isEmpty() &&
                                        appointmentTime != null && !appointmentTime.isEmpty()) {

                                        try {
                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/flatrentalmanagement", "root", "root");

                                            // Convert date and time from text to SQL Date and Time
                                            Date sqlAppointmentDate = Date.valueOf(appointmentDate); // Format must be YYYY-MM-DD
                                            Time sqlAppointmentTime = Time.valueOf(appointmentTime); // Format must be HH:MM:SS

                                            String insertQuery = "INSERT INTO appointments (property_id, name, email, phone, appointment_date, appointment_time, message) " +
                                                                 "VALUES (?, ?, ?, ?, ?, ?, ?)";
                                            pstmt = con.prepareStatement(insertQuery);
                                            pstmt.setInt(1, propertyId);
                                            pstmt.setString(2, name);
                                            pstmt.setString(3, email);
                                            pstmt.setString(4, phone);
                                            pstmt.setDate(5, sqlAppointmentDate);
                                            pstmt.setTime(6, sqlAppointmentTime);
                                            pstmt.setString(7, message);

                                            int rowsAffected = pstmt.executeUpdate();
                                            if (rowsAffected > 0) {
                                                out.println("<p>Appointment booked successfully!</p>");
                                            } else {
                                                out.println("<p>Failed to book the appointment. Please try again.</p>");
                                            }
                                        } catch (Exception e) {
                                            out.println("<p>Error: " + e.getMessage() + "</p>");
                                            out.println("<pre>");
                                            e.printStackTrace(new java.io.PrintWriter(out));
                                            out.println("</pre>");
                                        } finally {
                                            if (pstmt != null) pstmt.close();
                                            if (con != null) con.close();
                                        }
                                    } else {
                                        out.println("<p>All fields are required. Please fill the form completely.</p>");
                                    }
                                }
                            %>
                </div>
            </div>
        </body>

        </html>