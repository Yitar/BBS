<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="sun.java2d.pipe.PixelDrawPipe" %>

<%!
    private void del(Connection conn, int id) {
        Statement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conn.createStatement();
            String sql = "select * from article where pid =" + id;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
               del(conn, rs.getInt("id"));
            }
            stmt.executeUpdate("DELETE FROM article WHERE id = " + id);
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
    int id = Integer.parseInt(request.getParameter("id"));
    int pid = Integer.parseInt(request.getParameter("pid"));

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
    Connection conn = DriverManager.getConnection(url);

    conn.setAutoCommit(false);

    del(conn, id);

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT count(*) FROM  article WHERE pid = "+ pid);
    rs.next();
    int count = rs.getInt(1);
    rs.close();

    if(count <= 0) {
        Statement stmtUpdate = conn.createStatement();
        stmtUpdate.executeUpdate("UPDATE article SET isleaf = 0 WHERE id = "+ pid );
    }

    conn.commit();
    conn.setAutoCommit(true);
    conn.close();

    response.sendRedirect("ShowArticleTree.jsp");
%>
