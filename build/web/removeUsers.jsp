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
        StringBuffer displayBlock=new StringBuffer("<div float='left padding-left='12px' border='solid 2px red'");
        ArrayList<String> users=(ArrayList<String>)request.getAttribute("users");
        Boolean ans=(Boolean)request.getAttribute("ans");
        if(ans==null)
        {
            displayBlock.append("<table border='2'><tr><th>Users Name</th><th>Remove Users</th></tr>");
            for(String user:users)
            {
                displayBlock.append("<tr><td>"+user+"</td><td><a href=\"AdminControllerServlet?userId="+user+"\">Remove</a></td></tr>");
            }
            displayBlock.append("</table></div>");
        }
        else if(ans==true)
        {
            displayBlock.append("<span> User Deleted successfully!</span>");
        }
        else if(ans==false)
        {
            displayBlock.append("<span> User Deletetion Unsuccessful. Please try again!</span>");
        } 
        out.println(displayBlock);
        System.out.println(displayBlock);
        }
%>
    </body>
</html>