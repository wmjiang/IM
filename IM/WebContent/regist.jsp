<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>IM注册</title>
    <link rel="stylesheet" type="text/css" href="css/index-26a9f2339d.css">
</head>
<body>

<a class="logo" href="./images/logo.png" >IM</a>

<div id="side" class="side" style="background-image: url(./images/01-0.jpg);"></div>

<div class="top">
    <div class="item feedback">
        <a data-bind="click: feedback" href="">意见反馈</a>
    </div>
    <div class="item language-entry">
        <div>简体中文&nbsp;
            <img src="images/down.png" >
            <img src="images/up.png" style="display: none;">
        </div>
    </div>
    <div class="item mail-entry">
        <a  href="">
            邮箱帐号
        </a>
    </div>
    <div class="item qq-entry" style="display: none;">
        <a  href="">
            IM帐号
        </a>
    </div>

</div>
<div class="main-wraper">

    <div class="main" style="">
        <div class="form" autocomplete="off" style="display: block;">
            <div>
                <div class="welcome">
                    欢迎注册IM
                </div>
                <div class="header free-lianghao-entry">
                    <a >免费靓号</a>
                </div>
                <div class="header">每一天，乐在沟通。</div>
            </div>


            <form autocomplete="off" action="regist" method="post" id="form">

                <div class="input-area">
                    <div class="input-flags">
                        <div class="input-ok"  style="display: none;">
                        </div>
                    </div>
                    <div class="input-outer">
                        <input autocomplete="off" type="text" id="nickname" name="nickname" class="nickname" maxlength="24" tabindex="3" placeholder="昵称">
                    </div>
                    <div class="error-tips-wrap slideup">
                        <div class="error-tips" style="display: none;"></div>
                    </div>
                </div>
                <div class="input-area">

                    <div class="input-flags">
                        <div class="input-ok" style="display: none;">
                        </div>
                        <div href="" class="eye close" title="长按显示密码" style="display: block;">
                        </div>
                    </div>
                    <div class="input-outer">
                        <div class="password-raw" style="display: none;"></div>
                        <input autocomplete="off" type="password" id="password" name="password"  class="password" maxlength="16" tabindex="4" placeholder="密码">
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
                <div class="input-area">
                    <div class="input-flags">
                        <div class="input-ok"  style="display: none;">
                        </div>
                    </div>
                    <div class="input-outer">
                        <input autocomplete="off" type="text" id="phone" class="phone" name="phone" maxlength="24" tabindex="3" placeholder="手机号码">
                    </div>
                    <div class="error-tips-wrap slideup">
                        <div class="error-tips" style="display: none;"></div>
                    </div>
                </div>

                <div class="error-tips-wrap slideup">
                    <div class="error-tips" style="margin: 0px; display: none;"></div>
                </div>
                <div class="input-tips-wrap">
                    <div class="input-tips" data-bind="">
                        可通过该手机号
                        找回密码&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
       &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;已有账号，<a href="index.jsp">去登录</a>
                    </div>
                </div>

                <div>
                    <button id="regist" type="button" class="submit"  tabindex="8">立即注册</button>
                    <div class="error-tips-wrap slideup">
                        <div class="error-tips" data-bind="text: getNumTips, visible: getNumTips().length" style="display: none;"></div>
                    </div>
                </div>
                <div class="agreement">
                    <input type="checkbox" name="qzone" id="qzone" data-bind="checked: qzone">
                    <label for="qzone" class="checkbox">
                        <img src="images/checkbox_check.png">
                        <img src="images/checkbox_normal.png" style="display: none;">
                        &nbsp;同时开通IM空间</label>
                    <br>
                    <input type="checkbox" name="agree" id="agree" data-bind="checked: agree">
                    <label for="agree" class="checkbox">
                        <img src="images/checkbox_check.png">
                        <img src="images/checkbox_normal.png" style="display: none;">
                        &nbsp;我已阅读并同意相关服务条款和隐私政策</label>
                    &nbsp; <img src="images/up.png" style="display: none;">
                    <img src="images/down.png">
                    <div class="agreement-list" style="visibility: hidden; opacity: 0;">
                        <a target="_blank">
                            《IM号码规则》</a>
                        <a target="_blank">
                            《隐私政策》</a>
                        <a target="_blank" style="visibility: hidden;">
                            《IM空间服务协议》</a>
                    </div>
                </div>
            </form>
        </div>
        <%
        %>
        <div class="succ" style="display: none;">
            <div>
                <div class="succ-logo">
                </div>
                <div class="reg-succ">
                    注册成功
                </div>
            </div>

        </div>

        <div class="footer" style="">
            Copyright <span>
©</span>
            1998-

            Tencent All Rights Reserved
        </div>


    </div>
</div>





<script src="js/index.js"></script>

</body></html>