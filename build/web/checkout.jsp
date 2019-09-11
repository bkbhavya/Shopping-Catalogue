<%@page import="shoppingcatalog.dao.StoreDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,shoppingcatalog.dto.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" >
              <link rel="stylesheet" type="text/css" href="styles/stylesheet.css">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/ShowItems.js"></script>
        <title>Store Items</title>
    </head>
    <body>
        <%@include file="logo.html" %>
<%
    HttpSession sess=request.getSession();
    String username=(String)sess.getAttribute("username");
        if(username==null)
        {
            sess.invalidate();
                response.sendRedirect("accessdenied.html");
        }
        else 
        {
            String totalAmount=request.getParameter("totalAmount");
            StringBuffer displayBlock=new StringBuffer("<h1> My Store Checkout Page</h1>"); 
            displayBlock.append("<div style='float:left;'>");
        displayBlock.append("<span> <strong>Thank you for shopping with us!</strong><br/></span>");
        displayBlock.append("<p>Your total amount to be paid Rs "+totalAmount+" is processing.</p>");
        Enumeration en=sess.getAttributeNames();
        ArrayList<ItemDTO> item=new ArrayList<ItemDTO>();
        }
%>
    </body>
</html>