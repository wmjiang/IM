var check1=0;
var check2=0;
var check3=0;
//轮播图
var index=0;
var side=document.getElementById("side");
setInterval("change()",3000);
function change(){
    index=(index+1)%3;
    side.style.backgroundImage="url(./images/01-"+index+".jpg)";
}

//昵称

document.getElementById("nickname").onfocus=function(){
	check1=0;
    document.getElementsByClassName("error-tips-wrap")[0].classList.add("slideup");
}

document.getElementById("nickname").onblur=function(){
    document.getElementsByClassName("error-tips-wrap")[0].classList.remove("slideup");
    var nickname=document.getElementById("nickname").value;
    var tips=document.getElementsByClassName("error-tips")[0];
    tips.style.display="block";
    document.getElementsByClassName("input-ok")[0].style.display="none";
    if(nickname.indexOf(" ")!=-1)
        tips.innerHTML="不能包括空格";
    else if(nickname.value==null&&nickname.trim()=="")
        tips.innerHTML="输入不能为空";
    else{
        document.getElementsByClassName("error-tips-wrap")[0].classList.add("slideup");
        document.getElementsByClassName("input-ok")[0].style.display="block";
        check1=1;
    }
}
//password 获得焦点
document.getElementById("password").onfocus=function(){
    document.getElementsByClassName("password-tips-group")[0].classList.remove("slideup");
    document.getElementsByClassName("error-tips-wrap")[1].classList.add("slideup");
    check2=0;
}

//password 失去焦点
document.getElementById("password").onblur=function(){
    document.getElementsByClassName("password-tips-group")[0].classList.add("slideup");
    document.getElementsByClassName("error-tips-wrap")[1].classList.remove("slideup");
    var password=document.getElementById("password").value;
    var tips=document.getElementsByClassName("error-tips")[1];
    tips.style.display="block";
    document.getElementsByClassName("input-ok")[1].style.display="none";
    var num=0;
    if (password.search(/[0-9]/) != -1) {
        num ++
    }
    if (password.search(/[A-Z]/) != -1) {
        num ++
    }
    if (password.search(/[a-z]/) != -1) {
        num += 1;
    }
    if (password.search(/[^A-Za-z0-9]/) != -1) {
        num += 1;
    }
    if(password.indexOf(" ")!=-1)
        tips.innerHTML="不能包括空格";
        else if(password.value==null&&password.trim()=="")
        tips.innerHTML="密码不能为空";
        else if(password.length<8||password.length>16)
        tips.innerHTML="长度为8-16个字符";
    else if(num<2)
        tips.innerHTML="必须包含字母、数字、符号中至少2种";
    else{
        document.getElementsByClassName("error-tips-wrap")[1].classList.add("slideup");
        document.getElementsByClassName("input-ok")[1].style.display="block";
        check2=1;
    }

}
//phone
var phone=document.getElementById("phone");
if(phone!=null){
	phone.onfocus=function(){
    document.getElementsByClassName("error-tips-wrap")[2].classList.add("slideup");
    check3=0;
}}

if(phone!=null){
document.getElementById("phone").onblur=function(){
document.getElementsByClassName("error-tips-wrap")[2].classList.remove("slideup");
var phone=document.getElementById("phone").value;
var tips=document.getElementsByClassName("error-tips")[2];
tips.style.display="block";
    document.getElementsByClassName("input-ok")[2].style.display="none";
if(!(/^\d{11}$/.test(phone)))
    tips.innerHTML="手机号格式不正确";
else{
    document.getElementsByClassName("error-tips-wrap")[2].classList.add("slideup");
    document.getElementsByClassName("input-ok")[2].style.display="block";
    check3=1;    
}
}
}

var regist=document.getElementById("regist");
if(regist!=null){
	regist.onclick=function(){
	if(check1&&check2&&check3){
		document.getElementById("form").submit();
	}
       
}}