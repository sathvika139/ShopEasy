<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers - ShopEasy</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.1);
            border-radius: 4px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem;
            text-align: left;
            font-size: 1rem;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #e0e0e0;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .customer-count {
            text-align: center;
            margin-bottom: 1rem;
            font-size: 1.1rem;
            color: #666;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            text-align: center;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 1rem 0;
            margin-top: 3rem;
        }

        @media (max-width: 768px) {
            table {
                font-size: 0.9rem;
            }
            
            th, td {
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <div class="logo">🛍️ ShopEasy</div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="products.jsp">Products</a></li>
                <li><a href="customers.jsp">Customers</a></li>
                <li><a href="orders.jsp">Orders</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h1>Registered Customers</h1>

        <%
            String url = "jdbc:oracle:thin:@localhost:1521:XE";
            String username = "sathvika";
            String password = "123456";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            int customerCount = 0;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection(url, username, password);
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM customers ORDER BY id");

                // Count customers
                Statement countStmt = conn.createStatement();
                ResultSet countRs = countStmt.executeQuery("SELECT COUNT(*) as total FROM customers");
                if (countRs.next()) {
                    customerCount = countRs.getInt("total");
                }
                countRs.close();
                countStmt.close();
        %>
                <div class="customer-count">
                    <strong>Total Customers: <%= customerCount %></strong>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Registration Date</th>
                        </tr>
                    </thead>
                    <tbody>
        <%
                while(rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    Date createdDate = rs.getDate("created_date");
        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= email %></td>
                            <td><%= phone != null ? phone : "N/A" %></td>
                            <td><%= address != null ? address : "N/A" %></td>
                            <td><%= createdDate != null ? createdDate.toString() : "N/A" %></td>
                        </tr>
        <%
                }
        %>
                    </tbody>
                </table>
        <%
            } catch(Exception e) {
        %>
                <div class="alert alert-error">
                    Error loading customers: <%= e.getMessage() %>
                </div>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch(SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch(SQLException e) {}
                if (conn != null) try { conn.close(); } catch(SQLException e) {}
            }
        %>
    </div>

    <footer>
        <p>&copy; 2025 ShopEasy. All rights reserved.</p>
    </footer>
</body>
</html>