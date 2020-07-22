/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
   $("#registerbtn").click(function(){
       doTask();
   }); 
    $("#username").keypress(function(){
        doName();
    });
    $("#password").keypress(function(){
        doPass();
    });
});
var username,password,data,request,url,result;
function validate(){
    username=$("#username").val();
    password=$("#password").val();
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
    
    data={username:username,password:password}; 
    url="RegistrationControllerServlet";    
    request=$.post(url,data,processResponse);
    request.error(handleError);
    }
    function processResponse(responseText){
        ans=responseText;
        ans=ans.trim();
        if(ans==="uap")
        {
            $("#regresult").show(function(){
                $("#regresult").html("This user already exists.<br> Please login.<a href='login.html'>Login here</a>").css("color","red");
            });
        }
        else if(ans==="failure"){
            $("#regresult").show(function(){
                $("#regresult").html("Registration failed.<br> Please try again.<a href='register.html'>Register Here</a>").css("color","red");
            });
        }
        else if(ans==="success"){
            $("#regresult").show(function(){
                $("#regresult").html("Registration Successful.You can now login.<br><a href='login.html'>Login Here</a>").css("color","green");
            });
        }
        else
        {
            $("#regresult").show(function(){
                $("#regresult").text("Some error in server. Try again later.").css("color","red");
            });
        }
        
    }
    function doName(){
    if($("#regresult").is(":hidden"))
{
    return;
}
else
{
$("#regresult").hide();
}
}
function doPass(){
if($("#regresult").is(":hidden"))
{
    return;
}
else
{
$("#regresult").hide();
}
}
    
