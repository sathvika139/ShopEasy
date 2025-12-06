<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Contact Messages</title></head>
<body>
<h1>All Contact Messages</h1>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","sathvika","123456");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT id, name, email, message, submitted_date FROM contact_messages ORDER BY submitted_date DESC");
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Message</th><th>Date</th>
        </tr>
<%
    while(rs.next()){
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("message") %></td>
            <td><%= rs.getDate("submitted_date") %></td>
        </tr>
<%
    }
} catch(Exception e) {
%>
    <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
} finally {
    if(rs!=null) try{rs.close();}catch(Exception e){}
    if(stmt!=null) try{stmt.close();}catch(Exception e){}
    if(conn!=null) try{conn.close();}catch(Exception e){}
}
%>
    </table>
</body>
</html>
