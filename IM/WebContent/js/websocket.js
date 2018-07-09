var recentItemFriendMapJson = document
		.getElementById("recentItemFriendMapJson").value;
var recentItemGroupMapJson = document.getElementById("recentItemGroupMapJson").value;
var recentItemFriendMap = eval("(" + recentItemFriendMapJson + ")");
var recentItemGroupMap = eval("(" + recentItemGroupMapJson + ")");
var friendsMapJson = document.getElementById("friendsMapJson").value;
var groupItemMapJson = document.getElementById("groupItemMapJson").value;
var friendsMap = eval("(" + friendsMapJson + ")");
var groupItemMap = eval("(" + groupItemMapJson + ")");
var userJson = document.getElementById("userJson").value;
var user = eval("(" + userJson + ")");
var userItemMap = {};
var reg = /\[([^\]]+)\]/g;
var uploadImg=document.getElementById("uploadImg");
var uploadVoice=document.getElementById("uploadVoice");
var uploadVideo=document.getElementById("uploadVideo");
var uploadFile=document.getElementById("uploadFile");
// 导航条切换
var temp = document.getElementsByTagName("li");
for (var i = 0; i < temp.length; i++) {
	temp[i].onclick = function(event) {
		click(event.currentTarget.getAttribute("cmd"), event.currentTarget
				.getAttribute("param"));
	};
}
var panelBody5 = document.getElementById("panelBody-5");
function click(cmd, param) {
	switch (cmd) {
	case "clickNav":
		document.getElementById("session").classList.remove("selected");
		document.getElementById("contact").classList.remove("selected");
		document.getElementById("plugin").classList.remove("selected");
		document.getElementById("setting").classList.remove("selected");
		document.getElementById(param).classList.add("selected");
		document.getElementById("panel-1").classList.remove("selected");
		document.getElementById("panel-2").classList.remove("selected");
		document.getElementById("panel-3").classList.remove("selected");
		document.getElementById("panel-4").classList.remove("selected");
		switch (param) {
		case "session":
			document.getElementById("panel-1").classList.add("selected");
			break;
		case "contact":
			document.getElementById("panel-2").classList.add("selected");
			break;
		case "plugin":
			document.getElementById("panel-3").classList.add("selected");
			break;
		case "setting":
			document.getElementById("panel-4").classList.add("selected");
			break;
		}
		break;
	// 好友，群，讨论组
	case "clickMemberTab":
		var obj = document.getElementById("memberTab").children;
		obj[0].classList.remove("active");
		obj[1].classList.remove("active");
		obj[2].classList.remove("active");
		var obj1 = document.getElementsByClassName("member_tab_body")[0].children;
		obj1[0].classList.remove("active");
		obj1[1].classList.remove("active");
		obj1[2].classList.remove("active");
		switch (param) {
		case "friend":
			obj[0].classList.add("active");
			obj1[0].classList.add("active");
			break;
		case "group":
			obj[1].classList.add("active");
			obj1[1].classList.add("active");
			break;
		case "discuss":
			obj[2].classList.add("active");
			obj1[2].classList.add("active");
			break;

		}
		break;
	// 列表项
	case "clickMemberItem":
		var li = event.currentTarget;
		var uid = li.getAttribute("_uin");
		var type = li.getAttribute("_type");
		var userNick = li.children[1].innerText.split(" ")[0];
		var panelTitle5 = document.getElementById("panelTitle-5");
		var pannelMenuList_5 = document.getElementById("pannelMenuList-5");
		pannelMenuList_5.style.display = "none";
		if (li.getAttribute("id").split("-")[0] == "search") {
			if (type == "friend")
				viewFriendInfo(uid);
			else
				viewGroupInfo(uid);
			document.getElementById("panelLeftButtonText-6").innerHTML=uid;
			document.getElementById("panel-6").style.display = "block";
			document.getElementById("panel-7").style.display = "none";
		} else {
			panelTitle5.innerText = userNick;
			panelTitle5.setAttribute("_uin", uid);
			document.getElementById("panel-5").style.display = "block";
			document.getElementById("panel-7").style.display = "none";
			document.getElementById("panel-6").style.display = "none";
			var type = li.getAttribute("_type");

			panelBody5.innerHTML = "";
			switch (type) {
			case "friend":
				// 移除红点
				var spanid = "msgCount-" + type + "-" + uid;
				var span = document.getElementById(spanid);
				if (span && span.parentNode) {
					span.parentNode.removeChild(span);
				}
				panelTitle5.setAttribute("_type", "friend");
				if (recentItemFriendMap[uid]) {
					recentItemFriendMap[uid].count = 0;
					var messageList = recentItemFriendMap[uid].messageList;
					for ( var key in messageList) {
						createChatItem(messageList[key]);
					}
					document.getElementById("panelBodyWrapper-5").scrollTop = document
							.getElementById("panelBodyWrapper-5").scrollHeight;
				}
				pannelMenuList_5.children[0].setAttribute("cmd", "viewQzone");
				pannelMenuList_5.children[0].className = "viewQzone";
				pannelMenuList_5.children[0].childNodes[2].data = "个人空间";
				pannelMenuList_5.children[1].childNodes[2].data = "详细资料";
				break;
			case "group":// 群
				// 移除红点
				var spanid = "msgCount-" + type + "-" + uid;
				var span = document.getElementById(spanid);
				if (span && span.parentNode) {
					span.parentNode.removeChild(span);
				}
				if (recentItemGroupMap[uid]) {
					recentItemGroupMap[uid].count = 0;
					var messageList = recentItemGroupMap[uid].messageList;
					for ( var key in messageList) {
						createChatItem(messageList[key]);
					}
					document.getElementById("panelBodyWrapper-5").scrollTop = document
							.getElementById("panelBodyWrapper-5").scrollHeight;

				}
				panelTitle5.setAttribute("_type", "group");
				pannelMenuList_5.children[0].setAttribute("cmd", "viewMembers");
				pannelMenuList_5.children[0].className = "viewMembers";
				pannelMenuList_5.children[0].childNodes[2].data = "群成员";
				pannelMenuList_5.children[1].childNodes[2].data = "群资料";
			}
		}
		break;
		// 查看空间
	case "viewQzone":
		var uid=document.getElementById("panelTitle-5").getAttribute("_uin");
		window.open('zone?myid='+id+"&uid="+uid);
		break;
	// 查看群成员
	case "viewMembers":
		document.getElementById("panel-5").style.display = "none";
		var uid = document.getElementById("panelTitle-5").getAttribute("_uin");
		viewMembers(uid);
		document.getElementById("panel-7").style.display = "block";
		document.getElementById("pannelMenuList-5").classList.remove("show");
		break;
	case "viewInfo":
		document.getElementById("panel-5").style.display = "none";
		var panelTitle5 = document.getElementById("panelTitle-5");
		var type = panelTitle5.getAttribute("_type");
		var uid = panelTitle5.getAttribute("_uin");
		document.getElementById("panelLeftButtonText-6").innerHTML = uid;

		if (type == "friend")
			viewFriendInfo(uid);
		else
			viewGroupInfo(uid);
		document.getElementById("panel-6").style.display = "block";
		document.getElementById("pannelMenuList-5").classList.remove("show");
		break;
		// 改变状态
	case "clickState":
		var icon = event.currentTarget.children[0].classList[0]
		document.getElementById("main_icon").className = icon + " main_icon";
		document.getElementById("user_online_state").className = "state_"
				+ icon.split("_")[0];
		break;

	}
}
// 好友列表
var list_group = document.getElementsByClassName("list_group_title");
for (var i = 0; i < list_group.length; i++) {
	list_group[i].onclick = function(event) {
		var param = event.currentTarget.getAttribute("param");
		var list_group = document.getElementsByClassName("list_group");
		if (list_group[param].classList.contains("active"))
			list_group[param].classList.remove("active");
		else
			list_group[param].classList.add("active");
	};
}

/* 表情按钮 */
document.getElementById("icon-biaoqing").onclick = function() {

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
		var face =event.currentTarget.getAttribute("title");
		document.getElementById("chat_textarea").value +=face;
	}
}
function test(e){
	if(faceMap[e])
		return "<img src='/IM/images/face/"+faceMap[e]+"'></img>";
	return e;
}
// 点击详情
document.getElementById("panelLeftButton-5").onclick = function() {
	var pannelMenuList_5 = document.getElementById("pannelMenuList-5");

	if (pannelMenuList_5.style.display == "none") {
		pannelMenuList_5.style.display = "block";
	} else {
		pannelMenuList_5.style.display = "none"
	}

}
// 关闭按钮
document.getElementById("panelRightButton-5").onclick = function() {
	document.getElementById("panel-5").style.display = "none";
}

// panelLeftButton-7
document.getElementById("panelLeftButton-7").onclick = function() {
	document.getElementById("panel-5").style.display = "block";
	document.getElementById("panel-7").style.display = "none";
}
// panelLeftButton-6
document.getElementById("panelLeftButton-6").onclick = function() {
	document.getElementById("panel-5").style.display = "block";
	document.getElementById("panel-6").style.display = "none";
}
// panelRightButton-6
document.getElementById("panelRightButton-6").onclick = function() {
	document.getElementById("panel-8").style.display = "block";
	document.getElementById("panel-5").style.display = "none";
}
// panelLeftButton-8

document.getElementById("panelLeftButton-8").onclick = function() {
	document.getElementById("panel-8").style.display = "none";
	document.getElementById("panel-5").style.display = "block";
	document.getElementById("pannelMenuList-5").classList.remove("show");
}
// panelRightButton-2
document.getElementById("panelRightButton-2").onclick = function() {
	document.getElementById("panel-9").style.display = "block";
}
// panelLeftButton-9
document.getElementById("panelLeftButton-9").onclick = function() {
	document.getElementById("panel-9").style.display = "none";
}
// online_state_setting
document.getElementById("online_state_setting").onclick = function() {
	var ul = event.currentTarget.children[2];
	if (ul.style.display == "block")
		ul.style.display = "none";
	else
		ul.style.display = "block";
}

var id = document.getElementById("id").innerHTML;
// 发送消息
document.getElementById("send_chat_btn").onclick = function() {
	var content = document.getElementById("chat_textarea").value;
	var face_panel = document.getElementById("face-panel");
		face_panel.classList.remove("layui-layim-face-show");
	if (content == ""){
		//发送多媒体文件
		
		if(uploadImg.files.length!=0){
			upload(uploadImg.files,1);
			uploadImg.value="";
		}
		if(uploadVoice.files.length!=0){
			upload(uploadVoice.files,2);
			uploadVoice.value="";
		}
		if(uploadVideo.files.length!=0){
			upload(uploadVideo.files,3);
			uploadVideo.value="";
		}
		if(uploadFile.files.length!=0){
			upload(uploadFile.files,4);
			uploadFile.value="";
		}
		return;
		}
	// 消息发送成功提示音
	playInformAudio('send_success_audio');
	var reciverid = document.getElementById("panelTitle-5")
			.getAttribute("_uin");
	var type = document.getElementById("panelTitle-5").getAttribute("_type");
	var senderid = id;
	var typeid = 0;
	document.getElementById("chat_textarea").value = "";
	var jsonMsg = {};
	jsonMsg.senderid = senderid;
	jsonMsg.reciverid = reciverid;
	jsonMsg.content = content;
	jsonMsg.typeid = typeid;
	jsonMsg.type = (type == "friend" ? 0 : 1);
	// var jsonMsg ='{"senderid":'+senderid+', "reciverid":'+
	// reciverid+', "content":"'+content+'", "type":'+type+'}';
	// var Msg= eval ("(" + jsonMsg + ")");
	websocket.send(JSON.stringify(jsonMsg));

}

// 搜索好友或群
document.getElementById("search").onclick = function() {
	var uid = document.getElementById("searchInput").value;
	document.getElementById("search_container").innerHTML="";
	if (uid == "")
		return;
	searchUser(uid);
	searchGroup(uid);
}
// 添加好友
function addFriend(obj) {
	obj.setAttribute("disabled","disabled");
	var friendId = document.getElementById("friendId").innerHTML;
	var select=document.getElementById("selectGroup");
	var val=document.getElementById("addFriendInfo").value;
	var index=select.selectedIndex;
	var fgid = select.options[index].value;
	var jsonMsg = {};
	jsonMsg.senderid = id;
	jsonMsg.reciverid = friendId;
	jsonMsg.content = val;
	jsonMsg.typeid=fgid;
	jsonMsg.type =3;
	websocket.send(JSON.stringify(jsonMsg));
	alert("好友申请发送成功！")
}

var websocket = null;
// 判断当前浏览器是否支持WebSocket
if ('WebSocket' in window) {
	websocket = new WebSocket("ws://localhost:8080/IM/chatserver/" + id);
} else {
	alert('您的浏览器不支持 WebSocket！');
}
// 连接发生错误的回调方法
websocket.onerror = function(event) {
	console.log("error" + event);
};

// 连接成功建立的回调方法
websocket.onopen = function(event) {
	console.log("open" + event);
	alert("链接成功,欢迎登录IM！");
}

// 接收到消息的回调方法
websocket.onmessage = function(event) {
	var message = eval("(" + event.data + ")");
	var ul = document.getElementById("current_chat_list");
	var itemId = "";
	// 回显消息存储到recentMap中
	if (message.type == 2) {
		if (recentItemFriendMap[message.reciverid]) {// recentMap包括接收人
			recentItemFriendMap[message.reciverid].lastTime = message.time;
			recentItemFriendMap[message.reciverid].lastMsgContent = message.content;
			recentItemFriendMap[message.reciverid].messageList.push(message);
			itemId = "recent-item-friend-" + message.reciverid;
			// 删除原始li
			var li = document.getElementById(itemId);
			ul.removeChild(li);
		} else {
			var recentItem = {};
			recentItem.type = message.type;
			recentItem.id = message.reciverid;
			recentItem.count = 0;
			recentItem.lastTime = message.time;
			recentItem.lastMsgContent = message.content;
			var messageList = new Array();
			messageList.push(message);
			recentItem.messageList = messageList;
			recentItemFriendMap[message.reciverid] = recentItem;
		}
		createChatItem(message);

		// 重新生成recentItem的li 并置顶
		var _uin = message.reciverid;
		var src = friendsMap[_uin].headportrait;
		var nickname = friendsMap[_uin].nickname;
		createRecemtItem(_uin, "friend", src, nickname,
				recentItemFriendMap[_uin].count,
				recentItemFriendMap[_uin].lastTime, message.content);

	} else {
		switch (message.type) {
		case 0:// 好友消息
			// 播放声音
			playInformAudio('ios_message_audio');
			itemId = "recent-item-friend-" + message.senderid;
			if (recentItemFriendMap[message.senderid]) {
				// 存在该好友会话 ，交流窗口打开则显示消息 ，若关闭则未读数+1
				recentItemFriendMap[message.senderid].lastTime = message.time;
				recentItemFriendMap[message.senderid].lastMsgContent = message.content;
				recentItemFriendMap[message.senderid].messageList.push(message);
				var senderid = document.getElementById("panelTitle-5")
						.getAttribute("_uin");
				var type = document.getElementById("panelTitle-5")
						.getAttribute("_type");
				if (senderid == message.senderid && type == "friend") {// 交流窗口打开则显示消息
					createChatItem(message);

				} else {
					// 若关闭则未读数+1
					recentItemFriendMap[message.senderid].count += 1;

				}
				// 删除原始li
				var li = document.getElementById(itemId);
				ul.removeChild(li);
			} else {
				var recentItem = {};
				recentItem.type = message.type;
				recentItem.id = message.senderid;
				recentItem.count = 1;
				recentItem.lastTime = message.time;
				recentItem.lastMsgContent = message.content;
				var messageList = new Array();
				messageList.push(message);
				recentItem.messageList = messageList;
				recentItemFriendMap[message.senderid] = recentItem;
			}
			// 重新生成recentItem的li 并置顶
			var _uin = message.senderid;
			var src = friendsMap[_uin].headportrait;
			var nickname = friendsMap[_uin].nickname;
			createRecemtItem(_uin, "friend", src, nickname,
					recentItemFriendMap[_uin].count,
					recentItemFriendMap[_uin].lastTime, message.content);

			break;
		case 1:// 群消息
			if (message.senderid != id) {
				// 播放声音
				playInformAudio('ios_message_audio');
			}
			itemId = "recent-item-group-" + message.reciverid;
			var reciverid = document.getElementById("panelTitle-5")
				.getAttribute("_uin");
			var type = document.getElementById("panelTitle-5")
				.getAttribute("_type");
			if (reciverid == message.reciverid && type == "group") {// 交流窗口打开则显示消息
				createChatItem(message);
			}
			if (recentItemGroupMap[message.reciverid]) {
				// 存在该群会话 ，交流窗口打开则显示消息 ，若关闭则未读数+1
				recentItemGroupMap[message.reciverid].lastTime = message.time;
				recentItemGroupMap[message.reciverid].lastMsgContent = message.content;
				recentItemGroupMap[message.reciverid].messageList.push(message);
				var reciverid = document.getElementById("panelTitle-5")
						.getAttribute("_uin");
				var type = document.getElementById("panelTitle-5")
						.getAttribute("_type");
				if (reciverid == message.reciverid && type == "group") {// 交流窗口打开则显示消息

					
				} else {
					// 若关闭则未读数+1
					recentItemGroupMap[message.reciverid].count += 1;
				}
				// 删除原始li
				var li = document.getElementById(itemId);
				ul.removeChild(li);
			} else {
				var recentItem = {};
				recentItem.type = message.type;
				recentItem.id = message.reciverid;
				recentItem.count = 1;
				recentItem.lastTime = message.time;
				recentItem.lastMsgContent = message.content;
				var messageList = new Array();
				messageList.push(message);
				recentItem.messageList = messageList;
				recentItemGroupMap[message.reciverid] = recentItem;
			}
			// 重新生成recentItem的li 并置顶
			var _uin = message.reciverid;
			var src = groupItemMap[_uin].headportrait;
			var nickname = groupItemMap[_uin].name;
			createRecemtItem(_uin, "group", src, nickname,
					recentItemGroupMap[_uin].count,
					recentItemGroupMap[_uin].lastTime, message.content);
			break;
		case 3:// 对方请求加好友
			alert(message.senderid+"  请求加你为好友");
			var friendGroupItemSpans=document.getElementsByClassName("friendGroupItem");
			var options="";
			for(var i=0;i<friendGroupItemSpans.length;i++){
				var friendGroupItem=friendGroupItemSpans[i];
				options+="<option value='"+friendGroupItem.id+"'>"+friendGroupItem.innerHTML+"</option>"
			}
			var d_list=document.getElementById("d_list");
			var li=document.createElement("li");
			li.id="discuss-item-discuss-"+message.senderid;
			li.classList.add("list_item");
			li.innerHTML="<a href='' class='avatar'><img src='head/default.jpg'></a>"
			+"<p class='member_nick'>"+message.senderid+"<select class='selectGroup' id='selectGroup-"+message.senderid+"'>" +options+
				"</select><button class='accept' id='accept-"+message.senderid+"' onclick='acceptApply("+JSON.stringify(message)+",this)'>同意</button></p>"
			+"<p class='member_msg text_ellipsis'>"+message.content+"<input class='remark' id='remark-"+message.senderid+"' placeholder='备注'>" +
					"<button class='refuse' id='refuse-"+message.senderid+"' onclick='refuseApply("+JSON.stringify(message)+",this)'>拒绝</button></p>"
			d_list.appendChild(li);
			break;
		case 4:// 对方同意你加好友
			alert(message.reciverid+"已同意加你为好友");
			$.ajax({
				url : "getUserInfo?id="+message.reciverid,
				type : "get",
				async : false,
				success : function(data) {
					var user = JSON.parse(data);
					var friend={};
					friend.id=message.reciverid;
					friend.fgid=message.typeid;
					friend.stateid=user.stateid;
					friend.nickname=user.nickname;
					friend.headportrait=user.headportrait;
					friend.signature=user.signature;
					friendsMap[friend.id]=friend;
					createFriendItem(friend);
					message.type=0;
					message.typeid=0;
					websocket.send(JSON.stringify(message));
				}
			})
			break;
		case 5:// 收到请求入群消息
			alert(message.senderid+"  请求加入群     "+message.typeid);
			var d_list=document.getElementById("d_list");
			var li=document.createElement("li");
			li.id="discuss-item-discuss-"+message.senderid;
			li.classList.add("list_item");
			li.innerHTML="<a href='' class='avatar'><img src='head/default.jpg'></a>"
			+"<p class='member_nick'>"+message.senderid+"申请加群"+message.typeid
			+"<button class='accept' id='accept-group-"+message.senderid+"' onclick='acceptJoinGroup("+JSON.stringify(message)+",this)'>同意</button></p>"
			+"<p class='member_msg text_ellipsis'>"+message.content
			+"<button class='refuse' id='refuse-group-"+message.senderid+"' onclick='refuseJoinGroup("+JSON.stringify(message)+",this)'>拒绝</button></p>"
			d_list.appendChild(li);
			break;
		case 6:// 收到同意入群消息
			alert(message.reciverid+" 已同意你加入群  "+message.typeid);	
			$.ajax({
				url : "getGroupInfo?id="+message.typeid,
				type : "get",
				async : false,
				success : function(data) {
					var group = JSON.parse(data);
					var groupItem={};
					groupItem.groupid=group.groupid;
					groupItem.name=group.name;
					groupItem.headportrait=group.headportrait;
					groupItemMap[group.groupid]=groupItem;
					createGroupItem(groupItem);
					message.type=1;
					message.reciverid=message.typeid;
					message.typeid=0;
					websocket.send(JSON.stringify(message));
				}
			})
			break;
		}
	}

}

// 连接关闭的回调方法
websocket.onclose = function(event) {
	console.log("close" + event);
	alert("已在他处登录！");
}

// 监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
window.onbeforeunload = function() {
	websocket.close();
}
// 播放声音
function playInformAudio(audioName, duration) {
	duration = duration || 2000;
	var audio = document.getElementById(audioName).play();
	setTimeout(function() {
		document.getElementById(audioName).pause();
	}, duration);
}

function createChatItem(message) {
	var div1 = document.createElement("div");
	div1.classList.add("chat_time");
	div1.innerHTML = "<span>" + message.time + "</span>"
	panelBody5.appendChild(div1);
	var div2 = document.createElement("div");
	div2.classList.add("chat_content_group");
	div2.classList.add(message.senderid == id ? "self" : "buddy");
	div2.setAttribute("_sender_uin", message.senderid);
	var src = "";
	var nickname = "";
	switch (message.type) {
	case 0:
		src = friendsMap[message.senderid].headportrait;
		nickname = friendsMap[message.senderid].nickname;
		break;
	case 1:
		if (userItemMap[message.senderid]) {
			src = userItemMap[message.senderid].headportrait;
			nickname = userItemMap[message.senderid].nickname;
		} else {
			userItem = getUserItem(message.senderid);
			userItemMap[message.senderid] = userItem;
			src = userItem.headportrait;
			nickname = userItem.nickname;
		}

		break;
	default:
		src = user.headportrait;
		nickname = user.nickname;
		break;
	}
	//消息内容类型
	var content;
	switch(message.typeid){
	case 0:
		//替换聊天表情
		content=message.content.replace(reg,test);
		break;
	case 1:
		content="<img src='"+message.content+"' width='240' height='160'></img>"
		break;
	case 2:
		var reg1=/\_([\s\S]+)/;
		content=message.content.match(reg1)[1]+"<audio src='"+message.content+"' controls='controls'></audio>"
		break;
	case 3:
		content="<video src='"+message.content+"' controls='controls' width='320' height='240'></video>"
		break;
	case 4:
		var reg1=/\_([\s\S]+)/;
		content="<a href='"+message.content+"' target='_blank'>"+message.content.match(reg1)[1]+"</a>"
		break;
	}
	div2.innerHTML = "<img class='chat_content_avatar' src='/IM/head/" + src
			+ "' width='40px' height='40px'>" + "<p class='chat_nick'>"
			+ nickname + "</p>" + "<p class='chat_content '>" + content
			+ "</p>";
	panelBody5.appendChild(div2);
	document.getElementById("panelBodyWrapper-5").scrollTop = document
			.getElementById("panelBodyWrapper-5").scrollHeight;

}

function createRecemtItem(_uin, type, src, nickname, count, lastTime, content) {
	var li = document.createElement("li");
	li.id = "recent-item-" + type + "-" + _uin;
	li.classList.add("list_item");
	li.setAttribute("_uin", _uin);
	li.setAttribute("_type", type);
	li.setAttribute("cmd", "clickMemberItem");
	if (count == 0) {
		li.innerHTML = "<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin="
				+ _uin
				+ " _type="
				+ type
				+ ">"
				+ "<img src='/IM/head/"
				+ src
				+ "'>"
				+ "</a>"
				+ "<p class='member_nick recent_item text_ellipsis' id='userNick-"
				+ _uin
				+ "'>"
				+ "\n"
				+ nickname
				+ "\n"
				+ "<span id='msgtime'>"
				+ lastTime
				+ "</span></p>"
				+ "<p id='recent-item-"
				+ type
				+ "-"
				+ _uin
				+ "-msg' class='member_msg text_ellipsis'>"
				+ content
				+ "</p,";
	} else {
		li.innerHTML = "<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin="
				+ _uin
				+ " _type="
				+ type
				+ ">"
				+ "<img src='/IM/head/"
				+ src
				+ "'>"
				+ "</a>"
				+ "<p class='member_nick recent_item text_ellipsis' id='userNick-"
				+ _uin
				+ "'>"
				+ "\n"
				+ nickname
				+ "\n"
				+ "<span id='msgtime'>"
				+ lastTime
				+ "</span></p>"
				+ "<p id='recent-item-"
				+ type
				+ "-"
				+ _uin
				+ "-msg' class='member_msg text_ellipsis'>"
				+ content
				+ "<span id='msgCount-"
				+ type
				+ "-"
				+ _uin
				+ "' class='msgCount'>" + count + "</span></p,";
	}
	var ul = document.getElementById("current_chat_list");
	ul.insertBefore(li, ul.children[0]);
	li.onclick = function(event) {
		click(event.currentTarget.getAttribute("cmd"), event.currentTarget
				.getAttribute("param"));
	}
}

function getUserItem(id) {
	var userItem = null;
	$.ajax({
		url : "getUserItem?id=" + id,
		type : "get",
		async : false,
		success : function(data) {
			userItem = JSON.parse(data);
		}
	})
	return userItem;
}
// 查看好友详情
function viewFriendInfo(uid) {
	$.ajax({
		url : "getUserInfo?id=" + uid,
		type : "get",
		async : true,
		success : function(data) {
			var friend = JSON.parse(data);
			var panelBody_6 = document.getElementById("panelBody-6")
			panelBody_6.innerHTML = "";
			var div1 = document.createElement("div");
			div1.classList.add("group");
			var friendGroupItemSpans=document.getElementsByClassName("friendGroupItem");
			var options="";
			for(var i=0;i<friendGroupItemSpans.length;i++){
				var friendGroupItem=friendGroupItemSpans[i];
				options+="<option value='"+friendGroupItem.id+"'>"+friendGroupItem.innerHTML+"</option>"
			}
			
			if(friendsMap[uid]){
				div1.innerHTML = "<div class='row clearfix'>"
					+ "<div class='cloumn'>" + "<img class='avatar' src='head/"
					+ friend.headportrait + "'>" + "</div>"
					+ "<div class='cloumn profile_title'>"
					+ "<div class='row profile_name'>" + friend.id + "</div></div>"
				+"<div class='cloumn option'><select id='selectGroup'>" +options+
				"</select>" +
				"<button id='changeGroup' onclick='changeGroup("+friend.id+")'>移动到该组</button>" +
				"<button id='deleteFriend' onclick='deleteFriend("+JSON.stringify(friendsMap[uid])+")'>删除该好友</button>" +
				"</div>";
			}else{
				div1.innerHTML = "<div class='row clearfix'>"
					+ "<div class='cloumn'>" + "<img class='avatar' src='head/"
					+ friend.headportrait + "'>" + "</div>"
					+ "<div class='cloumn profile_title'>"
					+ "<div class='row profile_name' id='friendId'>" + friend.id + "</div></div>"
				+"<div class='cloumn option'><select id='selectGroup'>" +options+
				"</select>" +
				"<input id='addFriendInfo' value='我是"+user.nickname+"'>"+
				"<button onclick='addFriend(this)'>添加好友</button>" +
				"</div>";
			} 
			panelBody_6.appendChild(div1);
			var div2 = document.createElement("div");
			div2.classList.add("group");
			div2.innerHTML = "<div class='row'><span class='label'>性别</span>"
					+ (friend.sex == false ? "男" : "女") + "</div>"
					+ "<div class='row '><span class='label'>姓名</span>"
					+ friend.name + "</div>"
					+ "<div class='row '><span class='label'>昵称</span>"
					+ friend.nickname + "</div>"
					+ "<div class='row '><span class='label'>签名</span>"
					+ friend.signature + "</div>";
			+"<div class='row '><span class='label'>职业</span>" + friend.vocation
					+ "</div>";
			panelBody_6.appendChild(div2);
			var div3 = document.createElement("div");
			div3.classList.add("group");
			div3.innerHTML = "<div class='row '><span class='label'>地址</span>"
					+ friend.address + "</div>"
					+ "<div class='row '><span class='label'>出生日期</span>"
					+ friend.birthday + "</div>"
					+ "<div class='row '><span class='label'>血型</span>"
					+ friend.bloodtype + "</div>"
					+ "<div class='row '><span class='label'>星座</span>"
					+ friend.constellation + "</div>"
					+ "<div class='row '><span class='label'>email</span>"
					+ friend.email + "</div>"
					+ "<div class='row '><span class='label'>介绍</span>"
					+ friend.intro + "</div>"
					+ "<div class='row '><span class='label'>电话</span>"
					+ friend.phone + "</div>"
					+ "<div class='row '><span class='label'>生肖</span>"
					+ friend.shengxiao + "</div>";
			panelBody_6.appendChild(div3);
		}
	})
}
// 查看群详情
function viewGroupInfo(uid) {
	$.ajax({
		url : "getGroupInfo?id=" + uid,
		type : "get",
		async : true,
		success : function(data) {
			var group = JSON.parse(data);
			var panelBody_6 = document.getElementById("panelBody-6");
			panelBody_6.innerHTML = "";
			var div1 = document.createElement("div");
			div1.classList.add("group");
			if(groupItemMap[uid]){
				div1.innerHTML = "<div class='row clearfix'>"
					+ "<div class='cloumn'>" + "<img class='avatar' src='head/"
					+ group.headportrait + "'>" + "</div>"
					+ "<div class='cloumn profile_title'>"
					+ "<div class='row profile_name' >" + group.groupid + "</div></div>"
				+"<div class='cloumn option'>"
				+"<button  onclick='exitGroup()'>退出该群</button>" +
				"</div>";
			}else{
				div1.innerHTML = "<div class='row clearfix'>"
					+ "<div class='cloumn'>" + "<img class='avatar' src='head/"
					+ group.headportrait + "'>" + "</div>"
					+ "<div class='cloumn profile_title'>"
					+ "<div class='row profile_name' id='joingroupid'>" + group.groupid + "</div></div>"
				+"<div class='cloumn option'>"+
				"<input id='joinGroupInfo' value='我是"+user.nickname+"'>"+
				"<button id='joinGroup' onclick='joinGroup(this)'>加入该群</button>" +
				"</div>";
			} 
			panelBody_6.appendChild(div1);
			var div2 = document.createElement("div");
			div2.classList.add("group");
			div2.innerHTML = "<div class='row '><span class='label'>群名</span>"
					+ group.name + "</div>"
					+ "<div class='row' id='adminid'><span class='label' id='adminid'>群主</span>"
					+ group.adminid + "</div>"
					+ "<div class='row'><span class='label'>创建时间</span>"
					+ group.createtime + "</div>"
					+ "<div class='row '><span class='label'>介绍</span>"
					+ group.intro + "</div>"
					+ "<div class='row '><span class='label'>通知</span>"
					+ group.notice + "</div>";
			panelBody_6.appendChild(div2);
		}
	})
}
// 查看群成员
function viewMembers(groupid) {
	$.ajax({
				url : "getGroupMembers?groupid=" + groupid,
				type : "get",
				async : false,
				success : function(data) {
					var groupMemberList = JSON.parse(data);
					var ul = document
							.getElementById("member_search_result_list");
					ul.innerHTML = "";
					var span = document.createElement("span");
					span.innerHTML="群成员        "+groupMemberList.length+"人";
					ul.appendChild(span);
					for (var i = 0; i < groupMemberList.length; i++) {
						var li = document.createElement("li");
						li.setAttribute("id", "search-item-friend-"
								+ groupMemberList[i].id);
						li.classList.add("list_item");
						li.setAttribute("_uin", groupMemberList[i].id);
						li.setAttribute("_type", "friend");
						li.setAttribute("cmd", "clickMemberItem");
						li.innerHTML = "<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin='"
								+ groupMemberList[i].id
								+ " _type=''>"
								+ "<img src='head/"
								+ groupMemberList[i].headportrait
								+ "'></a>"
								+ "<p class='member_nick' id='userNick-"
								+ groupMemberList[i].id
								+ "'>"
								+ groupMemberList[i].nickname
								+ "</p>"
								+ "<span>["
								+ (groupMemberList[i].stateid == 1 ? '在线'
										: '离线')
								+ "]</span>"
								+ "<span>"
								+ groupMemberList[i].signature + "</span>";
						li.onclick = function(event) {
							click(event.currentTarget.getAttribute("cmd"),
									event.currentTarget.getAttribute("param"));
						}
						ul.appendChild(li);
					}
				}
			})
}


// 按name搜索好友
function searchUser(uid) {
	$.ajax({
		url : "searchUser?id=" + uid,
		type : "get",
		async : false,
		success : function(data) {
			var userItemList = JSON.parse(data);
			var search_container=document.getElementById("search_container");
			var ul=document.createElement("ul");
			var span=document.createElement("span");
			span.innerHTML="搜索到的用户：";
			ul.appendChild(span);
			search_container.appendChild(ul);
			ul.setAttribute("id", "search_result_list");
			ul.classList.add("list","list_white","catogory_List");
			for (let userItem of userItemList) {
				var li=createSearchUserItem(userItem);
				ul.appendChild(li);
			}
		}
	})
}
function createSearchUserItem(userItem){
	var li = document.createElement("li");
	li.setAttribute("id", "search-item-friend-" + userItem.id);
	li.classList.add("list_item");
	li.setAttribute("_uin", userItem.id);
	li.setAttribute("_type", "friend");
	li.setAttribute("cmd", "clickMemberItem");
	li.innerHTML = "<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin='"
			+ userItem.id
			+ " _type=''>"
			+ "<img src='head/"
			+ userItem.headportrait
			+ "'></a>"
			+ "<p class='member_nick' id='userNick-"
			+ userItem.id
			+ "'>"
			+ userItem.nickname+"("+userItem.id +")"+ "</p>";
	li.onclick = function(event) {
		click(event.currentTarget.getAttribute("cmd"), event.currentTarget
				.getAttribute("param"));
	}
	return li;
}

// 按name搜索群
function searchGroup(uid) {
	$.ajax({
		url : "searchGroup?id=" + uid,
		type : "get",
		async : false,
		success : function(data) {
			var groupItemList = JSON.parse(data);
			var search_container=document.getElementById("search_container");
			var ul=document.createElement("ul");
			var span=document.createElement("span");
			span.innerHTML="搜索到的群：";
			ul.appendChild(span);
			search_container.appendChild(ul);
			ul.setAttribute("id", "search_result_list");
			ul.classList.add("list","list_white","catogory_List");
			for (let groupItem of groupItemList) {
				var li=createSearchGroupItem(groupItem);
				ul.appendChild(li);
			}
		}
	})
}
function createSearchGroupItem(groupItem){
	var li = document.createElement("li");
	li.setAttribute("id", "search-item-group-" + groupItem.groupid);
	li.classList.add("list_item");
	li.setAttribute("_uin", groupItem.groupid);
	li.setAttribute("_type", "group");
	li.setAttribute("cmd", "clickMemberItem");
	li.innerHTML = "<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin='"
			+ groupItem.groupid
			+ " _type=''>"
			+ "<img src='head/"
			+ groupItem.headportrait
			+ "'></a>"
			+ "<p class='member_nick' id='userNick-"
			+ groupItem.groupid
			+ "'>"
			+ groupItem.name+"("+groupItem.groupid +")"+ "</p>";
	li.onclick = function(event) {
		click(event.currentTarget.getAttribute("cmd"), event.currentTarget
				.getAttribute("param"));
	}
	return li;
}

function acceptApply(message,obj){
	obj.setAttribute("disabled","disabled");
	document.getElementById("refuse-"+message.senderid).setAttribute("disabled","disabled");
	if(friendsMap[message.senderid])
		return ;
	var remark=document.getElementById("remark-"+message.senderid).value;
	var select=document.getElementById("selectGroup-"+message.senderid);
	var index=select.selectedIndex;
	var fgid = select.options[index].value;
	$.ajax({
		url : "addFriend?myid="+id+"&friendid=" + message.senderid+"&fgid="+fgid+"&remark="+remark,
		type : "get",
		async : false,
		success : function(data) {
			var friend = JSON.parse(data);
			friendsMap[friend.id]=friend;
			createFriendItem(friend);
			message.type=4;
			websocket.send(JSON.stringify(message));
		}
	})
}

function refuseApply(message,obj){
	obj.setAttribute("disabled","disabled");
	document.getElementById("accept-"+message.senderid).setAttribute("disabled","disabled");

}

function createFriendItem(friend) {
	var span=document.getElementById(friend.fgid).nextElementSibling;
	var str=span.innerHTML;
	var arr=str.split("/");
	var totoal=parseInt(arr[1])+1;
	var online=parseInt(arr[0]);
	if(friend.stateid==1)
		online++;
	span.innerHTML=online+"/"+totoal;
	var ul=document.getElementById("groupBodyUl-"+friend.fgid);
	var li=document.createElement("li");
	li.id="friend-item-friend-"+friend.id;
	li.classList.add("list_item");
	li.setAttribute("_uin",friend.id);
	li.setAttribute("_type","friend");
	li.setAttribute("cmd","clickMemberItem");
	li.innerHTML="<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin='"+friend.id+"' _type='friend'>"+
			"<img src='/IM/head/"+friend.headportrait+"'></a>"
			+"<p class='member_nick' id='userNick-"+friend.id+"'>"+friend.nickname+"</p>"
			+"<p class='member_msg text_ellipsis'>"
			+"<span class='member_state'>["+(friend.stateid==1?"在线":"离线")
			+"]</span> <span class='member_signature'>"+friend.signature+"</span></p>";
	ul.insertBefore(li, ul.children[0]);
	li.onclick = function(event) {
		click(event.currentTarget.getAttribute("cmd"), event.currentTarget
				.getAttribute("param"));
	}
}
function deleteFriend(friend) {
	document.getElementById("panel-5").style.display="none";
	document.getElementById("panel-6").style.display="none";
	var span=document.getElementById(friend.fgid).nextElementSibling;
	var str=span.innerHTML;
	var arr=str.split("/");
	var totoal=parseInt(arr[1])-1;
	var online=parseInt(arr[0]);
	if(friend.stateid==1)
		online--;
	span.innerHTML=online+"/"+totoal;
	var ul=document.getElementById("groupBodyUl-"+friend.fgid);
	// 删除原始li
	var li = document.getElementById("friend-item-friend-"+friend.id);
	ul.removeChild(li);
	delete friendsMap[friend.id];
	$.ajax({
		url : "deleteFriend?myid="+id+"&friendid=" + friend.id,
		type : "get",
		async : true,
	})
}

// 申请加入群
function joinGroup(obj){
	obj.setAttribute("disabled","disabled");
	var adminid=document.getElementById("adminid").childNodes[1].data;
	var val=document.getElementById("joinGroupInfo").value;
	var groupid=document.getElementById("joingroupid").innerHTML
	var jsonMsg = {};
	jsonMsg.senderid = id;
	jsonMsg.reciverid = adminid;
	jsonMsg.typeid=groupid;
	jsonMsg.content = val;
	jsonMsg.type =5;
	websocket.send(JSON.stringify(jsonMsg));
	alert("加群申请发送成功！")
}
// 同意加群
function acceptJoinGroup(message,obj){
	obj.setAttribute("disabled","disabled");
	document.getElementById("refuse-group-"+message.senderid).setAttribute("disabled","disabled");
	$.ajax({
		url : "joinGroup?groupid="+message.typeid+"&userid=" + message.senderid,
		type : "get",
		async : false,
		success : function(data) {
			message.type=6;
			websocket.send(JSON.stringify(message));
		}
	})
}
// 拒绝加群
function refuseJoinGroup(message,obj){
	obj.setAttribute("disabled","disabled");
	document.getElementById("accept-group-"+message.senderid).setAttribute("disabled","disabled");

}

function createGroupItem(groupItem) {
	var ul=document.getElementById("g_list");
	var li=document.createElement("li");
	li.id="group-item-group-"+groupItem.groupid;
	li.classList.add("list_item");
	li.setAttribute("_uin",groupItem.groupid);
	li.setAttribute("_type","group");
	li.setAttribute("cmd","clickMemberItem");
	li.innerHTML="<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin='"+groupItem.groupid+"' _type='group'>"+
			"<img src='/IM/head/"+groupItem.headportrait+"'></a>"
			+"<p class='member_nick' id='userNick-"+groupItem.groupid+"'>"+groupItem.name+"</p>";
	ul.insertBefore(li, ul.children[0]);
	li.onclick = function(event) {
		click(event.currentTarget.getAttribute("cmd"), event.currentTarget
				.getAttribute("param"));
		}
}

function exitGroup() {
	var groupid=document.getElementById("panelLeftButtonText-6").innerHTML;
	document.getElementById("panel-5").style.display="none";
	document.getElementById("panel-6").style.display="none";
	var ul=document.getElementById("g_list");
	var li=document.getElementById("group-item-group-"+groupid);
	ul.removeChild(li);
	delete groupItemMap[groupid];
	alert("退群成功");
	$.ajax({
		url : "exitGroup?groupid="+groupid+"&userid=" + id,
		type : "get",
		async : true,
	})
}


var faceMap={
				"[微笑]":"0.gif",
				"[嘻嘻]":"1.gif",
				"[哈哈]":"2.gif",
				"[可爱]":"3.gif",
				"[可怜]":"4.gif",
				"[挖鼻]":"5.gif",
				"[吃惊]":"6.gif",
				"[害羞]":"7.gif",
				"[挤眼]":"8.gif",
				"[闭嘴]":"9.gif",
				"[鄙视]":"10.gif",
				"[爱你]":"11.gif",
				"[泪]":"12.gif",
				"[偷笑]":"13.gif",
				"[亲亲]":"14.gif",
				"[生病]":"15.gif",
				"[太开心]":"16.gif",
				"[白眼]":"17.gif",
				"[右哼哼]":"18.gif",
				"[左哼哼]":"19.gif",
				"[嘘]":"20.gif",
				"[衰]":"21.gif",
				"[委屈]":"22.gif",
				"[吐]":"23.gif",
				"[哈欠]":"24.gif",
				"[抱抱]":"25.gif",
				"[怒]":"26.gif",
				"[疑问]":"27.gif",
				"[馋嘴]":"28.gif",
				"[拜拜]":"29.gif",
				"[思考]":"30.gif",
				"[汗]":"31.gif",
				"[困]":"32.gif",
				"[睡]":"33.gif",
				"[钱]":"34.gif",
				"[失望]":"35.gif",
				"[酷]":"36.gif",
				"[色]":"37.gif",
				"[哼]":"38.gif",
				"[鼓掌]":"39.gif",
				"[晕]":"40.gif",
				"[悲伤]":"41.gif",
				"[抓狂]":"42.gif",
				"[黑线]":"43.gif",
				"[阴险]":"44.gif",
				"[怒骂]":"45.gif",
				"[互粉]":"46.gif",
				"[心]":"47.gif",
				"[伤心]":"48.gif",
				"[猪头]":"49.gif",
				"[熊猫]":"50.gif",
				"[兔子]":"51.gif",
				"[ok]":"52.gif",
				"[耶]":"53.gif",
				"[good]":"54.gif",
				"[NO]":"55.gif",
				"[赞]":"56.gif",
				"[来]":"57.gif",
				"[弱]":"58.gif",
				"[草泥马]":"59.gif",
				"[神马]":"60.gif",
				"[囧]":"61.gif",
				"[浮云]":"62.gif",
				"[给力]":"63.gif",
				"[围观]":"64.gif",
				"[威武]":"65.gif",
				"[奥特曼]":"66.gif",
				"[礼物]":"67.gif",
				"[钟]":"68.gif",
				"[话筒]":"69.gif",
				"[蜡烛]":"70.gif",
				"[蛋糕]":"71.gif"}





function generateUUID() {
var d = new Date().getTime();
var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
  var r = (d + Math.random()*16)%16 | 0;
  d = Math.floor(d/16);
  return (c=='x' ? r : (r&0x3|0x8)).toString(16);
});
return uuid;
};

function upload(files,typeid) {
	for(var i=0;i<files.length;i++){
		var formFile = new FormData();
		var name=generateUUID()+"_"+files[i].name; 
        formFile.append("file", files[i],name);
        $.ajax({
            url: "upload",
            data: formFile,
            type: "Post",
            cache: false,//上传文件无需缓存
            processData: false,//用于对data参数进行序列化处理 这里必须false
            contentType: false, //必须
            async : false,
            success: function (result) {
               
            	var reciverid = document.getElementById("panelTitle-5")
    			.getAttribute("_uin");
    	var type = document.getElementById("panelTitle-5").getAttribute("_type");
    	var senderid = id;
    	document.getElementById("chat_textarea").value = "";
    	var jsonMsg = {};
    	jsonMsg.senderid = senderid;
    	jsonMsg.reciverid = reciverid;
    	jsonMsg.content = "/IM/upload/"+name;
    	jsonMsg.typeid = typeid;
    	jsonMsg.type = (type == "friend" ? 0 : 1);
    	websocket.send(JSON.stringify(jsonMsg));
    	 // 消息发送成功提示音
    	playInformAudio('send_success_audio');
            },
        })
        
    	
	}
	
}

document.getElementById("createGroupBtn").onclick=function(){
	 $.ajax({
		 type: "POST",//方法类型
         dataType: "json",//预期服务器返回的数据类型
         url: "createGroup?id="+id ,//url
         data: $('#createGroupForm').serialize(),
         success: function (result) {
        	 alert("群创建成功！")
        	groupItemMap[result.groupid]=result;
        	var ul=document.getElementById("g_list");
        	var li=document.createElement("li");
        	li.id="group-item-group-"+result.groupid;
        	li.classList.add("list_item");
        	li.setAttribute("_uin",result.groupid);
        	li.setAttribute("_type","group");
        	li.setAttribute("cmd","clickMemberItem");
        	li.innerHTML="<a href='javascript:void(0);' class='avatar' cmd='clickMemberAvatar' _uin='"+result.groupid+"' _type='group'>"+
        			"<img src='/IM/head/"+result.headportrait+"'></a>"
        			+"<p class='member_nick' id='userNick-"+result.groupid+"'>"+result.name+"</p>";
        	ul.insertBefore(li, ul.children[0]);
        	li.onclick = function(event) {
        		click(event.currentTarget.getAttribute("cmd"), event.currentTarget
        				.getAttribute("param"));
        	}
         }
     })
     
	
}
document.getElementById("createFriendGroupBtn").onclick=function(){
	 $.ajax({
		 type: "POST",//方法类型
        dataType: "json",//预期服务器返回的数据类型
        url: "createFriendGroup?id="+id ,//url
        data: $('#createFriendGroupForm').serialize(),
        success: function (result) {
        var index=	document.getElementsByClassName("list_group").length;
       	var ul=document.getElementById("friend_groupList");
       	var li=document.createElement("li");
       	li.classList.add("list_group");
       	li.innerHTML="<div id='groupTitle-"+result.fgid+"' class='list_group_title list_group_white_title list_arrow_right' cmd='clickMemberGroup' param='"+index+"'>" +
       			"<span class='friendGroupItem' id='"+result.fgid+"'>"+result.fgname+"</span>" +
       			"<span class='onlinePercent'>0/0</span></div>" +
       			"<ul id='groupBodyUl-"+result.fgid+"' class='list_group_body list list_white catogory_List'></ul>";
       	ul.append(li);
       	alert("创建分组成功！")
       	li.onclick = function(event) {
       		if(event.currentTarget.classList.contains("active"))
       			event.currentTarget.classList.remove("active");
       		else
       			event.currentTarget.classList.add("active");
       	}
        }
    })
    
	
}

document.getElementById("zoneBtn").onclick=function(){
	window.open('zone?uid='+id+"&myid="+id);
}






