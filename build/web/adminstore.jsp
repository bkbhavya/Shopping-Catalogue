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
        StringBuffer displayBlock=new StringBuffer("");
        ArrayList<Integer>itemIdList=(ArrayList<Integer>)request.getAttribute("itemIdList");
        for(Integer itemId:itemIdList)
        {
            displayBlock.append("<option value=\""+itemId+"\">"+itemId+"</option>");
            System.out.println(itemId);
        }
        out.println(displayBlock);
        System.out.println(displayBlock);
        }
%>
    </body>
</html>