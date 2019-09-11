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
        String itemId=request.getParameter("itemid");
        ItemDTO item=StoreDAO.getItemDetails(Integer.parseInt(itemId));
        sess.setAttribute(String.valueOf(item.getItemId()),item);
        StringBuffer displayBlock=new StringBuffer("<h1>My Store- Shopping Cart</h1>");
        displayBlock.append("<div style='float:left;'>");
        displayBlock.append("<span> Items in your Cart<br/></span>");
        displayBlock.append("<p><strong> Item Added successfully.</strong></p>");
        displayBlock.append("<p><strong> Item Id:</strong>"+item.getItemId()+"</p>");
        displayBlock.append("<p><strong> Item Name:</strong>"+item.getItemName()+"</p>");
        Enumeration en=session.getAttributeNames();
        int count=0;
        while(en.hasMoreElements())
        {
            ++count;
            en.nextElement();
        }
        displayBlock.append("<p><strong>Items in your cart:</strong>"+(count-1)+"</p>");
        displayBlock.append("<p><a href='StoreControllerServlet'>Continue Shopping</a>&nbsp;&nbsp;&nbsp;&nbsp;");
        displayBlock.append("<a href='placeorder.jsp'>Place Order</a></p></div>");
        displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='LoginnControllerServlet?logout=logout'>LogOut</a></h4>");
        out.println(displayBlock);
        }
%>
    </body>
</html>