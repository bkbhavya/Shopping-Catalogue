/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
   $("#loginbtn").click(function(){
       doTask();
   }); 
    $("#username").keypress(function(){
        doName();
    });
    $("#password").keypress(function(){
        doPass();
    });
});
var username,password,usertype,data,request,url,result,req;
function validate(){
    username=$("#username").val();
    password=$("#password").val();
    usertype=$("#usertype").val();
    if(username==="")
    {
        $("#sp1").show(function(){
         $("#sp1").text("UserName Required").css("color","red");
     }     
    );
    return false;
    }
    else if(password==="")
    {
        $("#sp2").show(function(){
         $("#sp2").text("Password Required").css("color","red");
     }
    );
     return false;
    }
    return true;
}

function doTask(){
    if(!validate())
    {
        return;
    }
    
    data={username:username,password:password,usertype:usertype}; 
    url="LoginnControllerServlet";    
    request=$.post(url,data,processResponse);
    request.error(handleError);
    }
    
    function processResponse(responseText){
        result=responseText;
        result=result.trim();
        if(result.indexOf("jsessionid")!==-1)
        {
            $("#loginresult").text("Login Accepted").css("color","green");
            setTimeout(login,3000); 
        }
        else if(result==="error")
        {
            $("#loginresult").text("Login Rejected.").css("color","red");
        }
        else
        {
           $("#loginresult").text("Some error in server. Try again later.").css("color","red"); 
        }
        
    }
    function login(){
        window.location=result;
    }
    function doName(){
    if($("#sp1").is(":hidden"))
{
    return;
}
else
{
$("#sp1").hide();
}
}
function doPass(){
if($("#sp2").is(":hidden"))
{
    return;
}
else
{
$("#sp2").hide();
}
}
    function handleError(xhr,textStatus){
    if(textStatus === 'error') 
      $("#loginresult").text('An error occurred during your request: ' +  xhr.status +""+xhr.showStatus);
}
