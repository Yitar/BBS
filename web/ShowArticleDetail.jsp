<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: Yitar
  Date: 2015/10/26
  Time: 3:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String strid = request.getParameter("id");
  int id = Integer.parseInt(strid);
  Class.forName("com.mysql.jdbc.Driver");
  String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
  Connection conn = DriverManager.getConnection(url);
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery("SELECT * FROM article WHERE id = "+ id);
%>
<html>
<head>
    <title></title>
</head>
<body>

<%
  if(rs.next()) {
%>
  <table border="1">
    <tr>
      <td>ID</td>
      <td><%= rs.getInt("id") %></td>
    </tr>
    <tr>
      <td>Title</td>
      <td><%= rs.getString("title") %></td>
    </tr>
    <tr>
      <td>Content</td>
      <td><%= rs.getString("cont") %></td>
    </tr>
  </table>
<a href="Reply.jsp?id=<%= rs.getInt("id") %>&rootid=<%= rs.getInt("rootid") %>">reply</a>
<%
  }
  rs.close();
  stmt.close();
  conn.close();
%>
</body>
</html>
