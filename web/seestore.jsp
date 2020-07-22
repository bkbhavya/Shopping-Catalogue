<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
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
            StringBuffer displayBlock=new StringBuffer("<h1>My Categories<h1><p> Select a category to see items</p>");
            List<String> itemList=(List)request.getAttribute("itemList");
            for(String itemType:itemList)
            {
                displayBlock.append("<p id='"+itemType+"'><strong><a href='#' onclick=getItemNames('"+itemType+"')><span>+"+itemType+"</span></a></strong></p>");
            }
            displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='StoreControllerServlet?logout=logout'>LogOut</a></h4>");
            out.println(displayBlock);
        }
%>
    </body>
</html>