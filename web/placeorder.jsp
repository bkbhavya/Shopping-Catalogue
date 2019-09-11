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
        StringBuffer displayBlock=new StringBuffer("<h1>My-Cart Item Details</h1><br><em>You are viewing</em><br>");
        displayBlock.append("<div style='float:left;'>");
        Enumeration en=sess.getAttributeNames();
        displayBlock.append("<table border='1'>");
        displayBlock.append("<tr><th>Item Name</th></tr><th>Item Price</th></tr>");
        double totalAmount=0.0;
        while(en.hasMoreElements())
        {
            Object o=en.nextElement();
            if(o.equals("username")==false)
            {
            ItemDTO item =(ItemDTO)sess.getAttribute(o.toString());
            displayBlock.append("<tr><td>"+item.getItemName()+"</td>"+item.getItemPrice()+"</td></tr>");
            totalAmount+=item.getItemPrice();
            }
        }
        displayBlock.append("</table>");
        displayBlock.append("<p><strong>Total amount to be paid: Rs</strong>"+totalAmount+"</p>");
        displayBlock.append("<p><a href='StoreControllerServlet'>Continue Shopping</a>&nbsp;&nbsp;&nbsp;&nbsp;");
        displayBlock.append("<a href='checkout.jsp?totalAmount="+totalAmount+"'>CheckOut</a></p></div>");
       displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='LoginnControllerServlet?logout=logout'>LogOut</a></h4>");
        out.println(displayBlock);
        }
%>
    </body>
</html>