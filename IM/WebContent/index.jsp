<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>IM登录</title>
    <link rel="stylesheet" type="text/css" href="css/index-26a9f2339d.css">
</head>
<body>

<a class="logo" href="./images/logo.png">IM</a>

<div id="side" class="side" style="background-image: url(&quot;./images/01-2.jpg&quot;);"></div>

<div class="top">
    <div class="item feedback">
        <a data-bind="click: feedback" href="">意见反馈</a>
    </div>
    <div class="item language-entry">
        <div>简体中文&nbsp;
            <img src="images/down.png">
            <img src="images/up.png" style="display: none;">
        </div>
    </div>
    <div class="item mail-entry">
        <a href="">
            邮箱帐号
        </a>
    </div>
    <div class="item qq-entry" style="display: none;">
        <a href="">
            IM帐号
        </a>
    </div>

</div>
<div class="main-wraper">

    <div class="main" style="">
        <div class="form" autocomplete="off" style="display: block;">
            <div>
                <div class="welcome">
                    欢迎登录IM
                </div>
                <div class="header free-lianghao-entry">
                    <a>免费靓号</a>
                </div>
                <div class="header">每一天，乐在沟通。</div>
            </div>


            <form autocomplete="off" action="login" method="post">


                <div class="input-area">
                    <div class="input-flags">
                        <div class="input-ok" style="display: none;">
                        </div>
                    </div>
                    <div class="input-outer">
                        <input autocomplete="off" type="text" name="id" id="nickname" class="id" maxlength="24" tabindex="3" placeholder="IM号码">
                    </div>
                    <div class="error-tips-wrap slideup">
                        <div class="error-tips" style="display: none;"></div>
                    </div>
                </div>
                <div class="input-area">

                    <div class="input-flags">
                        <div class="input-ok" style="display: none;">
                        </div>
                        <div href="" class="eye close" title="长按显示密码" style="display: none;">
                        </div>
                    </div>
                    <div class="input-outer">
                        <div class="password-raw" style="display: none;"></div>
                        <input autocomplete="off" type="password" name="password" id="password" class="password" maxlength="16" tabindex="4" placeholder="密码">
                    </div>
                    <div class="password-tips-group slideup">
                        <div class="password-tips ok">
                            不能包括空格
                        </div>
                        <div class="password-tips">
                            长度为8-16个字符
                        </div>
                        <div class="password-tips">
                            必须包含字母、数字、符号中至少2种
                        </div>
                    </div>
                    <div class="error-tips-wrap slideup">
                        <div class="error-tips" style="display: none;"></div>
                    </div>
                </div>


                <div class="error-tips-wrap slideup">
                    <div class="error-tips" style="margin: 0px; display: none;"></div>
                </div>
                <div class="input-tips-wrap">
                    <div class="input-tips">
                        可通过手机号
                        找回密码     &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
       &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;还没有账号，<a href="regist.jsp">点击注册</a>
                    </div>
                    
                </div>

                <div>
                    <input id="get_acc" type="submit" class="submit" value="登录" tabindex="8">
                    <% 
                    String msg=(String)request.getAttribute("msg");
             		if(msg=="1"){
             			out.print("<div class='error-tips-wrap'><div class='error-tips'>&nbsp; &nbsp;账号或密码错误</div></div>");
             		}              
                    %>
                </div>
           
            </form>
        </div>
       <%
       		if(session.getAttribute("id")!=null){
       			String str="<div class='succ'><div><div class='succ-logo'></div><div class='reg-succ'>注册成功<br>请牢记IM号码:"+
       					session.getAttribute("id")+"<br/>请尽快登录</div></div></div>";
                    out.print(str);
                    }
       %>
        

        <div class="footer" style="">
            Copyright <span>
©</span>
            1998-2018

             All Rights Reserved
        </div>


    </div>
</div>





<script src="js/index.js"></script>

</body></html>