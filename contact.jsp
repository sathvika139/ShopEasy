<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - ShopEasy</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; color: #333; padding: 20px; }
        .container { max-width: 700px; margin: auto; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { text-align: center; color: #667eea; }
        .alert { padding: 10px; margin-bottom: 15px; border-radius: 5px; }
        .alert-success { background: #d4edda; color: #155724; }
        .alert-danger { background: #f8d7da; color: #721c24; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, textarea { width: 100%; padding: 8px; border-radius: 5px; border: 1px solid #ccc; }
        button { padding: 10px 20px; border: none; border-radius: 5px; background: #667eea; color: white; cursor: pointer; font-size: 1rem; }
        button:hover { background: #764ba2; }
    </style>
</head>
<body>
<div class="container">
    <h1>Contact Us</h1>

<%
if("POST".equalsIgnoreCase(request.getMethod())){
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    if(name != null && email != null && message != null &&
       !name.trim().isEmpty() && !email.trim().isEmpty() && !message.trim().isEmpty()){

        Connection conn = null;
        PreparedStatement pstmt = null;
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE","sathvika","123456");

            String sql = "INSERT INTO contact_messages(id, name, email, message, submitted_date, status) "
                       + "VALUES(contact_seq.NEXTVAL, ?, ?, ?, SYSDATE, 'New')";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, message);
            pstmt.executeUpdate();
%>
    <div class="alert alert-success">✓ Your message has been sent successfully!</div>
<%
        } catch(Exception e){
%>
    <div class="alert alert-danger">Error: <%= e.getMessage() %></div>
<%
        } finally {
            if(pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
            if(conn != null) try { conn.close(); } catch(Exception ex) {}
        }

    } else {
%>
    <div class="alert alert-danger">⚠ Please fill in all fields.</div>
<%
    }
}
%>

    <form method="POST" action="contact.jsp">
        <div class="form-group">
            <label>Name:</label>
            <input type="text" name="name" required>
        </div>
        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" required>
        </div>
        <div class="form-group">
            <label>Message:</label>
            <textarea name="message" rows="6" required></textarea>
        </div>
        <button type="submit">Send Message</button>
    </form>
</div>
</body>
</html>
