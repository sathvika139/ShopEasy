<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String productId = request.getParameter("productId");
    String customerId = request.getParameter("customerId");
    String quantity = request.getParameter("quantity");
    String productPrice = request.getParameter("productPrice");

    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String username = "sathvika";
    String password = "123456";

    Connection conn = null;
    PreparedStatement orderStmt = null;
    PreparedStatement orderItemStmt = null;
    PreparedStatement updateStockStmt = null;
    ResultSet generatedKeys = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, username, password);
        conn.setAutoCommit(false); // Start transaction

        // Calculate total amount
        double price = Double.parseDouble(productPrice);
        int qty = Integer.parseInt(quantity);
        double totalAmount = price * qty;

        // Insert into orders table
        String orderSql = "INSERT INTO orders (id, customer_id, total_amount, status) VALUES (orders_seq.NEXTVAL, ?, ?, 'Confirmed')";
        orderStmt = conn.prepareStatement(orderSql, new String[]{"id"});
        orderStmt.setInt(1, Integer.parseInt(customerId));
        orderStmt.setDouble(2, totalAmount);
        orderStmt.executeUpdate();

        // Get generated order ID
        generatedKeys = orderStmt.getGeneratedKeys();
        int orderId = 0;
        if (generatedKeys.next()) {
            orderId = generatedKeys.getInt(1);
        }

        // Insert into order_items table
        String orderItemSql = "INSERT INTO order_items (id, order_id, product_id, quantity, price) VALUES (order_items_seq.NEXTVAL, ?, ?, ?, ?)";
        orderItemStmt = conn.prepareStatement(orderItemSql);
        orderItemStmt.setInt(1, orderId);
        orderItemStmt.setInt(2, Integer.parseInt(productId));
        orderItemStmt.setInt(3, qty);
        orderItemStmt.setDouble(4, price);
        orderItemStmt.executeUpdate();

        // Update product stock
        String updateStockSql = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ?";
        updateStockStmt = conn.prepareStatement(updateStockSql);
        updateStockStmt.setInt(1, qty);
        updateStockStmt.setInt(2, Integer.parseInt(productId));
        updateStockStmt.executeUpdate();

        conn.commit(); // Commit transaction

        // Redirect to orders page with success message
        response.sendRedirect("orders.jsp?message=success");

    } catch(Exception e) {
        if (conn != null) {
            try {
                conn.rollback(); // Rollback on error
            } catch(SQLException se) {
                se.printStackTrace();
            }
        }
        response.sendRedirect("products.jsp?message=error");
    } finally {
        if (generatedKeys != null) try { generatedKeys.close(); } catch(SQLException e) {}
        if (orderItemStmt != null) try { orderItemStmt.close(); } catch(SQLException e) {}
        if (orderStmt != null) try { orderStmt.close(); } catch(SQLException e) {}
        if (updateStockStmt != null) try { updateStockStmt.close(); } catch(SQLException e) {}
        if (conn != null) try { conn.close(); } catch(SQLException e) {}
    }
%>