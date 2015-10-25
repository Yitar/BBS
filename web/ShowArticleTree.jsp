<%--
  Created by IntelliJ IDEA.
  User: Yitar
  Date: 2015/10/25
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Statement" %>

<%!
    String str = "";

    private void tree(Connection conn, int id, int level) {
        Statement stmt = null;
        ResultSet rs = null;
        String preStr = "----";

        try {
            stmt = conn.createStatement();
            String sql = "select * from article where pid =" + id;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                str += "<tr><td>" + rs.getInt("id") + "</td><td>" +
                        preStr + "<a href='ShowArticleDetail.jsp?id= "+ rs.getInt("id") + "'>" + "</a>" + "</td></tr>";
                if (rs.getInt("isleaf") != 0) {
                    tree(conn, rs.getInt("id"), level + 1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
                if (conn != null) {
                    conn.close();
                    conn = null;
                }
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
    }
%>

<%
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
    Connection conn = DriverManager.getConnection(url);
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM article WHERE pid = 0");
    while (rs.next()) {
        str += "<tr><td>" + rs.getInt("id") + "</td><td>" +
                "<a href='ShowArticleDetail.jsp?id= "+ rs.getInt("id") + "'>" + rs.getString("title") + "</a>" + "</td></tr>";
        if (rs.getInt("isleaf") != 0) {
            tree(conn, rs.getInt("id"), 1);
        }
    }
    rs.close();
    stmt.close();
    conn.close();
%>
<html>
<head>
    <title></title>
</head>
<body>
<table border="1">
    <%= str %>
    <% str = ""; %>
</table>
</body>
</html>