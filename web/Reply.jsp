<%--
  Created by IntelliJ IDEA.
  User: Yitar
  Date: 2015/10/26
  Time: 3:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>

<%
  int id = Integer.parseInt(request.getParameter("id"));
  int rootid = Integer.parseInt(request.getParameter("rootid"));
%>
<html>
<head>
    <title></title>
</head>
<body>
<form action="ReplyOK.jsp" method="post">
  <input type="hidden" name="id" value="<%= id %>">
  <input type="hidden" name="rootid" value="<%= rootid %>">
  <table border="1">
    <tr>
      <td>
        <input type="text" name="title">
      </td>
    </tr>
    <tr>
      <td>
        <textarea cols="80" rows="12" name="cont"></textarea>
      </td>
    </tr>
    <tr>
      <td>
        <input type="submit" value="submit">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
