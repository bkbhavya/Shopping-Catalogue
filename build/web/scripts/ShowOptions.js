var showproduct;
var item,removediv,rediv,i,para,requestt,itemId;
var showproduct=["Add","Update","Delete"];
var showoption=[];
var showuser=["Remove"];
var showview=["Orders"];
var functioncall=[];
var productfunctions=["addProductFunction()","updateProductFunction()","deleteProductFunction()"];
var userfunction=["removeUserFunction()"];
var viewfunction=["viewOrderFunction()"];


function removeForm()
{
    removediv=document.getElementById("container");
    rediv=document.getElementById("productform");
    if(rediv!==null)
    {
        removediv.removeChild(rediv);
    }
}


function getOptionNames(itemType)
{
    item=itemType;
    para=document.getElementById(itemType);
    var span=para.getElementsByTagName("span")[0];
    var spantext=span.innerHTML.trim();
    if(spantext.indexOf("+")!==-1)
    {
        span.innerHTML="-"+itemType;
    }
    else if(spantext.indexOf("-")!==-1)
    {
        span.innerHTML="+"+itemType;
        $("#"+item+" .itemnames").hide("slow");
        removeForm();
        return;
    }
    showOptions();
}



function showOptions()
{
    var olddiv=para.getElementsByClassName("itemnames")[0];
    if(typeof olddiv!=='undefined')
    {
        para.removeChild(olddiv);
    }
    var newdiv=document.createElement("div");
    newdiv.setAttribute("class","itemnames");
    var newul=document.createElement("ul");
    if(item==="Products")
    {
        showoption=showproduct;
        functioncall=productfunctions;
    }
    else if(item==="Users")
    {
        showoption=showuser;
        functioncall=userfunction;
    }
    else if(item==="View")
    {
        showoption=showview;
        functioncall=viewfunction;
    }
    
    for(i=0;i<showoption.length;i++)
    {
        newul.innerHTML+="<li><a href='#' onclick='"+functioncall[i]+"'>"+showoption[i]+"</a></li>";
    }
    newdiv.appendChild(newul);
    para.appendChild(newdiv);
    $("#"+item+" .itemnames").hide();
    $("#"+item+" .itemnames").show("slow");
}

function addProductFunction()
{
    removeForm();
    var newdiv=document.createElement("div");
    newdiv.setAttribute("id","productform");
    newdiv.setAttribute("float","left");
    newdiv.setAttribute("padding-left","12px");
    newdiv.setAttribute("border","solid 2px red");
    newdiv.innerHTML="<h3>Add New Product</h3>";
    newdiv.innerHTML+="<form method='POST' enctype='multipart/form-data' id='fileUploadForm'><table border='2'><tr><th>Product Name:</th><td><input type='text' id='pname'></td></tr><tr><th>Product Type:</th><td><input type='text' id='ptype'></td></tr><tr><th>Product Price:</th><td><input type='text' id='pprice'></td></tr><tr><th>Product Desc:</th><td><input type='text' id='pdesc'></td></tr><tr><td colspan='2'><input type='file' name='files' value='Select Image'></td></tr><tr><th><input type='button' value='Add Product' onclick='addProduct()' id='addprd'></th><th><input type='reset' value='Clear' onclick='clearText()'></th></tr></table></form>";
    newdiv.innerHTML+="<span id='addresp'></span>";
    var addPrd=$("#container")[0];
    addPrd.appendChild(newdiv);
    $("#productform").hide();
    $("#productform").hide();
    $("#productform").fadeIn("3500");
}

function clearText()
{
    $("addresp").HTML("");
}

function addProduct()
{
    var form=$('#fileUploadForm')[0];
    var data=new FormData(form);//js has a class named as formdata which accepts a form in its constructor.In this form data firslty the image got attached. then we append the textual data in this.
    var pname=$("#pname").val();
    var ptype=$("#ptype").val();
    var pdesc=$("#pdesc").val();
    var pprice=$("#pprice").val();
    data.append("pname",pname);
    data.append("ptype",ptype);
    data.append("pdesc",pdesc);
    data.append("pprice",pprice);
    $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "AddNewProductControllerServlet",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                $("#addresp").html(data);
            },
            error: function (e) {
                $("#addresp").html(e.responseText);
            }
    } );
}

function updateProductFunction()
{
    removeForm();
    var newdiv=document.createElement("div");
    newdiv.setAttribute("id","productform");
    newdiv.setAttribute("float","left");
    newdiv.setAttribute("padding-left","12px");
    newdiv.setAttribute("border","solid 2px red");
    newdiv.innerHTML="<h3>Update Product</h3>";
    newdiv.innerHTML+="<form method='POST' enctype='multipart/form-data' id='fileUploadForm'><tr><th>Product Id:</th><td><select id='itemid' onchange='getItemId()'>";
    loadItemId();
    newdiv.innerHTML+="</select></td></tr><table border='2'><tr><th>Product Name:</th><td><input type='text' id='pname'></td></tr><tr><th>Product Type:</th><td><input type='text' id='ptype'></td></tr><tr><th>Product Price:</th><td><input type='text' id='pprice'></td></tr><tr><th>Product Desc:</th><td><input type='text' id='pdesc'></td></tr><tr><tr><td colspan='2'><input type='file' name='files' value='Select Image'></td></tr><th><input type='button' value='Update Product' onclick='updateProduct()' id='updprd'></th><th><input type='reset' value='Clear' onclick='clearText()'></th></tr></table></form>";
    newdiv.innerHTML+="<img id='image' align='middle' src=''>";
    newdiv.innerHTML+="<span id='addresp'></span>";
    var updPrd=$("#container")[0];
    updPrd.appendChild(newdiv);
    $("#productform").hide();
    $("#productform").fadeIn("3500");
}

function updateProduct()
{
    var form=$('#fileUploadForm')[0];
    var data=new FormData(form);
    var pname=$("#pname").val();
    var ptype=$("#ptype").val();
    var pdesc=$("#pdesc").val();
    var pprice=$("#pprice").val();
    data.append("pname",pname);
    data.append("ptype",ptype);
    data.append("pdesc",pdesc);
    data.append("pprice",pprice);
    data.append("id",itemId);
    data.append("prodop","update");
    $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "AddNewProductControllerServlet",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                $("#addresp").html(data);
            },
            error: function (e) {
                $("#addresp").html(e.responseText);
            }
    } );  
}

function deleteProductFunction()
{
    removeForm();
    var newdiv=document.createElement("div");
    newdiv.setAttribute("id","productform");
    newdiv.setAttribute("float","left");
    newdiv.setAttribute("padding-left","12px");
    newdiv.setAttribute("border","solid 2px red");
    newdiv.innerHTML="<h3>Delete Product</h3>";
    newdiv.innerHTML+="<form method='POST' enctype='multipart/form-data' id='fileUploadForm'><tr><th>Product Id:</th><td><select id='itemid' onchange='getItemId()'>";
    loadItemId();
    newdiv.innerHTML+="</select></td></tr><table border='2'><tr><th>Product Name:</th><td><input type='text' id='pname' disabled></td></tr><tr><th>Product Type:</th><td><input type='text' id='ptype' disabled></td></tr><tr><th>Product Price:</th><td><input type='text' id='pprice' disabled></td></tr><tr><th>Product Desc:</th><td><input type='text' id='pdesc' disabled></td></tr><tr><th><input type='button' value='Delete Product' onclick='deleteProduct()' id='delprd'></th><th><input type='reset' value='Clear' onclick='clearText()'></th></tr></table></form>";
    newdiv.innerHTML+="<img id='image' align='middle' src=''>";
    newdiv.innerHTML+="<span id='addresp'></span>";
    var delPrd=$("#container")[0];
    delPrd.appendChild(newdiv);
    $("#productform").hide();
    $("#productform").fadeIn("3500");
}

function deleteProduct()
{
    var data={id:itemId,prodop:"del"};
    var url="AddNewProductControllerServlet";   
    requestt=$.post(url,data,process);
    requestt.error(handleError);
}
function process(responseText)
{
    $("#addresp").HTML(responseText);
}

function getItemId()
{
    var formName=$("#fileUploadForm");
    itemId=formName.getElementsByTagName("select")[0].value;
    var reqstr="AdminControllerServlet?itemId="+itemId;
    requestt=$.get(reqstr,processResp);
    requestt.error(handleError);
   
}
function processResp(responseText)
{
    var myarr=[];
    myarr=responseText.trim();
    $("#pname").val(myarr[0]);
    $("#ptype").val(myarr[1]);
    $("#pprice").val(myarr[4]);
    $("#pdesc").val(myarr[2]);
    $("#image").attr("src","G:\\NetBeansProjects\\MyShoppingCatalogue\\web\\images\\"+myarr[3]);
    
}
function processResponse(responseText){
    $("#itemid").html(responseText);
}

function handleError(xhr,textStatus){
    if(textStatus === 'error')
        $("#addresp").text("An error occured during the request"+ xhr.status);
}

function loadItemId()
{
        var reqstr="AdminControllerServlet?str=getitemid";
        requestt=$.get(reqstr,processResponse);
        requestt.error(handleError);
}

function removeUserFunction()
{
    removeForm();
    var reqstr="AdminControllerServlet?removeUser=user";
    requestt=$.get(reqstr,processResponsee);
    $("#productform").hide();
    $("#productform").fadeIn("3500");
}

function processResponsee(responseText)
{
    var newdiv=document.createElement("div");
    newdiv.setAttribute("id","productform");
    newdiv.innerHTML+="<span id='addresp'></span>";
    var resp = responseText;
    resp = resp.trim();
    //$("#addresp").html(resp);
    newdiv.innerHTML = resp;
    var updPrd=$("#Users")[0];
    updPrd.appendChild(newdiv);
}
function viewOrderFunction()
{
    
}