<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - ShopEasy</title>
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
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

        h1 {
            text-align: center;
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 2rem;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .product-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(45deg, #f1f2f6, #ddd);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 4rem;
        }

        .product-name {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }

        .product-description {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
            min-height: 40px;
        }

        .product-stock {
            font-size: 0.85rem;
            color: #27ae60;
            margin-bottom: 0.5rem;
        }

        .product-price {
            font-size: 1.4rem;
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .btn-order {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: transform 0.2s ease;
        }

        .btn-order:hover {
            transform: scale(1.02);
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            text-align: center;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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
        <h1>Our Products</h1>

        <%
            String message = request.getParameter("message");
            if (message != null) {
                if (message.equals("success")) {
        %>
                    <div class="alert alert-success">Order placed successfully!</div>
        <%
                } else if (message.equals("error")) {
        %>
                    <div class="alert alert-error">Error placing order. Please try again.</div>
        <%
                }
            }
        %>

        <div class="product-grid">
        <%
            String url = "jdbc:oracle:thin:@localhost:1521:XE";
            String username = "sathvika";
            String password = "123456";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection(url, username, password);
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM products ORDER BY id");

                while(rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    String emoji = rs.getString("emoji");
                    String description = rs.getString("description");
                    int stock = rs.getInt("stock_quantity");
        %>
                    <div class="product-card">
                        <div class="product-image"><%= emoji != null ? emoji : "📦" %></div>
                        <div class="product-name"><%= name %></div>
                        <div class="product-description"><%= description != null ? description : "" %></div>
                        <div class="product-stock">Stock: <%= stock %> units</div>
                        <div class="product-price">$<%= String.format("%.2f", price) %></div>
                        <form action="placeOrder.jsp" method="post" style="margin: 0;">
                            <input type="hidden" name="productId" value="<%= id %>">
                            <input type="hidden" name="productName" value="<%= name %>">
                            <input type="hidden" name="productPrice" value="<%= price %>">
                            <button type="submit" class="btn-order">Order Now</button>
                        </form>
                    </div>
        <%
                }
            } catch(Exception e) {
        %>
                <div class="alert alert-error">
                    Error loading products: <%= e.getMessage() %>
                </div>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch(SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch(SQLException e) {}
                if (conn != null) try { conn.close(); } catch(SQLException e) {}
            }
        %>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 ShopEasy. All rights reserved.</p>
    </footer>
</body>
</html>