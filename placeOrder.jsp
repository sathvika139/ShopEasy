<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order - ShopEasy</title>
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

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .order-form {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 2rem;
        }

        .product-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #2c3e50;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }

        .btn-submit {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: bold;
            transition: transform 0.2s ease;
        }

        .btn-submit:hover {
            transform: scale(1.02);
        }

        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 1rem 0;
            margin-top: 3rem;
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
        <div class="order-form">
            <h1>Place Your Order</h1>

            <%
                String productId = request.getParameter("productId");
                String productName = request.getParameter("productName");
                String productPrice = request.getParameter("productPrice");

                if (productId != null && productName != null && productPrice != null) {
            %>
                    <div class="product-summary">
                        <h3>Product Details:</h3>
                        <p><strong>Product:</strong> <%= productName %></p>
                        <p><strong>Price:</strong> $<%= productPrice %></p>
                    </div>

                    <form action="processOrder.jsp" method="post">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="hidden" name="productPrice" value="<%= productPrice %>">

                        <div class="form-group">
                            <label for="customerId">Select Customer:</label>
                            <select id="customerId" name="customerId" required>
                                <option value="">-- Choose Customer --</option>
                                <%
                                    String url = "jdbc:oracle:thin:@localhost:1521:XE";
                                    String username = "sathvika";
                                    String password = "123456";

                                    try {
                                        Class.forName("oracle.jdbc.driver.OracleDriver");
                                        Connection conn = DriverManager.getConnection(url, username, password);
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT id, name, email FROM customers ORDER BY name");

                                        while(rs.next()) {
                                            int custId = rs.getInt("id");
                                            String custName = rs.getString("name");
                                            String custEmail = rs.getString("email");
                                %>
                                            <option value="<%= custId %>"><%= custName %> (<%= custEmail %>)</option>
                                <%
                                        }
                                        rs.close();
                                        stmt.close();
                                        conn.close();
                                    } catch(Exception e) {
                                        out.println("<option value=''>Error loading customers</option>");
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" min="1" value="1" required>
                        </div>

                        <button type="submit" class="btn-submit">Confirm Order</button>
                    </form>
            <%
                } else {
            %>
                    <p style="text-align: center; color: #e74c3c;">Invalid product information. Please go back to products page.</p>
                    <br>
                    <a href="products.jsp" style="display: block; text-align: center; color: #667eea;">Back to Products</a>
            <%
                }
            %>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 ShopEasy. All rights reserved.</p>
    </footer>
</body>
</html>