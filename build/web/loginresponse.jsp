<%-- 
    Document   : loginresponse
    Created on : 4 Jan, 2019, 12:31:25 PM
    Author     : devanshi
--%>

<%
boolean result=(Boolean)request.getAttribute("result");
String username=(String)request.getAttribute("username");
String usertype=(String)request.getAttribute("usertype");
if(result==true&&usertype.equalsIgnoreCase("CUSTOMER"))
{
    String url="StoreControllerServlet;jsessionid="+session.getId();
    out.println(url);
    HttpSession sess=request.getSession();
    sess.setAttribute("username",username);
}
if(result==true&&usertype.equalsIgnoreCase("ADMIN"))
{
    String url="AdminControllerServlet;jsessionid="+session.getId();
    out.println(url);
    HttpSession sess=request.getSession();
    sess.setAttribute("username",username);
}
else
out.println("error");
%>