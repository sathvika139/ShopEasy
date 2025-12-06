<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders - ShopEasy</title>
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

        .order-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 1rem;
        }

        .order-id {
            font-size: 1.2rem;
            font-weight: bold;
            color: #667eea;
        }

        .order-status {
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.9rem;
        }

        .status-confirmed {
            background: #d4edda;
            color: #155724;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .detail-item {
            padding: 0.5rem;
        }

        .detail-label {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 0.3rem;
        }

        .detail-value {
            font-weight: bold;
            color: #2c3e50;
        }

        .order-items {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
        }

        .order-items h4 {
            margin-bottom: 0.5rem;
            color: #667eea;
        }

        .item-row {
            padding: 0.5rem 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .item-row:last-child {
            border-bottom: none;
        }

        .order-total {
            text-align: right;
            font-size: 1.3rem;
            font-weight: bold;
            color: #e74c3c;
            margin-top: 1rem;
        }

        .no-orders {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
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
        <h1>Orders</h1>

        <%
            String message = request.getParameter("message");
            if (message != null && message.equals("success")) {
        %>
                <div class="alert alert-success">
                    🎉 Order placed successfully!
                </div>
        <%
            }

            String url = "jdbc:oracle:thin:@localhost:1521:XE";
            String username = "sathvika";
            String password = "123456";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            boolean hasOrders = false;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection(url, username, password);
                stmt = conn.createStatement();
                
                String sql = "SELECT o.id, o.order_date, o.total_amount, o.status, " +
                            "c.name as customer_name, c.email as customer_email " +
                            "FROM orders o " +
                            "JOIN customers c ON o.customer_id = c.id " +
                            "ORDER BY o.order_date DESC";
                            
                rs = stmt.executeQuery(sql);

                while(rs.next()) {
                    hasOrders = true;
                    int orderId = rs.getInt("id");
                    Date orderDate = rs.getDate("order_date");
                    double totalAmount = rs.getDouble("total_amount");
                    String status = rs.getString("status");
                    String customerName = rs.getString("customer_name");
                    String customerEmail = rs.getString("customer_email");

                    String statusClass = status.equalsIgnoreCase("Confirmed") ? "status-confirmed" : "status-pending";
        %>
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-id">Order #<%= orderId %></div>
                            <div class="order-status <%= statusClass %>"><%= status %></div>
                        </div>

                        <div class="order-details">
                            <div class="detail-item">
                                <div class="detail-label">Customer</div>
                                <div class="detail-value"><%= customerName %></div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Email</div>
                                <div class="detail-value"><%= customerEmail %></div>
                            </div>
                            <div class="detail-item">
                                <div class="detail-label">Order Date</div>
                                <div class="detail-value"><%= orderDate %></div>
                            </div>
                        </div>

                        <div class="order-items">
                            <h4>Order Items:</h4>
                            <%
                                PreparedStatement itemStmt = conn.prepareStatement(
                                    "SELECT oi.quantity, oi.price, p.name as product_name " +
                                    "FROM order_items oi " +
                                    "JOIN products p ON oi.product_id = p.id " +
                                    "WHERE oi.order_id = ?"
                                );
                                itemStmt.setInt(1, orderId);
                                ResultSet itemRs = itemStmt.executeQuery();

                                while(itemRs.next()) {
                                    String productName = itemRs.getString("product_name");
                                    int quantity = itemRs.getInt("quantity");
                                    double price = itemRs.getDouble("price");
                                    double itemTotal = quantity * price;
                            %>
                                    <div class="item-row">
                                        <%= productName %> - Qty: <%= quantity %> × $<%= String.format("%.2f", price) %> = $<%= String.format("%.2f", itemTotal) %>
                                    </div>
                            <%
                                }
                                itemRs.close();
                                itemStmt.close();
                            %>
                        </div>

                        <div class="order-total">
                            Total: $<%= String.format("%.2f", totalAmount) %>
                        </div>
                    </div>
        <%
                }

                if (!hasOrders) {
        %>
                    <div class="no-orders">
                        <h2>No orders yet</h2>
                        <p>Start shopping to see your orders here!</p>
                        <br>
                        <a href="products.jsp" style="color: #667eea; text-decoration: none; font-weight: bold;">Browse Products →</a>
                    </div>
        <%
                }

            } catch(Exception e) {
        %>
                <div class="alert alert-error">
                    Error loading orders: <%= e.getMessage() %>
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