<%@page import="entity.UserItem"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="entity.User"%>
<%@ page import="java.util.List"%>
<%@ page import="entity.Article"%>
<%@ page import="entity.Comment"%>
<%@ page import="entity.Reply"%>
<%@ page import="dao.UserDao"%>
<%
	User user = (User) session.getAttribute("user");
	if (user == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	User friend = (User) session.getAttribute("friend");
	if (friend == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	List<Article> articleList = (List<Article>) session.getAttribute("articleList");
%>
<html lang="zh-cn">
<head>
<title><%=friend.getNickname()%>的空间</title>
<link rel="stylesheet" type="text/css" href="./css/iconfont.css">
<link href="./css/35.css" rel="stylesheet">
<link href="./css/icenter-adg180416195621.css" rel="stylesheet">
<style id="mainJSBg" type="text/css">
.layim-chat-tool {
	position: relative;
	padding: 0 8px;
	height: 38px;
	line-height: 38px;
	font-size: 0;
}

.layim-chat-textarea {
	margin-left: 10px;
}

.layim-chat-tool span {
	position: relative;
	margin: 0 10px;
	display: inline-block;
	vertical-align: top;
	font-size: 24px;
	cursor: pointer;
}

.iconfont input {
	position: absolute;
	font-size: 0;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	opacity: .01;
	filter: Alpha(opacity = 1);
	cursor: pointer;
}

.background-container {
	background-repeat: no-repeat;
	background-position: center top;
	background-attachment: scroll;
	background-image: url(./css/qzone/space_item/orig/3/72019_top.jpg);
}

.bg-body {
	background-image: url(./css/qzone/space_item/orig/3/72019_bg.jpg);
	background-repeat: repeat;
}
</style>
<style id="mainJSTitleBar" type="text/css">
.layout-head-inner {
	height: 250px;
}
</style>
<style type="text/css" id="dynamicStyle">
.ownermode {
	display:;
}

.clientmode {
	display: none;
}

.editmode {
	display: none;
}

.customoff {
	display:;
}

.alphamode {
	display: none;
}
</style>
<style type="text/css" id="gdt-corner-css">
* {
	margin: 0;
	padding: 0
}

.j-corner {
	display: inline-block;
	width: 44px;
	overflow: hidden;
	transition: all 0.8s;
	cursor: pointer;
	position: absolute;
	right: 0;
	bottom: 0;
	z-index: 3;
}

.j-corner:hover {
	width: 92px;
}

.j-corner .tr {
	width: 100%;
	height: 18px;
	display: inline-block;
	background-image:
		url(//qzonestyle.gtimg.cn/gdt_ui_proj/dist/adpoly/logo-adsign/images/logo-bg-defalt.png);
	transform-origin: 0 18px;
	transition: all 0.6s ease;
	position: absolute;
	top: 0;
	left: 0;
}

.j-corner:hover .tr {
	width: 92px;
	height: 18px;
	display: inline-block;
	background-image:
		url(//qzonestyle.gtimg.cn/gdt_ui_proj/dist/adpoly/logo-adsign/images/logo-bg-open.png);
}

.j-corner .info {
	position: relative;
	z-index: 2;
	font-size: 12px;
	height: 18px;
	padding-left: 7px;
	line-height: 18px;
	white-space: nowrap;
	color: #fff;
}

.j-corner .text1, .text2 {
	display: inline-block;
	position: absolute;
	top: 0;
	left: 7px;
	height: 18px;
	transition: all 0.6s ease;
}

.j-corner .text1 {
	width: 44px;
	background:
		url(//qzonestyle.gtimg.cn/gdt_ui_proj/dist/adpoly/logo-adsign/images/logo-defalt.png)
		no-repeat 0 center;
	opacity: 1;
	filter: alpha(opacity = 100);
}

.j-corner:hover .text1 {
	opacity: 0;
	filter: alpha(opacity = 0);
}

.j-corner .text2 {
	width: 92px;
	background:
		url(//qzonestyle.gtimg.cn/gdt_ui_proj/dist/adpoly/logo-adsign/images/logo-open.png)
		no-repeat 0 center;
	opacity: 0;
	filter: alpha(opacity = 0);
}

.j-corner:hover .text2 {
	opacity: 1;
	filter: alpha(opacity = 100);
}
</style>
<style>
.control-tips.autohide {
	opacity: 0;
	visibility: hidden;
	cursor: default;
}

.j-videofeed-flashctn .control-tips {
	background-color: rgba(0, 0, 0, .5);
	pointer-events: auto;
	bottom: 54px;
	color: #fff;
	padding: 7px 0;
	width: 100px;
	text-align: center;
	border-radius: 3px;
	position: absolute;
	left: 50%;
	margin-left: -50px;
	display: block;
	transition: opacity .5s ease, visibility .5s ease;
	transition: none;
	visibility: visible;
}
</style>
<style type="text/css" id="vpjs-player-style">
.vpjs-fullscreen {
	width: 100% !important;
	height: 100% !important;
	padding-top: 0 !important;
}

.vpjs-fullscreen .vpjs-videoControlBar {
	z-index: 2147483647
}

.vpjs-playerContainer video::-webkit-media-controls-enclosure {
	display: none !important;
}

.vpjs-playerContainer video::-webkit-media-controls-start-playback-button
	{
	display: none !important;
}

.vpjs-playerContainer:-moz-full-screen {
	position: asbolute;
}

.vpjs-playerContainer .vpjs-fade {
	-webkit-transition: opacity 0.3s ease-in, visibility 0.2s ease-in;
	-moz-transition: opacity 0.3s ease-in, visibility 0.2s ease-in;
	-o-transition: opacity 0.3s ease-in, visibility 0.2s ease-in;
	transition: opacity 0.3s ease-in, visibility 0.2s ease-in;
}

.vpjs-playerContainer .vpjs-fadein {
	visibility: visible;
	opacity: 1;
}

.vpjs-playerContainer .vpjs-fadeout {
	visibility: hidden;
	opacity: 0;
}
</style>
</head>
<body class="os-winxp bg-body date-20180526" style="">
	<div class="background-container" id="layBackground">



		<div class="layout-head ">
			<div class="layout-head-inner" id="headContainer"
				style="background: no-repeat; height: 250px;">

				<div class="head-info">
					<h1 class="head-title" id="top_head_title">
						<span class="title-text ui-mr5"><%=friend.getNickname()%></span> <span
							class="qz_qzone_lv qz_qzone_lv_3 qz_qzone_no_2"
							title="当前空间等级：27级；积分：4220分"><span class="no"><b
								class="d2"></b><b class="d7"></b></span></span> <span
							class="qz-app-flag wing-fly"><i
							class="ui-icon icon-qzphone"></i></span>

					</h1>
					<div class="head-description">
						<span class="description-text" id="QZ_Space_Desc"></span>
					</div>
				</div>
				<div class="head-detail">
					<div class="head-detail-name">
						<span class="user-name textoverflow"><%=friend.getNickname()%></span>
						<span class="user-vip-info"> </span>

					</div>
					<div class="head-detail-info clearfix">
						<!-- 未开通黄钻的用户成长信息不可见 -->
						<div class="detail-info-level">
							<a id="diamon" data-year="" data-super="0"
								class="f_user_vip qz_ichotclick " target="_blank"
								href="http://pay.qq.com/ipay/index.shtml?n=12&amp;c=xxjzgw,xxjzghh&amp;aid=info.nickname&amp;ch=qdqb,kj"
								style="cursor: pointer;"> <i
								class="qz_vip_icon_l qz_vip_icon_l_gray_1"></i></a>
						</div>
						<div class="detail-info-con">
							<div class="qz-progress-bar  qz-progress-bar-gray">
								<div class="progress-bar-info">
									<span class="txt-value">成长值<b class="count">1</b></span><span
										class="txt-speed">成长速度<b class="count">-10点/天</b></span>
								</div>
								<div class="progress-bar-panel">


									<div class="progress-bar-count" style="width: 0%">
										<span class="count">0%</span>
									</div>
								</div>
							</div>
						</div>
						<div class="user-vip-info">
							<a class="qz-btn-vip qz-btn-vip-fee" title="续费黄钻"
								href="http://pay.qq.com/ipay/index.shtml?n=3&amp;c=xxjzgw,xxjzghh&amp;aid=info.nickname&amp;ch=qdqb,kj"
								target="_blank"></a>
						</div>
					</div>

				</div>

				<!--挂件-->
				<div class="layout-shop-item" id="QZ_Shop_Items_Container"
					style="z-index: 101;">
					<div class="shop-item" id="menuContainer"
						style="width: px; height: 32px; left: 150px; top: 252px;"
						reged="1">
						<div class="head-nav">
							<ul class="head-nav-menu">
								<li class="menu_item_N1"><span class="arr"></span><a
									href="javascript:;" title="主页" tabindex="1" accesskey="z">主页</a></li>
								<li class="menu_item_2"><span class="arr"></span><a
									href="javascript:;" title="日志" tabindex="1" accesskey="r">日志</a></li>
								<li class="menu_item_4"><span class="arr"></span><a
									href="javascript:;" title="相册" tabindex="1" accesskey="4">相册</a></li>
								<li class="menu_item_334"><span class="arr"></span><a
									href="javascript:;" title="留言板" tabindex="1">留言板</a></li>
								<li class="menu_item_311"><span class="arr"></span><a
									href="javascript:;" title="说说" tabindex="1" accesskey="6">说说</a></li>
								<li class="menu_item_1"><span class="arr"></span><a
									href="javascript:;" title="个人档" tabindex="1" accesskey="1">个人档</a></li>
								<li class="menu_item_305"><span class="arr"></span><a
									href="javascript:;" title="音乐" tabindex="1">音乐</a></li>
								<li class="menu_item_more"><span class="arr"></span><a
									href="javascript:;" title="更多" tabindex="1">更多</a></li>
							</ul>
						</div>
					</div>
					<div class="shop-item" id="visitorsDiv" data-left="750"
						data-top="186"
						style="top: 186px; left: 905px; width: 141px; height: 56px;">
						<div class="visit-module">
							<div class="other-info">
								<div class="today-wrapper">
									<p class="visit-today">
										今日访客<span class="count count-margin ">0</span>
									</p>
								</div>
								<div class="count-wrapper">
									<p class="visit-count">
										访客总量<span class="count ">6039</span>
									</p>
								</div>
								<i class="sn-count" style="display: none;"></i>
							</div>
							<i class="icon-visit icon-star-0" title=""></i>
						</div>
					</div>
				</div>


				<div class="actions profile-hd-actions" id="like_button_pannel">
					<span class="btn-head btn-head-like"> <a href="javascript:;"
						class="lnk-left" id="view_like_list" title="0人赞过"
						style="text-decoration: none;"> <s class="ui-icon sp-btn-like"></s>
							<span class="txt good-num">0</span> <span
							class="txt message-num none"></span>
					</a>
					</span>
				</div>

				<div id="flowerContainerDiv" class="layout-shop-item"></div>
			</div>
		</div>

		<div class="layout-nav">
			<div class="layout-nav-inner">
				<div class="head-avatar">
					<a id="QM_OwnerInfo_ModifyIcon" title="" href="javascript:;"> <img
						src="./head/<%=friend.getHeadportrait()%>" class="user-avatar"
						id="QM_OwnerInfo_Icon">
					</a>
				</div>
			</div>
		</div>
		<div class="layout-background">

			<div class="layout-body">

				<div id="pageContent" class="layout-page clearfix">

					<div id="main_feed_container" class="col-main ">
						<div class="col-main-feed">
							<%
								if (friend.getId() == user.getId()) {
							%>
							<div id="QM_Mood_Poster_Container" data-version="20131111">
								<div class="qz-poster  bg b-test" id="QM_Mood_Poster_Inner">
									<div id="QM_Mood_Poster_Container" data-version="20131111">
										<div class="qz-poster  bg qz-poster-active b-test"
											id="QM_Mood_Poster_Inner">
											<div class="qz-poster-inner qz-poster-2018-05-26">
												<form action="sendArticle" method="post"
													enctype="multipart/form-data">
													<div class="qz-poster-bd">
														<div class="qz-poster-editor-cont"
															id="qz_poster_v4_editor_container_1">
															<div class="qz-inputer bor2" data-version="20130625">
																<textarea id="content_textarea" style="width: 590px;"
																	name="content"></textarea>

															</div>

														</div>

													</div>
													<div class="qz-poster-ft">
														<div class="">
															<div class="qzaddons">
																<div class="layim-chat-tool">
																	<span id="icon-biaoqing" class="iconfont icon-biaoqing"
																		title="选择表情"></span> <span
																		class="iconfont icon-tupian" title="上传图片"> <input
																		type="file" id="uploadImg" name="uploadImg"
																		multiple="multiple" accept="image/*"></span> <span
																		class="iconfont icon-voice" title="发送语音"> <input
																		type="file" id="uploadVoice" name="uploadVoice"
																		accept="audio/*" multiple="multiple"></span> <span
																		class="iconfont icon-shipin" title="发送视频"> <input
																		type="file" id="uploadVideo" name="uploadViedo"
																		accept="video/*" multiple="multiple"></span>
																</div>
															</div>
															<div class="qzappwrap"></div>
														</div>

														<div class="qz-poster-sync">
															<div class="sync-nuts">
																<a class="sync-qq evt_click sync-qq-on" role="checkbox"
																	aria-checked="true" aria-disabled="false"
																	data-hottag="moodposter.syncqq"
																	href="javascript:void(0);" onclick="return false;"
																	title="同步至QQ签名" style=""><i class="icon icon-qq"></i></a><a
																	class="retweet-it evt_click" role="checkbox"
																	aria-checked="false" aria-disabled="false"
																	data-hottag="moodposter.retweetit"
																	onclick="return false;" href="javascript:void(0);"
																	title="同时转发" style="display: none"><i
																	class="icon icon-retweet"></i></a><a
																	class="sync-weibo evt_click sync-weibo-on"
																	role="checkbox" aria-checked="true"
																	aria-disabled="false"
																	data-hottag="moodposter.syncweibo"
																	href="javascript:void(0)" onclick="return false;"
																	title="同步至腾讯微博" style="display: none"><i
																	class="icon icon-weibo"></i></a><span class="dividor"
																	style="display: none">|</span><span
																	class="ui-checkbox ui-checkbox-tint js-private-comment"
																	title="" style="display: none"><input
																	type="checkbox" data-hottag="moodposter.private"
																	class="evt_click" id="private_checkbox_1"><label
																	for="private_checkbox_1">私密评论<i
																		class="ui-icon icon-diamond"></i></label></span><a
																	class="sync-timing evt_click" role="checkbox"
																	aria-checked="false" aria-disabled="false"
																	data-hottag="moodposter.timer"
																	href="javascript:void(0);" onclick="return false;"
																	title="发表为定时说说" style="display: none"><i
																	class="icon icon-timing"></i><span class="txt">定时说说</span></a>
																<div class="set-audience"
																	data-hottag="moodposter.secret" style="">
																	<span class="dividor c_tx3">|</span><span
																		class="private-label c_tx3">可见范围：</span><a
																		href="javascript:void(0);" class="audience c_tx3"
																		role="button" aria-haspop="true"><span
																		class="text-place">所有人可见</span><b
																		class="ui_trigbox ui_trigbox_b"><b
																			class="ui_trig c_tx3"></b><b
																			class="ui_trig ui_trig_up bor_bg"></b></b></a>
																</div>
															</div>



														</div>
														<div class="mod-say-authority none"></div>
														<div class="op">
															<input type="submit" class="btn-post gb_bt  evt_click"
																value="发表">
														</div>
														<div class="qz-poster-wall-con"></div>
														<div class="tmp-sync-list"></div>
													</div>
												</form>
												<div id="face-panel" class="layui-layim-face">
													<ul id="face-ul">
														<li title="[微笑]"><img src="/IM/images/face/0.gif"></li>
														<li title="[嘻嘻]"><img src="/IM/images/face/1.gif"></li>
														<li title="[哈哈]"><img src="/IM/images/face/2.gif"></li>
														<li title="[可爱]"><img src="/IM/images/face/3.gif"></li>
														<li title="[可怜]"><img src="/IM/images/face/4.gif"></li>
														<li title="[挖鼻]"><img src="/IM/images/face/5.gif"></li>
														<li title="[吃惊]"><img src="/IM/images/face/6.gif"></li>
														<li title="[害羞]"><img src="/IM/images/face/7.gif"></li>
														<li title="[挤眼]"><img src="/IM/images/face/8.gif"></li>
														<li title="[闭嘴]"><img src="/IM/images/face/9.gif"></li>
														<li title="[鄙视]"><img src="/IM/images/face/10.gif"></li>
														<li title="[爱你]"><img src="/IM/images/face/11.gif"></li>
														<li title="[泪]"><img src="/IM/images/face/12.gif"></li>
														<li title="[偷笑]"><img src="/IM/images/face/13.gif"></li>
														<li title="[亲亲]"><img src="/IM/images/face/14.gif"></li>
														<li title="[生病]"><img src="/IM/images/face/15.gif"></li>
														<li title="[太开心]"><img src="/IM/images/face/16.gif"></li>
														<li title="[白眼]"><img src="/IM/images/face/17.gif"></li>
														<li title="[右哼哼]"><img src="/IM/images/face/18.gif"></li>
														<li title="[左哼哼]"><img src="/IM/images/face/19.gif"></li>
														<li title="[嘘]"><img src="/IM/images/face/20.gif"></li>
														<li title="[衰]"><img src="/IM/images/face/21.gif"></li>
														<li title="[委屈]"><img src="/IM/images/face/22.gif"></li>
														<li title="[吐]"><img src="/IM/images/face/23.gif"></li>
														<li title="[哈欠]"><img src="/IM/images/face/24.gif"></li>
														<li title="[抱抱]"><img src="/IM/images/face/25.gif"></li>
														<li title="[怒]"><img src="/IM/images/face/26.gif"></li>
														<li title="[疑问]"><img src="/IM/images/face/27.gif"></li>
														<li title="[馋嘴]"><img src="/IM/images/face/28.gif"></li>
														<li title="[拜拜]"><img src="/IM/images/face/29.gif"></li>
														<li title="[思考]"><img src="/IM/images/face/30.gif"></li>
														<li title="[汗]"><img src="/IM/images/face/31.gif"></li>
														<li title="[困]"><img src="/IM/images/face/32.gif"></li>
														<li title="[睡]"><img src="/IM/images/face/33.gif"></li>
														<li title="[钱]"><img src="/IM/images/face/34.gif"></li>
														<li title="[失望]"><img src="/IM/images/face/35.gif"></li>
														<li title="[酷]"><img src="/IM/images/face/36.gif"></li>
														<li title="[色]"><img src="/IM/images/face/37.gif"></li>
														<li title="[哼]"><img src="/IM/images/face/38.gif"></li>
														<li title="[鼓掌]"><img src="/IM/images/face/39.gif"></li>
														<li title="[晕]"><img src="/IM/images/face/40.gif"></li>
														<li title="[悲伤]"><img src="/IM/images/face/41.gif"></li>
														<li title="[抓狂]"><img src="/IM/images/face/42.gif"></li>
														<li title="[黑线]"><img src="/IM/images/face/43.gif"></li>
														<li title="[阴险]"><img src="/IM/images/face/44.gif"></li>
														<li title="[怒骂]"><img src="/IM/images/face/45.gif"></li>
														<li title="[互粉]"><img src="/IM/images/face/46.gif"></li>
														<li title="[心]"><img src="/IM/images/face/47.gif"></li>
														<li title="[伤心]"><img src="/IM/images/face/48.gif"></li>
														<li title="[猪头]"><img src="/IM/images/face/49.gif"></li>
														<li title="[熊猫]"><img src="/IM/images/face/50.gif"></li>
														<li title="[兔子]"><img src="/IM/images/face/51.gif"></li>
														<li title="[ok]"><img src="/IM/images/face/52.gif"></li>
														<li title="[耶]"><img src="/IM/images/face/53.gif"></li>
														<li title="[good]"><img src="/IM/images/face/54.gif"></li>
														<li title="[NO]"><img src="/IM/images/face/55.gif"></li>
														<li title="[赞]"><img src="/IM/images/face/56.gif"></li>
														<li title="[来]"><img src="/IM/images/face/57.gif"></li>
														<li title="[弱]"><img src="/IM/images/face/58.gif"></li>
														<li title="[草泥马]"><img src="/IM/images/face/59.gif"></li>
														<li title="[神马]"><img src="/IM/images/face/60.gif"></li>
														<li title="[囧]"><img src="/IM/images/face/61.gif"></li>
														<li title="[浮云]"><img src="/IM/images/face/62.gif"></li>
														<li title="[给力]"><img src="/IM/images/face/63.gif"></li>
														<li title="[围观]"><img src="/IM/images/face/64.gif"></li>
														<li title="[威武]"><img src="/IM/images/face/65.gif"></li>
														<li title="[奥特曼]"><img src="/IM/images/face/66.gif"></li>
														<li title="[礼物]"><img src="/IM/images/face/67.gif"></li>
														<li title="[钟]"><img src="/IM/images/face/68.gif"></li>
														<li title="[话筒]"><img src="/IM/images/face/69.gif"></li>
														<li title="[蜡烛]"><img src="/IM/images/face/70.gif"></li>
														<li title="[蛋糕]"><img src="/IM/images/face/71.gif"></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<%
								}
							%>
							<div id="feed_friend">
								<div class="fn-feed-control-v2 clearfix">
									<div class="control-inner">
										<div class="feed-control-tab">
											<a id="feed_tab_hover" class="item-on item-on-slt"
												href="javascript:;"> <span id="feed_hover_text">全部动态</span>
												<i class="ui-icon icon-feed-down"></i>
											</a>
											<div class="qz-bubble tab-bubble" style="display: none;"
												id="friend_feed_control">
												<div class="bubble-i">
													<div class="op-list">
														<a id="feed_tab_all" class="item item-slt"
															href="javascript:;">全部动态</a> <a id="feed_tab_photo"
															class="item" href="javascript:;">相册</a> <a
															id="feed_tab_blog" class="item" href="javascript:;">日志</a>
														<a id="feed_tab_renzheng" class="item none"
															href="javascript:;">认证空间</a>
													</div>
												</div>
											</div>
										</div>
										<div class="feed-control-tab-op">
											<a id="feed_friend_refresh" title="刷新动态" href="javascript:;"
												class="item-left"><i class="ui-icon  icon-refresh-v9" id="refresh"></i></a>
											<span class="line"></span> <a id="feed_friend_set"
												title="动态设置" href="javascript:;" class="item-right"><i
												class="ui-icon  icon-set-v9"></i></a>
										</div>
									</div>
								</div>
								<div class="fn-feed-container">
									<div class="feed  feed-v9">
										<div class="feed_inner">
											<ul id="feed_friend_list">
												<%
													for (Article article : articleList) {
												%>
												<li class="f-single f-s-s"
													id="fct_2212913316_311_0_1527240674_0_1"><div
														class="f-single-head f-aside">
														<div class="f-adorn-top"></div>
														<div class="user-pto">
															<a href="zone?uid=<%=friend.getId()%>" target="_blank"
																class="user-avatar q_namecard f-s-a"
																link="nameCard_2212913316" data-clicklog="avatar"><img
																src="./head/<%=friend.getHeadportrait()%>"></a>
														</div>
														<div class="user-op">
															<a href="javascript:;" class="arrow-down"
																data-cmd="qz_opr_more" data-moreoperate="1"><i
																class="fui-icon icon-arrow-down"></i></a>
														</div>
														<div class="user-info">
															<div class="f-nick">
																<a target="_blank" href="zone?uid=<%=friend.getId()%>"
																	data-clicklog="nick" class="f-name q_namecard "
																	link="nameCard_<%=friend.getId()%>"><%=friend.getNickname()%></a>
															</div>
															<div class="info-detail">
																<span class=" ui-mr8 state"><%=article.getSendtime()%></span><a
																	href="javascript:;" data-cmd="qz_sign"
																	class="f-sign-show state" title="我也要设置"></a>
															</div>
														</div>
													</div>
													<div class="f-single-content f-wrap">
														<div class="f-item f-s-i"
															id="feed_2212913316_311_0_1527240674_0_1">
															<div class="f-info">
																<%=article.getContent()%>
															</div>
															<div class="qz_summary wupfeed"
																id="hex_2212913316_311_0_1527240674_0_1">
																<i class="none" name="feed_data"></i>
																<div class="f-ct ">
																	<div
																		class="f-ct-txtimg fui-txtimg   fui-imgbox-row-wrap">
																		<div class="txt-box "></div>
																		<div class="img-box img-box-row row-two">
																			<%
																				String[] imgs = article.getImg();
																					String[] voices = article.getVoice();
																					String[] videos = article.getVideo();
																					for (int i = 1; i < imgs.length; i++) {
																			%>
																			<a class="img-item  " href="./upload/<%=imgs[i]%>">
																				<img src="./upload/<%=imgs[i]%>"
																				style="margin-top: 0px; height: 279px; width: 284px;">
																			</a>
																			<%
																				}
																			%>
																			<%
																				for (int i = 1; i < voices.length; i++) {
																			%>
																			<a class="img-item  "
																				href="./upload/<%=voices[i]%>"> <audio
																					src="./upload/<%=voices[i]%>"
																					style="margin-top: 0px; height: 279px; width: 284px;"
																					controls='controls'></audio></a>
																			<%
																				}
																			%>
																			<%
																				for (int i = 1; i < videos.length; i++) {
																			%>
																			<a class="img-item  "
																				href="./upload/<%=videos[i]%>"> <video
																					src="./upload/<%=videos[i]%>"
																					style="margin-top: 0px; height: 279px; width: 284px;"
																					controls='controls'></video></a>
																			<%
																				}
																			%>
																		</div>
																	</div>
																	<div class="f-reprint">
																		<p class="item">
																			<i class="fui-icon icon-print-phone"></i><span
																				class="ui-mr8 state">来自&nbsp;<a
																				href="http://z.qzone.com?from=androidgrzxpl"
																				target="_blank" class=" phone-style state"></a>&nbsp;
																			</span>
																		</p>
																	</div>
																</div>
															</div>
														</div>
													</div>
													<div class="f-single-foot">
														<div class="f-op-detail f-detail content-line">
															<p class="op-list">
																<a class="item qz_retweet_btn " href="javascript:;"><i
																	class="fui-icon icon-op-share"></i></a><span
																	class="item-line"></span>&nbsp;<a href="javascript:;"
																	class=" qz_btn_reply item "><i
																	class="fui-icon icon-op-comment"></i></a>&nbsp;<span
																	class="item-line"></span><a
																	class="item qz_like_btn_v3 " data-islike="0"
																	href="javascript:;"><i
																	class="fui-icon icon-op-praise"></i></a>
															</p>
															<a href="javascript:;" class="state qz_feed_plugin">浏览106次</a>
														</div>
														<div class="f-ang-t"></div>
														<div class="f-like-list f-like _likeInfo" likeinfo="19">
															<div class="icon-btn">
																<a href="javascript:;" data-islike="0" data-likecnt="19"
																	class="praise qz_like_prase"><i
																	class="fui-icon icon-list-praise"></i></a>
																<div class="bubble" style="display: none;">
																	<div class="bd">+1</div>
																	<b class="arrow arrow-down"></b>
																</div>
															</div>
															<div class="user-list">
																<a href="" class="item q_namecard" target="_blank"
																	link="nameCard_2447503094 des_2447503094">张琴</a>、<a
																	href="" class="item q_namecard" target="_blank"
																	link="nameCard_541651006 des_541651006">莘浅</a>、<a
																	href="http://user.qzone.qq.com/564495705"
																	class="item q_namecard" target="_blank"
																	link="nameCard_564495705 des_564495705">淡然微笑</a>、<a
																	href="http://user.qzone.qq.com/625382006"
																	class="item q_namecard" target="_blank"
																	link="nameCard_625382006 des_625382006">三生<img
																	src="" title=""></a>、共<span class="f-like-cnt">19</span>人觉得很赞
															</div>
														</div>
														<div class="mod-comments" style="padding: 0">
															<div class="comments-list ">
																<ul>
																	<%
																		List<Comment> commentList = article.getCommentList();
																			for (Comment comment : commentList) {
																				UserItem commenter = new UserDao().findById(comment.getFrom_uid());
																	%>
																	<li class="comments-item bor3" data-type="commentroot"
																		data-tid="1" data-uin="2096417323" data-nick="月庭清歌"
																		data-who="1"><div class="comments-item-bd">
																			<div class="single-reply">
																				<div class="ui-avatar">
																					<a href="zone?uid=<%=commenter.getId()%>"
																						target="_blank"><img class="q_namecard"
																						alt="<%=commenter.getNickname()%>"
																						src="./head/<%=commenter.getHeadportrait()%>"></a>
																				</div>
																				<div class="comments-content" comment_id="<%=comment.getId()%>" to_uid="<%= comment.getFrom_uid()%>" to_name="<%= commenter.getNickname()%>">
																					<a class="nickname name c_tx q_namecard"
																						link="nameCard_<%=commenter.getId()%>"
																						target="_blank"
																						href="zone?uid=<%=commenter.getId()%>"><%=commenter.getNickname()%></a>&nbsp;
																					:
																					<%=comment.getContent()%>
																					<div class="comments-op">
																						<span class=" ui-mr10 state"> <%=comment.getSendtime()%></span><a
																							class="act-reply " href="javascript:;"><b
																							class="hide-clip">回复</b></a>
																					</div>
																				</div>
																			</div>
																			<div class="comments-list mod-comments-sub">
																				<ul>
																					<%
																						List<Reply> replyList = comment.getReplyList();
																								for (Reply reply : replyList) {
																									UserItem replyer = new UserDao().findById(reply.getFrom_uid());
																									UserItem replyto = new UserDao().findById(reply.getTo_uid());
																					%>
																					<li class="comments-item bor3"
																						data-type="replyroot" data-tid="1"
																						data-uin="<%=replyer.getId()%>"
																						data-nick="<%=replyer.getNickname()%>"
																						data-who="1"><div class="comments-item-bd">
																							<div class="single-reply">
																								<div class="ui-avatar">
																									<a href="zone?uid=<%=replyer.getId()%>"
																										target="_blank"><img class="q_namecard"
																										link="nameCard_1693357734 des_1693357734"
																										alt="<%=replyer.getNickname()%>"
																										src="./head/<%=replyer.getHeadportrait()%>"></a>
																								</div>
																								<div class="comments-content" comment_id="<%=comment.getId()%>" to_uid="<%= replyer.getId()%>" to_name="<%=replyer.getNickname()%>">
																									<a class="nickname name c_tx q_namecard"
																										link="nameCard_1693357734" target="_blank"
																										href="zone?uid=<%=replyer.getId()%>"><%=replyer.getNickname()%></a>&nbsp;回复<a
																										class="nickname name c_tx q_namecard"
																										link="nameCard_2096417323" target="_blank"
																										href="zone?uid=<%=replyto.getId()%>"><%=replyto.getNickname()%></a>&nbsp;
																									:
																									<%=reply.getContent()%>
																									<img src="" title="">
																									<div class="comments-op">
																										<span class=" ui-mr10 state"> <%=reply.getSendtime()%></span><a
																											class="act-reply " href="javascript:;"
																											data-cmd="qz_reply" data-version="6.4"
																											data-param="t1_source=&amp;t1_uin=1693357734&amp;t1_tid=a696ee648285095bb1a30000&amp;t2_uin=2096417323&amp;t2_tid=1&amp;subdotype=55802&amp;signin=0&amp;sceneid=100"
																											data-charset="utf-8" data-tuin=""
																											data-config="1|1|1|0|1,taotaoact.qzone.qq.com,@InputReply|1,taotaoact.qzone.qq.com,@ClickReply|1,taotaoact.qzone.qq.com,commentPresentClick"><b
																											class="hide-clip">回复</b></a>
																									</div>
																								</div>
																							</div>
																						</div></li>
																					<%
																						}
																					%>
																				</ul>
																			</div>
																		</div></li>
																	<%
																		}
																	%>
																</ul>
															</div>
															<div
																class="mod-commnets-poster feedClickCmd comment_default_inputentry"
																data-cmd="qz_reply" data-version="6"
																data-action="http://taotao.qq.com/cgi-bin/emotion_cgi_re_feeds"
																data-param="t1_source=&amp;t1_uin=2212913316&amp;t1_tid=a460e683e2d7075bf3420a00&amp;signin=0&amp;sceneid=100"
																data-charset="utf-8" data-maxlength=""
																data-tuin="2212913316"
																data-config="1|1|1|1,b52,with_fwd,同时转发;0|1,taotaoact.qzone.qq.com,@InputReply|1,taotaoact.qzone.qq.com,@ClickReply|1,taotaoact.qzone.qq.com,commentPresentClick"
																data-tid="">
																<div class="comments-poster-bd comments-poster-default">
																	<div class="comments-box" data-clicklog="comment">
																	<form action="comment">
																		<input hidden="hidden" name="article_id" value="<%= article.getId()%>">
																		<input hidden="hidden" name="friend_id" value="<%= friend.getId()%>">
																		<input class="textinput textinput-default bor2"
																			contenteditable="true" alt="replybtn"
																			placeholder="评论" style="width: 511px;" name="content">
																		<div class="mod-insert-img">
																			<input type="submit" id="commentBtn"
																				class="btn-post gb_bt  evt_click" value="发表">
																		</div>
																		</form>
																	</div>
																</div>
															</div>
														</div>
													</div></li>


												<%
													}
												%>
											</ul>
											<div style="visibility: visible;" id="feed_friend_tips"
												class="f-more-label">
												<div class="update-more check-more">
													<p class="b-line">
														<span class="state">数据加载中</span><img class="hot-loading"
															src="">
													</p>
												</div>
											</div>


										</div>
									</div>
								</div>
							</div>
						</div>


					</div>




				</div>



			</div>

		</div>


	</div>


	<div class="ui-tooltip" style="display: block;" id="g_reply_tips">
		<div class="inner">
			<div class="bd"></div>
			<b class="arrow arrow-down"></b>
		</div>
	</div>
	<div class="ui-tooltip" style="display: block;" id="g_delete_tips">
		<div class="inner">
			<div class="bd"></div>
			<b class="arrow arrow-down"></b>
		</div>
	</div>
	<input type="hidden" name="friendid" value="<%=friend.getId()%>" id="friendid">
	<script type="text/javascript">
		/* 表情按钮 */
		var biaoqing=document.getElementById("icon-biaoqing")
		if(biaoqing!=null){
			biaoqing.onclick = function() {

				var face_panel = document.getElementById("face-panel");
				if (face_panel.classList.contains("layui-layim-face-show")) {
					face_panel.classList.remove("layui-layim-face-show");
				} else {
					face_panel.classList.add("layui-layim-face-show");
				}
			};
			// // 点击表情

			var face_lis = document.getElementById("face-ul").children;
			for (var i = 0; i < face_lis.length; i++) {
				face_lis[i].onclick = function() {
					var face = event.currentTarget.getAttribute("title");
					document.getElementById("content_textarea").value += face;
				}
			}
		}
		

		
		
		var commentDivs=document.getElementsByClassName("comments-content");
		for(var i=0;i<commentDivs.length;i++){
			commentDivs[i].onclick=function(){
				
				reply(event.currentTarget);
			}
		}
		function reply(div) {
			var comment_id=div.getAttribute("comment_id");
			var to_uid=div.getAttribute("to_uid");
			var to_name=div.getAttribute("to_name");
			var content=prompt("回复 "+to_name+":", "");
			if (content!=null && content!="")
		    {
				var turnForm = document.createElement("form");   
			    //一定要加入到body中！！   
			    document.body.appendChild(turnForm);
			    turnForm.method = 'post';
			 	turnForm.action = 'reply';
			 	//创建隐藏表单
			 	var comment = document.createElement("input");
			 	comment.setAttribute("name","comment_id");
			 	comment.setAttribute("type","hidden");
			 	comment.setAttribute("value",comment_id);
			 	turnForm.appendChild(comment);
			 	//创建隐藏表单
			 	var to = document.createElement("input");
			 	to.setAttribute("name","to_uid");
			 	to.setAttribute("type","hidden");
			 	to.setAttribute("value",to_uid);
			 	turnForm.appendChild(to);
			 	//创建隐藏表单
			 	var friendid = document.getElementById("friendid");
			 	turnForm.appendChild(friendid);
			 	//创建隐藏表单
			 	var con = document.createElement("input");
			 	con.setAttribute("name","content");
			 	con.setAttribute("type","hidden");
			 	con.setAttribute("value",content);
			 	turnForm.appendChild(con);
			 	turnForm.submit();
			}
		}
		document.getElementById("refresh").onclick=function(){
			var uid=document.getElementById("friendid").value;
			window.location.href='zone?uid='+uid;
		}
	</script>



</body>
</html>