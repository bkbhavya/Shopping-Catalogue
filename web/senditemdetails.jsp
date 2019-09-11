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
        ItemDTO item=(ItemDTO)request.getAttribute("itemDetails");
        String[] myarr=new String[5];
        myarr[0]=item.getItemName();
        myarr[1]=item.getItemType();
        myarr[2]=item.getItemDesc();
        myarr[3]=item.getItemImage();
        myarr[4]=String.valueOf(item.getItemPrice());
        displayBlock.append(myarr);     
        System.out.println(myarr);
        out.println(displayBlock);
        System.out.println(displayBlock);
        }
%>
    </body>
</html>