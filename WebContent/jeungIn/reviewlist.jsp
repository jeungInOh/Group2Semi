<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

var msg='${code}';
if(msg=="fail"){
	alert("작업에 실패했습니다.");
}
	window.onload=function(){
		var xhr = null;
		xhr = new XMLHttpRequest();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4 && xhr.status==200){
				
				var json = JSON.parse(xhr.responseText);
				var div = document.getElementById("detailimg");
				
				var itemid = json.itemid;
				var itemname = json.itemname;
				var catid = json.catid;
				var price = "가격:"+json.price+"원";
				var factory = json.factory;
				var origin = json.origin;
				var stock = json.stock;
				var expire = json.expire;
				var storedate = json.storedate;
				var image = json.image;
				var avail = json.avail;
				
				
				var itemimg=document.getElementById("itemimage");
				itemimg.src="<%=request.getContextPath()%>/product/"+image;
				itemimg.style.width="400px";
				itemimg.style.height="300px";
				document.getElementById('itemname').innerHTML=itemname;
				document.getElementById('itemid').value=json.itemid; /*아이템아이디를 컨트롤러로 가져가게 추가*/
				document.getElementById('itemprice').innerHTML=price;
				
				document.getElementById('detailfactory').innerHTML=factory;
				document.getElementById('detailorigin').innerHTML=origin;
				document.getElementById('detailexpire').innerHTML=expire;
				document.getElementById('detailstock').innerHTML=stock;
				document.getElementById('detailavail').value=json.avail;
				
// 				if(세션체크){
// 					document.getElementById('itemname').innerHTML="로그인 하시면 10% 적립 및 쿠폰혜택 !";
// 				}
			}
		};
		xhr.open('get','<%= request.getContextPath() %>/detailitem.do?itemid=${ param.itemid}',true);
		xhr.send();
	}
	
	function insertBasket(){
		var itemid=document.getElementById("itemid").value;
		var stock=document.getElementById("detailstock").value;
		var avail=document.getElementById("detailavail").value;
		if(stock<=0 || avail==0){
			alert("수량이없거나 판매불가상태입니다.");
			return;
		}
		xhr=new XMLHttpRequest();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4 && xhr.status==200){
				var json=JSON.parse(xhr.responseText);
				if(json.code=="success"){
					alert("장바구니 담기 성공!");
					return;
				}else if(json.code=="overlap"){
					alert("이미 장바구니 목록에 있는 상품입니다");
					return;
				}else if(json.code=="fail"){
					alert("오류로 인해 실패");
					return;
				}
			}
		}
		xhr.open('get','../basketinsert.do?bd=b&amount=1&itemid='+itemid,true);
		xhr.send();
	}
	function insertDibs(){
		var itemid=document.getElementById("itemid").value;
		var stock=document.getElementById("detailstock").value;
		var avail=document.getElementById("detailavail").value;
		xhr=new XMLHttpRequest();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4 && xhr.status==200){
				var json=JSON.parse(xhr.responseText);
				if(json.code=="success"){
					alert("찜 담기 성공!");
					return;
				}else if(json.code=="overlap"){
					alert("이미 찜 목록에 있는 상품입니다");
					return;
				}else if(json.code=="fail"){
					alert("오류로 인해 실패");
					return;
				}
			}
		}
		xhr.open('get','../basketinsert.do?bd=d&amount=0&itemid='+itemid,true);
		xhr.send();
	}
</script>


<div id = "detail">
	<div id = "detailimg">
	<div style='float:left;'>
	<img id= "itemimage">
	</div>
	<div  class="form-group has-success has-feedback">
		<p class = "detailtitle">
	
		<button id = "itemname" class="btn btn-lg btn-primary" disabled="disabled"></button>
		<input type="hidden" id="itemid">
	</p>
		<div id='teamset'>
	
	<p class = "detailprice">
		
		<button type="button" class="btn btn-success" id="itemprice"></button>
	</p>
	<p class = "adv">
		<span id = "salenonsale"></span>
	<div class = "detailitem">
		<dl class="dl-horizontal" style="float: right;">
			<dt class ="tit">제조사</dt>
			<dd id = "detailfactory">|</dd>
			<dt class ="tit">원산지</dt>
			<dd id = "detailorigin">|</dd>
			<dt class ="tit">유통기한</dt>
			<dd id = "detailexpire">|</dd>
			<dt class ="tit">남은 재고</dt>
			<dd id = "detailstock">|</dd>
		</dl>
		<dl class = "list">
			
		</dl>
		<dl class = "list">
			
		</dl>
	</div>
	</div>
	<div class = "detailamount">
		<dl class = "list">
			
		</dl>
	</div>
		<button type = "button" onclick="insertBasket()">
			<img src = "<%=request.getContextPath() %>/icon/구매버튼.png" style="width:50px;height:50px">
		</button>
		<button type = "button" onclick="insertDibs()">
			<img src = "<%=request.getContextPath() %>/icon/heart.PNG" style="width:50px;height:50px">
		</button>
	<c:import url="/reviewlist2.do?itemid=${param.itemid }&pageNum=${param.pageNum }"></c:import>
	
	</div>
	
	

	</div>
	<input type="hidden" id="detailavail">
	<div class = "purchase">
	

	</div>
	
	</div>
