<%@page import="shoppingcatalog.dao.StoreDAO, java.text.*"%>
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
         StringBuffer displayBlock=new StringBuffer("<h1>My Store- My Orders</h1>");
        displayBlock.append("<div style='float:left;'>");
        //displayBlock.append("<span> Items in your Cart<br/></span>");
        ArrayList<OrderDTO> orderList=StoreDAO.getOrdersByCustomer(username);
        if(orderList.size()==0)
        {
         displayBlock.append("<span>You have not placed any orders yet.<br/></span>");   
        }
        else
        {
            SimpleDateFormat sdf=new SimpleDateFormat("dd-MMM-yyyy");
            displayBlock.append("<table border='1'>");
            displayBlock.append("<tr><th>Order Id</th><th>Order Amount</th><th>Order Date</th></tr>");
            for(OrderDTO o:orderList)
            {
               String dateStr=sdf.format(o.getOrderDate());
                displayBlock.append("<tr><td>"+o.getOrderId()+"</td><td>"+o.getOrderAmount()+"</td><td>"+dateStr+"</tr>");
            }  
        }
        displayBlock.append("</table>");
        displayBlock.append("<p><a href='StoreControllerServlet'>Show Categories</a></p></div>");
        displayBlock.append("<h4 id='logout'><a href='StoreControllerServlet?logout=logout'>LogOut</a></h4>");
        out.println(displayBlock);
        }
%>
    </body>
</html>