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
        StringBuffer displayBlock=new StringBuffer("<ul>");
        List<ItemInfoDTO> itemList=(List<ItemInfoDTO>)request.getAttribute("itemList");
        for(ItemInfoDTO obj:itemList)
        {
            displayBlock.append("<li id='"+obj.getItemId()+"'><a href='StoreControllerServlet?itemId="+obj.getItemId()+"'>"+obj.getItemName()+"</a></li>");
        }
        displayBlock.append("</ul>");
        out.println(displayBlock);
        System.out.println(displayBlock);
        }
%>        
    </body>
</html>