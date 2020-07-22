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
        StringBuffer displayBlock=new StringBuffer("");
        Boolean ans=(Boolean)request.getAttribute("ans");
        if(ans==true)
        {
            displayBlock.append("User Deleted successfully!!");
        }
        else if(ans==false)
        {
            displayBlock.append("User Deletetion Unsuccessful. Please try again!");
        } 
        out.println(displayBlock);
        System.out.println(displayBlock);
        }
%>
    </body>
</html>