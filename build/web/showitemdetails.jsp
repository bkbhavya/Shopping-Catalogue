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
        StringBuffer displayBlock=new StringBuffer("<h1>My-Store Item Details</h1><br><h2>You are viewing</h2><br>");
        ItemDTO item=(ItemDTO)request.getAttribute("item");
        displayBlock.append("<h2><strong><a href='StoreControllerServlet'>"+item.getItemType()+"&gt;</a>"+item.getItemName()+"</strong></a></h2><br>");
        displayBlock.append("<div style='float:left;'>");
        displayBlock.append("<img src='images/"+item.getItemImage()+"'></div>");
        displayBlock.append("<div style='float:left;padding-left:12px'>");
        displayBlock.append("<p><strong><br/>"+item.getItemDesc()+"</p>");
        displayBlock.append("<p><strong>Price:</strong>Rs"+item.getItemPrice()+"</p>");
        displayBlock.append("<p><a href='addtocart.jsp?itemid="+item.getItemId()+"'>Add to Cart</a></p></div>");
        //here despite of itemid we cant send anything else so we send the  apllication object in the session which is the servletContext obj. but that isnt feasible becaused we dont know if the user will purchase it or not.
        displayBlock.append("<h4 id='logout'><a href='myorders.jsp'>My Orders</a>&nbsp;&nbsp;&nbsp;<a href='StoreControllerServlet?logout=logout'>LogOut</a></h4>");
        out.println(displayBlock);
         
        
        }
%>
    </body>
</html>