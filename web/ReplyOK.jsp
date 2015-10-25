<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.mysql.jdbc.jdbc2.optional.PreparedStatementWrapper" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>

<%--
  Created by IntelliJ IDEA.
  User: Yitar
  Date: 2015/10/26
  Time: 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int rootid = Integer.parseInt(request.getParameter("rootid"));
    String title = request.getParameter("title");
    String cont = request.getParameter("cont");
    cont = cont.replaceAll("\n", "<br>");

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
    Connection conn = DriverManager.getConnection(url);

    conn.setAutoCommit(false);

    String sql = "insert into article values (null, ?, ?, ?, ?, now(), 0)";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    Statement stmt = conn.createStatement();

    pstmt.setInt(1, id);
    pstmt.setInt(2, rootid);
    pstmt.setString(3, title);
    pstmt.setString(4, cont);
    pstmt.executeUpdate();

    stmt.executeUpdate("UPDATE article SET isleaf = 1 WHERE id = " + id);

    conn.commit();
    conn.setAutoCommit(true);

    pstmt.close();
    stmt.close();
    conn.close();

    response.sendRedirect("ShowArticleTree.jsp");
%>
<html>
<head>
    <title></title>
</head>
<body>
    <font color="red" size="7">
        OK!
    </font>
</body>
</html>
