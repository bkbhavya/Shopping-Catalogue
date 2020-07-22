<%@page import="shoppingcatalog.dao.StoreDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,shoppingcatalog.dto.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" >
              <link rel="stylesheet" type="text/css" href="styles/stylesheet.css">
        <script type="text/javascript" src="scripts/jquery.js"></script>
        <script type="text/javascript" src="scripts/ShowOptions.js?v=1"></script>
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
        StringBuffer displayBlock=new StringBuffer("<h1>Admin Options</h1><br><em>Select a category to take an action.</em><br>");
        displayBlock.append("<div id='container'> </div>");
        displayBlock.append("<div id='created' <br>");
        String []options={"Products","Users","View"};
        for(String option:options)
        {
            displayBlock.append("<p id='"+option+"'><strong><a href='#' onclick=getOptionNames('"+option+"')><span>+"+option+"</span></a></strong></p>");
            displayBlock.append("<div id='"+option+"'></div>");
            System.out.println(option);
        }
        displayBlock.append("</div> ");
        displayBlock.append("<h4 id='logout'><a href='StoreControllerServlet?logout=logout'>LogOut</a></h4>");
        out.println(displayBlock);
        System.out.println(displayBlock);
        }
%>
    </body>
</html>