<%@page import="com.google.gson.Gson"%>
<%@page import="entity.Message"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="entity.RecentItem"%>
<%@ page import="entity.User"%>
<%@ page import="entity.Friend"%>
<%@ page import="entity.FriendGroup"%>
<%@ page import="entity.GroupItem"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
	//未登录，跳转登录页面
	User user = (User) request.getAttribute("user");
	if (user == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	Map<Integer, Friend> friendsMap = (Map<Integer, Friend>) request.getAttribute("friendsMap");
	Map<Integer, GroupItem> groupItemMap = (Map<Integer, GroupItem>) request.getAttribute("groupItemMap");
%>

<!DOCTYPE html>
<head>
<title>IM</title>
<link rel="stylesheet" type="text/css" href="./css/mq.css">
<link rel="stylesheet" type="text/css" href="./css/iconfont.css">
<script src="js/jquery-3.3.1.min.js"></script>
</head>
<body class="black">
	<div id="bgAllImage">
		<img class="bgAllImage" src="img/bg/28.jpg">
	</div>
	<div class="wrap">
		<div id="main_container" style="display: block;">
			<div class="panel main-panel" id="panel-0"
				style="display: none; transition: -webkit-transform 0.4s cubic-bezier(0, 1, 0, 1); transform: translate3d(-100%, 0px, 0px);">
				<div id="panelBodyWrapper-0" class="panel_body_container"
					style="bottom: 50px;">
					<div id="panelBody-0" class="panel_body ">
						<div id="mainTopAll">
							<div class="accountHeader">
								<div class="avatar_wrap">
									<img
										src="${pageContext.request.contextPath}/head/<%=user.getHeadportrait() %>"
										width="40" height="40"> <span id="user_online_state"
										class="state_online"></span>
								</div>
								<span class="text_ellipsis user_nick"><%=user.getNickname()%></span>
								<span class="text_ellipsis user_shuoshuo"><%=user.getSignature()%></span>
								<div class="icons_list">
									<a href="https://qzone.qq.com" class="i_qzone" target="_blank"
										title="QQ空间">QQ空间</a> <a href="https://mail.qq.com"
										class="i_mail" target="_blank" title="QQ邮箱">QQ邮箱</a> <a
										href="http://t.qq.com" class="i_weibo" target="_blank"
										title="腾讯微博">腾讯微博</a> <a href="https://v.qq.com"
										class="i_video" target="_blank" title="腾讯视频">腾讯视频</a> <a
										href="http://www.qq.com" class="i_qqwebsite" target="_blank"
										title="腾讯网">腾讯网</a> <a href="https://y.qq.com" class="i_music"
										target="_blank" title="QQ音乐">QQ音乐</a> <a
										href="https://wallet.tenpay.com/web/" class="i_wallet"
										target="_blank" title="QQ钱包">QQ钱包</a> <a
										href="http://www.pengyou.com" class="i_pengyou"
										target="_blank" title="朋友网">朋友网</a> <a
										href="https://www.weiyun.com" class="i_weiyun" target="_blank"
										title="微云">微云</a>
								</div>
							</div>
							<div class="wallpaper-ctrl">
								<a href="###" class="wallpaperImg pre" id="wp-ctrl-pre"
									title="点击切换背景图片"> </a> <a href="###" class="wallpaperImg next"
									id="wp-ctrl-next" title="点击切换背景图片"> </a>
							</div>
						</div>
						<div class="panel selected" id="panel-1">
							<header id="panelHeader-1" class="panel_header">

								<h1 id="panelTitle-1" class="text_ellipsis padding_20">会话</h1>

							</header>

							<div id="panelBodyWrapper-1" class="panel_body_container"
								style="top: 45px;">
								<div id="panelBody-1" class="panel_body ">
									<div id="current_chat_scroll_area" class="scrollWrapper"
										style="overflow-y: auto;" cmd="void">
										<ul id="current_chat_list" class="list list_white"
											style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">

											<%
												List<RecentItem> recentItemList = (List<RecentItem>) request.getAttribute("recentItemList");
												for (RecentItem recentItem : recentItemList) {
											%>
											<li
												id="recent-item-<%=recentItem.getType() == 1 ? "group" : "friend"%>-<%=recentItem.getId()%>"
												class="list_item" _uin="<%=recentItem.getId()%>"
												_type="<%=recentItem.getType() == 1 ? "group" : "friend"%>"
												cmd="clickMemberItem"><a href="javascript:void(0);"
												class="avatar" cmd="clickMemberAvatar"
												_uin="<%=recentItem.getId()%>"
												_type="<%=recentItem.getType() == 1 ? "group" : "friend"%>">
													<%
														if (recentItem.getType() == 1) {
													%> <img
													src="${pageContext.request.contextPath}/head/<%=groupItemMap.get(recentItem.getId()).getHeadportrait() %>">
													<%
														} else {
													%> <img
													src="${pageContext.request.contextPath}/head/<%=friendsMap.get(recentItem.getId()).getHeadportrait() %>">
													<%
														}
													%>
											</a>
												<p class="member_nick recent_item text_ellipsis"
													id="userNick-<%=recentItem.getId()%>">
													<%
														if (recentItem.getType() == 1) {
													%>
													<%=groupItemMap.get(recentItem.getId()).getName()%>
													<%
														} else {
													%>
													<%=friendsMap.get(recentItem.getId()).getNickname()%>
													<%
														}
													%>
													<%
														//判断时间
															Timestamp time = recentItem.getLastTime();
															Date time1 = new Date(time.getTime());
															Date now = new Date();
															String stime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(time);
															if (new SimpleDateFormat("yyyy-MM-dd").format(time) == new SimpleDateFormat("yyyy-MM-dd").format(now)) {
																stime = new SimpleDateFormat("HH:mm").format(time);

															} else if (now.getDate() - time1.getDate() == 1) {
																stime = "昨天";
															}
													%>
													<span id="msgtime"><%=stime%></span>
												</p>

												<p
													id="recent-item-<%=recentItem.getType()%>-<%=recentItem.getId()%>-msg"
													class="member_msg text_ellipsis"><%=recentItem.getLastMsgContent()%>
													<span
														id="msgCount-<%=recentItem.getType() == 1 ? "group" : "friend"%>-<%=recentItem.getId()%>"
														class="msgCount"><%=recentItem.getCount()%></span>
												</p></li>
											<%
												}
											%>
										</ul>
									</div>
								</div>
								<ul id="pannelMenuList-1" class="pannel_menu_list">
								</ul>
							</div>

						</div>
						<div class="panel" id="panel-2" cmd="void">
							<header id="panelHeader-2" class="panel_header">

								<div id="panelLeftButton-2"
									class="btn btn_small btn_left btn_black contact_null_btn"
									cmd="clickLeftButton">
									<span id="panelLeftButtonText-2" class="btn_text">返回</span>
								</div>

								<h1 id="panelTitle-2" class="text_ellipsis padding_20">联系人</h1>

								<button id="panelRightButton-2"
									class="btn btn_small btn_right btn_black btn_search"
									cmd="clickRightButton">
									<span id="panelRightButtonText-2" class="btn_img"></span>
								</button>

							</header>

							<div id="panelBodyWrapper-2" class="panel_body_container"
								style="top: 45px;">
								<div id="panelBody-2" class="panel_body ">
									<div id="contactList" class="tab tab_animate member_tab">
										<ul id="memberTab" class="tab_head">
											<li cmd="clickMemberTab" param="friend" class="active">好友</li>
											<li cmd="clickMemberTab" param="group" class="">群</li>
											<li cmd="clickMemberTab" param="discuss" class="">通知</li>
										</ul>
										<ul class="tab_body member_tab_body">
											<li id="memberTabBody-friend" class="active">
												<div id="f_list_scroll_area" class="member_scroll_area"
													style="overflow: auto;">
													<ul id="friend_groupList"
														class="group_list member_group_list"
														style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">

														<%
															List<FriendGroup> friendsGroupList = (List<FriendGroup>) request.getAttribute("friendsGroupList");
															int i = 0;
															for (FriendGroup friendGroup : friendsGroupList) {
														%>
														<li class="list_group">
															<div id="groupTitle-<%=friendGroup.getFgid()%>"
																class="list_group_title list_group_white_title list_arrow_right"
																cmd="clickMemberGroup" param=<%=i++%>>
																<span class="friendGroupItem"
																	id="<%=friendGroup.getFgid()%>"><%=friendGroup.getFgname()%></span>
																<span class="onlinePercent"><%=friendGroup.getOnlineCount()%>/<%=friendGroup.getFriendList().size()%></span>
															</div>
															<ul id="groupBodyUl-<%=friendGroup.getFgid()%>"
																class="list_group_body list list_white catogory_List">

																<%
																	for (Friend friend : friendGroup.getFriendList()) {
																%>
																<li id='friend-item-friend-<%=friend.getId()%>'
																	class="list_item" _uin=<%=friend.getId()%>
																	_type="friend" cmd="clickMemberItem"><a
																	href="javascript:void(0);" class="avatar"
																	cmd="clickMemberAvatar" _uin=<%=friend.getId()%>
																	_type="friend"> <img
																		src="${pageContext.request.contextPath}/head/<%=friend.getHeadportrait()%>">



																</a>
																	<p class="member_nick"
																		id="userNick-<%=friend.getId()%>">

																		<%=friend.getNickname()%></p>

																	<p class="member_msg text_ellipsis">

																		<span class="member_state">[<%=friend.getStateid() == 1 ? "在线" : "离线"%>]
																		</span> <span class="member_signature"><%=friend.getSignature()%></span>
																	</p></li>

																<%
																	}
																%>


															</ul>
														</li>
														<%
															}
														%>
													</ul>
												</div>
											</li>
											<li id="memberTabBody-group" class="">
												<div id="group_list_scroll_area" class="member_scroll_area"
													style="overflow: auto;">
													<ul id="g_list" class="list list_white catogory_List"
														style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">

														<%
															for (GroupItem groupItem : groupItemMap.values()) {
														%>
														<li id="group-item-group-<%=groupItem.getGroupid()%>"
															class="list_item" _uin="<%=groupItem.getGroupid()%>"
															_type="group" cmd="clickMemberItem"><a
															href="javascript:void(0);" class="avatar"
															cmd="clickMemberAvatar"
															_uin="<%=groupItem.getGroupid()%>" _type="group"> <img
																src="${pageContext.request.contextPath}/head/<%=groupItem.getHeadportrait()%>">



														</a>
															<p class="member_nick"
																id="userNick-<%=groupItem.getGroupid()%>">

																<%=groupItem.getName()%></p>

															<p class="member_msg text_ellipsis"></p></li>

														<%
															}
														%>
													</ul>
												</div>
											</li>
											<li id="memberTabBody-discuss" class="">
												<div id="discuss_list_scroll_area"
													class="member_scroll_area" style="overflow: auto;">
													<ul id="d_list" class="list list_white catogory_List"
														style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
														<%
															List<Message> offlineApplyMsgList = (List<Message>) request.getAttribute("offlineApplyMsgList");
															for (Message message : offlineApplyMsgList) {
														%>
														<li id="discuss-item-discuss<%=message.getSenderid()%>"
															class="list_item"><a href='' class='avatar'><img
																src='head/default.jpg'></a>
															<p class='member_nick'><%=message.getSenderid()%>
																<select class='selectGroup'
																	id='selectGroup-<%=message.getSenderid()%>'>
																	<%
																		for (FriendGroup friendsGroup : friendsGroupList) {
																	%>
																	<option value=<%=friendsGroup.getFgid()%>><%=friendsGroup.getFgname()%></option>
																	<%
																		}
																	%>
																</select>
																<button class='accept'
																	id='accept-<%=message.getSenderid()%>'
																	onclick='acceptApply(<%=new Gson().toJson(message)%>,this)'>同意</button>
															</p>
															<p class='member_msg text_ellipsis'><%=message.getContent()%>
																<input class='remark'
																	id='remark-<%=message.getSenderid()%>' placeholder='备注'>
																<button class='refuse'
																	id='refuse-<%=message.getSenderid()%>'
																	onclick='refuseApply(<%=new Gson().toJson(message)%>,this)'>拒绝</button>
															</p> <%
 	}
 %> <%
 	List<Message> offlineJoinMsgList = (List<Message>) request.getAttribute("offlineJoinMsgList");
 	for (Message message : offlineJoinMsgList) {
 %>
														<li id="discuss-item-discuss<%=message.getSenderid()%>"
															class="list_item"><a href='' class='avatar'><img
																src='head/default.jpg'></a>
															<p class='member_nick'><%=message.getSenderid()%>
																申请加群
																<%=message.getTypeid()%>
																<button class='accept'
																	id='accept-group-<%=message.getSenderid()%>'
																	onclick='acceptJoinGroup(<%=new Gson().toJson(message)%>,this)'>同意</button>
															</p>
															<p class='member_msg text_ellipsis'><%=message.getContent()%>
																<button class='refuse'
																	id='refuse-group-<%=message.getSenderid()%>'
																	onclick='refuseJoinGroup(<%=new Gson().toJson(message)%>,this)'>拒绝</button>
															</p> <%
 	}
 %>
													</ul>
												</div>

											</li>

										</ul>
									</div>
								</div>
								<ul id="pannelMenuList-2" class="pannel_menu_list">
								</ul>
							</div>

						</div>
						<div class="panel" id="panel-3" cmd="void">
							<header id="panelHeader-3" class="panel_header">

								<h1 id="panelTitle-3" class="text_ellipsis padding_20">发现</h1>

							</header>

							<div id="panelBodyWrapper-3" class="panel_body_container"
								style="top: 45px; overflow: auto;">
								<div id="panelBody-3" class="panel_body plugin"
									style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
									<form id="createGroupForm">
									<ul id="plugin_list" class="clearfix">
											<p>创建群</p>
										<li id="qzone">
											群名字：<input name="name">
										</li>
											
										
										<li id="qmail" cmd="clickItem">
											群介绍：<input name="intro">
										</li>

										<li id="qq_portal" cmd="clickItem">
											群通知：<input name="notice">
										</li>
										<li id="createGroup" cmd="clickItem" >
											<input type="button" value="创建群" id="createGroupBtn">
										</li>
									</ul>
									</form>
									<form id="createFriendGroupForm">
									<ul id="plugin_list" class="clearfix">
											<p>创建分组</p>
										<li id="qzone">
											分组：<input name="fgname">
										</li>
										<li id="createGroup" cmd="clickItem" >
											<input type="button" value="创建分组" id="createFriendGroupBtn">
										</li>
									</ul>
									</form>
								</div>
								<ul id="pannelMenuList-3" class="pannel_menu_list">
								</ul>
							</div>

						</div>
						<div class="panel" id="panel-4" cmd="void">
							<header id="panelHeader-4" class="panel_header">

								<h1 id="panelTitle-4" class="text_ellipsis padding_20">设置</h1>

							</header>

							<div id="panelBodyWrapper-4" class="panel_body_container"
								style="top: 45px; overflow: auto;">
								<div id="panelBody-4" class="panel_body list_page setting"
									style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) translateZ(0px);">
									<div class="group">
										<div class="row clearfix">
											<div class="cloumn">
												<img class="avatar" src="head/<%=user.getHeadportrait()%>">
											</div>
											<div class="cloumn profile_title_setting">
												<div class="text_ellipsis profile_name row">§戏遇&amp;春雨</div>
												<span class="row profile_account" id="id"><%=user.getId()%></span>
											</div>
											<div id="online_state_setting" class="online_state_setting">
												<i id="main_icon" class="main_icon online_icon"></i><i
													class="down_arrow"></i>
												<ul style="display: none">
													<li cmd="clickState"><i class="online_icon"></i>在线</li>
													<li cmd="clickState"><i class="callme_icon"></i>Q我</li>
													<li cmd="clickState"><i class="away_icon"></i>离开</li>
													<li cmd="clickState"><i class="busy_icon"></i>忙碌</li>
													<li cmd="clickState"><i class="silent_icon"></i>静音</li>
													<li cmd="clickState"><i class="hidden_icon"></i>隐身</li>
													<li cmd="clickState"><i class="offline_icon"></i>离线</li>
												</ul>

											</div>
										</div>
									</div>


									<div class="group">
										<div class="row profile_signature">
											<span class="label">个性签名: </span> <span><%=user.getSignature()%></span>
										</div>

									</div>


									<div class="group clickAble" cmd="clickNotifySetting">
										<div class="row ">
											消息相关设置 <span class="more_icon"></span>
										</div>
									</div>

									<div class="group clickAble"  id="zoneBtn">
										<div class="row ">
											我的空间<span class="more_icon"></span>
										</div>
									</div>

									<div id="about_qq_all" class="group" style="display: none;">
										<div class="row ">
											<span class="label">当前版本</span> V1.0
										</div>
										<div class="row ">服务条款</div>
										<div class="row " cmd="clickFeedBack">
											帮助与反馈 <span class="more_icon"></span>
										</div>

									</div>

									<div class="group clickAble" cmd="clickLogout">
										<div class="row loginout">退出当前帐号</div>
									</div>
								</div>
								<ul id="pannelMenuList-4" class="pannel_menu_list">
								</ul>
							</div>

						</div>
					</div>
					<ul id="pannelMenuList-0" class="pannel_menu_list">
					</ul>
				</div>

				<footer id="panelFooter-0" class="">
					<nav id="nav_tab" cmd="void">
						<ul class="nav_tab_head">

							<li id="session" class="contact selected" cmd="clickNav"
								param="session"><a>
									<div class="icon"></div> <span>会话</span>
							</a></li>

							<li id="contact" class="conversation" cmd="clickNav"
								param="contact"><a>
									<div class="icon"></div> <span>联系人</span>
							</a></li>

							<li id="plugin" class="plugin" cmd="clickNav" param="plugin">
								<a>
									<div class="icon"></div> <span>发现</span>
							</a>
							</li>

							<li id="setting" class="setup" cmd="clickNav" param="setting">
								<a>
									<div class="icon"></div> <span>设置</span>
							</a>
							</li>

						</ul>
						<div class="wallpaper-ctrl">
							<a href="###" class="wallpaperImg pre" id="wp-ctrl-pre"
								title="点击切换背景图片" cmd="clickWPPre"> </a> <a href="###"
								class="wallpaperImg next" id="wp-ctrl-next" title="点击切换背景图片"
								cmd="clickWPNext"> </a>
						</div>
						<div class="suggestion">
							<a href="https://support.qq.com/discuss/513_1.shtml"
								target="_blank">意见反馈</a>
						</div>
					</nav>


				</footer>

			</div>
		</div>
		<div id="container" class="container" style="display: block;">
			<div class="panel chat-panel" id="panel-5" cmd="void"
				style="transition: -webkit-transform 0.4s cubic-bezier(0, 1, 0, 1); transform: translate3d(0px, 0px, 0px); display: none;">
				<header id="panelHeader-5" class="panel_header">

					<div id="panelLeftButton-5"
						class="btn btn_small btn_left btn_black btn_setting"
						cmd="clickLeftButton">
						<span id="panelLeftButtonText-5" class="btn_img"></span>
					</div>

					<h1 id="panelTitle-5" _uin="" _type=""
						class="text_ellipsis padding_20"></h1>

					<button id="panelRightButton-5"
						class="btn btn_small btn_right btn_black btn_setting"
						cmd="clickRightButton">
						<span id="panelRightButtonText-5" class="btn_text">关闭</span>
					</button>

				</header>

				<div id="panelBodyWrapper-5" class="panel_body_container"
					style="top: 45px; bottom: 102px; overflow-y: auto;">
					<div id="panelBody-5" class="panel_body chat_container"
						style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">


					</div>
					<ul id="pannelMenuList-5" class="pannel_menu_list"
						style="display: none;">
						<li cmd="viewMembers" class="viewMembers">
							<div class="menu_list_icon"></div> 群成员
						</li>

						<li cmd="viewInfo" class="viewInfo">
							<div class="menu_list_icon"></div> 群资料
						</li>

						<li cmd="viewRecord" class="viewRecord">
							<div class="menu_list_icon"></div> 聊天记录
						</li>
					</ul>
				</div>

				<footer id="panelFooter-5" class="chat_toolbar_footer">
					<div class="chat_toolbar">
						<div class="layim-chat-footer">
							<div class="layim-chat-tool">
								<span id="icon-biaoqing" class="iconfont icon-biaoqing" title="选择表情"></span>
								 <span class="iconfont icon-tupian" title="上传图片"> 
								 	<input type="file" id="uploadImg" name="uploadImg" multiple="multiple" accept="image/*" ></span> 
								<span	class="iconfont icon-voice" title="发送语音" > 
									<input	type="file" id="uploadVoice" name="uploadVoice" accept="audio/*"></span> 
								<span	class="iconfont icon-shipin" title="发送视频"> 
									<input	type="file" id="uploadVideo" name="uploadViedo" accept="video/*"></span> 
								<span class="iconfont icon-folder_icon" title="发送文件"> 
									<input type="file" id="uploadFile" name="uploadFile"></span>
							</div>
							<div class="layim-chat-textarea">
								<textarea id="chat_textarea"></textarea>
								<button id="send_chat_btn" class="btn  btn_blue" cmd="sendMsg">
									<span class="btn_text">发送</span>
								</button>
							</div>
						</div>
					</div>
				</footer>

			</div>
			<div class="panel profile-panel" id="panel-6" cmd="void"
				style="transition: -webkit-transform 0.4s cubic-bezier(0, 1, 0, 1); transform: translate3d(100%, 0px, 0px); display: none;">
				<header id="panelHeader-6" class="panel_header">

					<div id="panelLeftButton-6"
						class="btn btn_small btn_left btn_black btn_arrow_left"
						cmd="clickLeftButton">
						<span id="panelLeftButtonText-6" class="btn_text">2932832209</span>
					</div>

					<h1 id="panelTitle-6" class="text_ellipsis padding_20">详细资料</h1>

					<button id="panelRightButton-6"
						class="btn btn_small btn_right btn_black " cmd="clickRightButton">
						<span id="panelRightButtonText-6" class="btn_text">聊天记录</span>
					</button>

				</header>

				<div id="panelBodyWrapper-6" class="panel_body_container"
					style="top: 45px; bottom: 6px; overflow: auto; background: rgb(237, 237, 237);">
					<div id="panelBody-6" class="panel_body list_page"
						style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
					</div>
					<ul id="pannelMenuList-6" class="pannel_menu_list">
					</ul>
				</div>

				<footer id="panelFooter-6" class="profile-footer"> </footer>

			</div>
			<div class="panel member-panel" id="panel-7" cmd="void"
				style="transition: -webkit-transform 0.4s cubic-bezier(0, 1, 0, 1); transform: translate3d(100%, 0px, 0px); display: none;">
				<header id="panelHeader-7" class="panel_header">

					<div id="panelLeftButton-7"
						class="btn btn_small btn_left btn_black btn_arrow_left"
						cmd="clickLeftButton">
						<span id="panelLeftButtonText-7" class="btn_text">返回</span>
					</div>

					<h1 id="panelTitle-7" class="text_ellipsis padding_20">成员</h1>

				</header>

				<div id="panelBodyWrapper-7" class="panel_body_container"
					style="top: 45px;">
					<div id="panelBody-7" class="panel_body ">
						<div id="member_searchBar" class="search_wrapper">
							<div class="search_inner">
								<input id="member_searchInput" type="text" class="input_search"
									placeholder="搜索" autocapitalize="off">
								<button id="member_searchClear" class="searchClear"
									cmd="clearSearchWord"></button>
							</div>
						</div>
						<div id="member_search_container_scroll_area"
							class="scrollWrapper search" style="overflow: auto;">
							<div id="member_search_container" class="search_container"
								style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
								<ul id="member_search_result_list"
									class="list list_white catogory_List">
								</ul>
							</div>
						</div>
					</div>
					<ul id="pannelMenuList-7" class="pannel_menu_list">
					</ul>
				</div>

			</div>
			<div class="panel record-panel" id="panel-8" cmd="void"
				style="transition: -webkit-transform 0.4s cubic-bezier(0, 1, 0, 1); transform: translate3d(100%, 0px, 0px); display: none;">
				<header id="panelHeader-8" class="panel_header">

					<div id="panelLeftButton-8"
						class="btn btn_small btn_left btn_black btn_arrow_left"
						cmd="clickLeftButton">
						<span id="panelLeftButtonText-8" class="btn_text">返回</span>
					</div>

					<h1 id="panelTitle-8" class="text_ellipsis padding_20">聊天记录</h1>

				</header>

				<div id="panelBodyWrapper-8" class="panel_body_container"
					style="top: 45px; bottom: 50px;">
					<div id="panelBody-8" class="panel_body record_container"></div>
					<ul id="pannelMenuList-8" class="pannel_menu_list">
					</ul>
				</div>

				<footer id="panelFooter-8" class="record_toolbar_footer">
					<div>
						<a href="javascript:" class="record_pre_page" cmd="selectPrePage">&lt;</a>
						<input id="record_page_input" class="record_page_input" value="1">
						<span>/</span> <span id="record_total_count">3</span> <a
							href="javascript:" class="record_next_page" cmd="selectNextPage">&gt;</a>
					</div>
				</footer>

			</div>
			<div class="panel profile-panel" id="panel-notifySetting" cmd="void"
				style="transition: -webkit-transform 0.4s cubic-bezier(0, 1, 0, 1); transform: translate3d(100%, 0px, 0px); display: none;">
				<header id="panelHeader-notifySetting" class="panel_header">

					<div id="panelLeftButton-notifySetting"
						class="btn btn_small btn_left btn_black btn_arrow_left"
						cmd="clickLeftButton">
						<span id="panelLeftButtonText-notifySetting" class="btn_text">设置</span>
					</div>

					<h1 id="panelTitle-notifySetting" class="text_ellipsis padding_20">消息相关设置</h1>

				</header>

				<div id="panelBodyWrapper-notifySetting"
					class="panel_body_container" style="top: 45px; overflow: auto;">
					<div id="panelBody-notifySetting"
						class="panel_body list_page notify_setting"
						style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">
						<div class="group">
							<div class="row clearfix">
								<span class="label">声音</span> <label class="switch switch-white"
									cmd="clickVoiceSetting"> <input id="enableVoiceBtn"
									type="checkbox" checked=""> <span> </span></label>
							</div>
							<div class="row clearfix">
								<span class="label">消息浮窗</span> <label
									class="switch switch-white" cmd="clickNotificationSetting">
									<input id="enableNotificationBtn" type="checkbox" checked="">
									<span> </span>
								</label>
							</div>
						</div>

						<div class="group">
							<div class="row">
								<div class="clearfix">
									<span class="label">HTTPS</span> <label
										class="switch switch-white" cmd="clickHttpsSetting"> <input
										id="enableHttpsBtn" disabled="disabled" type="checkbox"
										checked=""> <span> </span></label>
								</div>
								<div class="tips">使用 HTTPS 加密聊天内容</div>
							</div>
						</div>

						<div class="group">
							<div class="row">
								<div class="clearfix">
									<span class="long_label">按Ctrl+Enter键发送消息</span> <label
										class="switch switch-white" cmd="clickCtrlEnterSetting">
										<input id="enableCtrlEnterBtn" type="checkbox"> <span>
									</span>
									</label>
								</div>
							</div>
						</div>

					</div>
					<ul id="pannelMenuList-notifySetting" class="pannel_menu_list">
					</ul>
				</div>

			</div>
			<div class="panel search-panel" id="panel-9" cmd="void"
				style="transition: -webkit-transform 0.4s cubic-bezier(0, 1, 0, 1); transform: translate3d(100%, 0px, 0px); display: none;">
				<header id="panelHeader-9" class="panel_header">

					<div id="panelLeftButton-9"
						class="btn btn_small btn_left btn_black btn_arrow_left"
						cmd="clickLeftButton">
						<span id="panelLeftButtonText-9" class="btn_text">联系人</span>
					</div>

					<h1 id="panelTitle-9" class="text_ellipsis padding_20">搜索</h1>

				</header>

				<div id="panelBodyWrapper-9" class="panel_body_container"
					style="top: 45px;">
					<div id="panelBody-9" class="panel_body ">
						<div id="searchBar" class="search_wrapper hascontent">
							<div class="search_inner">
								<input id="searchInput" type="text" class="searchInput"
									placeholder="添加 好友/ 群" autocapitalize="off">
								<button id="searchClear" class="searchClear"
									cmd="clearSearchWord"></button>
							</div>
							<button id="search" class="searchCancel" cmd="clearSearchWord">搜索</button>
						</div>
						<div id="search_container_scroll_area"
							class="scrollWrapper search" style="overflow: auto;">
							<div id="search_container" class="search_container"
								style="transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate(0px, 0px) scale(1) translateZ(0px);">

							</div>
						</div>
					</div>
					<ul id="pannelMenuList-9" class="pannel_menu_list">
					</ul>
				</div>

			</div>
		</div>
		<div id="face-panel" class="layui-layim-face">
				<ul id="face-ul">
					<li title="[微笑]"><img
						src="/IM/images/face/0.gif"></li>
					<li title="[嘻嘻]"><img
						src="/IM/images/face/1.gif"></li>
					<li title="[哈哈]"><img
						src="/IM/images/face/2.gif"></li>
					<li title="[可爱]"><img
						src="/IM/images/face/3.gif"></li>
					<li title="[可怜]"><img
						src="/IM/images/face/4.gif"></li>
					<li title="[挖鼻]"><img
						src="/IM/images/face/5.gif"></li>
					<li title="[吃惊]"><img
						src="/IM/images/face/6.gif"></li>
					<li title="[害羞]"><img
						src="/IM/images/face/7.gif"></li>
					<li title="[挤眼]"><img
						src="/IM/images/face/8.gif"></li>
					<li title="[闭嘴]"><img
						src="/IM/images/face/9.gif"></li>
					<li title="[鄙视]"><img
						src="/IM/images/face/10.gif"></li>
					<li title="[爱你]"><img
						src="/IM/images/face/11.gif"></li>
					<li title="[泪]"><img
						src="/IM/images/face/12.gif"></li>
					<li title="[偷笑]"><img
						src="/IM/images/face/13.gif"></li>
					<li title="[亲亲]"><img
						src="/IM/images/face/14.gif"></li>
					<li title="[生病]"><img
						src="/IM/images/face/15.gif"></li>
					<li title="[太开心]"><img
						src="/IM/images/face/16.gif"></li>
					<li title="[白眼]"><img
						src="/IM/images/face/17.gif"></li>
					<li title="[右哼哼]"><img
						src="/IM/images/face/18.gif"></li>
					<li title="[左哼哼]"><img
						src="/IM/images/face/19.gif"></li>
					<li title="[嘘]"><img
						src="/IM/images/face/20.gif"></li>
					<li title="[衰]"><img
						src="/IM/images/face/21.gif"></li>
					<li title="[委屈]"><img
						src="/IM/images/face/22.gif"></li>
					<li title="[吐]"><img
						src="/IM/images/face/23.gif"></li>
					<li title="[哈欠]"><img
						src="/IM/images/face/24.gif"></li>
					<li title="[抱抱]"><img
						src="/IM/images/face/25.gif"></li>
					<li title="[怒]"><img
						src="/IM/images/face/26.gif"></li>
					<li title="[疑问]"><img
						src="/IM/images/face/27.gif"></li>
					<li title="[馋嘴]"><img
						src="/IM/images/face/28.gif"></li>
					<li title="[拜拜]"><img
						src="/IM/images/face/29.gif"></li>
					<li title="[思考]"><img
						src="/IM/images/face/30.gif"></li>
					<li title="[汗]"><img
						src="/IM/images/face/31.gif"></li>
					<li title="[困]"><img
						src="/IM/images/face/32.gif"></li>
					<li title="[睡]"><img
						src="/IM/images/face/33.gif"></li>
					<li title="[钱]"><img
						src="/IM/images/face/34.gif"></li>
					<li title="[失望]"><img
						src="/IM/images/face/35.gif"></li>
					<li title="[酷]"><img
						src="/IM/images/face/36.gif"></li>
					<li title="[色]"><img
						src="/IM/images/face/37.gif"></li>
					<li title="[哼]"><img
						src="/IM/images/face/38.gif"></li>
					<li title="[鼓掌]"><img
						src="/IM/images/face/39.gif"></li>
					<li title="[晕]"><img
						src="/IM/images/face/40.gif"></li>
					<li title="[悲伤]"><img
						src="/IM/images/face/41.gif"></li>
					<li title="[抓狂]"><img
						src="/IM/images/face/42.gif"></li>
					<li title="[黑线]"><img
						src="/IM/images/face/43.gif"></li>
					<li title="[阴险]"><img
						src="/IM/images/face/44.gif"></li>
					<li title="[怒骂]"><img
						src="/IM/images/face/45.gif"></li>
					<li title="[互粉]"><img
						src="/IM/images/face/46.gif"></li>
					<li title="[心]"><img
						src="/IM/images/face/47.gif"></li>
					<li title="[伤心]"><img
						src="/IM/images/face/48.gif"></li>
					<li title="[猪头]"><img
						src="/IM/images/face/49.gif"></li>
					<li title="[熊猫]"><img
						src="/IM/images/face/50.gif"></li>
					<li title="[兔子]"><img
						src="/IM/images/face/51.gif"></li>
					<li title="[ok]"><img
						src="/IM/images/face/52.gif"></li>
					<li title="[耶]"><img
						src="/IM/images/face/53.gif"></li>
					<li title="[good]"><img
						src="/IM/images/face/54.gif"></li>
					<li title="[NO]"><img
						src="/IM/images/face/55.gif"></li>
					<li title="[赞]"><img
						src="/IM/images/face/56.gif"></li>
					<li title="[来]"><img
						src="/IM/images/face/57.gif"></li>
					<li title="[弱]"><img
						src="/IM/images/face/58.gif"></li>
					<li title="[草泥马]"><img
						src="/IM/images/face/59.gif"></li>
					<li title="[神马]"><img
						src="/IM/images/face/60.gif"></li>
					<li title="[囧]"><img
						src="/IM/images/face/61.gif"></li>
					<li title="[浮云]"><img
						src="/IM/images/face/62.gif"></li>
					<li title="[给力]"><img
						src="/IM/images/face/63.gif"></li>
					<li title="[围观]"><img
						src="/IM/images/face/64.gif"></li>
					<li title="[威武]"><img
						src="/IM/images/face/65.gif"></li>
					<li title="[奥特曼]"><img
						src="/IM/images/face/66.gif"></li>
					<li title="[礼物]"><img
						src="/IM/images/face/67.gif"></li>
					<li title="[钟]"><img
						src="/IM/images/face/68.gif"></li>
					<li title="[话筒]"><img
						src="/IM/images/face/69.gif"></li>
					<li title="[蜡烛]"><img
						src="/IM/images/face/70.gif"></li>
					<li title="[蛋糕]"><img
						src="/IM/images/face/71.gif"></li>
				</ul>
		</div>
		<div>
			<input id="recentItemGroupMapJson" type="hidden"
				value='<%=request.getAttribute("recentItemGroupMapJson")%>'>

			<input id="recentItemFriendMapJson" type="hidden"
				value='<%=request.getAttribute("recentItemFriendMapJson")%>'>
			<input id="friendsMapJson" type="hidden"
				value='<%=request.getAttribute("friendsMapJson")%>'> <input
				id="groupItemMapJson" type="hidden"
				value='<%=request.getAttribute("groupItemMapJson")%>'> <input
				id="userJson" type="hidden"
				value='<%=request.getAttribute("userJson")%>'> <input
				id="userItem" type="hidden">

		</div>

		<script type="text/javascript" src="./js/websocket.js"></script>
		<audio id="didi_audio" src="http://localhost:8080/IM/sounds/didi.wav"
			controls="controls" loop="false" hidden="false"></audio>
		<audio id="ios_message_audio"
			src="http://localhost:8080/IM/sounds/ios_message.wav"
			controls="controls" loop="false" hidden="true"></audio>
		<audio id="ios_qq_audio"
			src="http://localhost:8080/IM/sounds/ios_qq.wav" controls="controls"
			loop="false" hidden="true"></audio>
		<audio id="send_success_audio"
			src="http://localhost:8080/IM/sounds/send_success.wav"
			controls="controls" loop="false" hidden="true"></audio>
		<audio id="friend_login_audio"
			src="http://localhost:8080/IM/sounds/friend_login.wav"
			controls="controls" loop="false" hidden="true"></audio>
			
</body>
</html>