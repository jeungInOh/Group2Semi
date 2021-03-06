<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div id="logiAdmWrap" style="text-align: center;">
<h1>주문배송조회</h1>
<div>
	<form method="post" action="<%=request.getContextPath()%>/admLogistic.do">
	<select name=field>
		<option value="id" <c:if test="${field=='id' }">selected</c:if>>아이디</option>
		<option value="itemname"<c:if test="${field=='itemname' }">selected</c:if>>물품이름</option>
		<option value="logiinfo"<c:if test="${field=='logiinfo' }">selected</c:if>>배송상태</option>
	</select>
	<input type="text" placeholder="검색어입력" name="keyword" value="${keyword }">
	<input type="submit" value="검색">
	</form>
</div>
<div>
	<table style="width: 880px; border: 1px solid black; text-align: center; margin-left: auto; margin-right: auto;">
		<tr>
			<th>아이디</th>
			<th>물품이름</th>
			<th>배송지주소</th>
			<th>배송상태</th>
			<th>변경</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
			<td><a href="<%=request.getContextPath()%>/admDetail.do?memid=${vo.memid}&logiinfo=${vo.logiinfo}&addr=${vo.addr}">${vo.id }</a></td>
			<td>${vo.itemname } 등</td>
			<td>${vo.addr }</td>
			<td>
				${vo.logiinfo }
				<input type="hidden" value="${vo.logiinfo }">
			</td>
			<td>
				<select name="logi">
					<option value="물품준비중"
					<c:if test="${vo.logiinfo=='물품준비중' }">selected</c:if>>물품준비중</option>
					<option value="발송완료"
					<c:if test="${vo.logiinfo=='발송완료' }">selected</c:if>>발송완료</option>
					<option value="배송완료"
					<c:if test="${vo.logiinfo=='배송완료'}">selected</c:if>>배송완료</option>
				</select>
				<input type="hidden" value="${vo.memid }">
				<input type="button" value="변경" onclick="changeLogi(event)">
			</td>
		</tr>
		</c:forEach>
	</table>
</div>
<div>
	<c:if test="${startPageNum>10 }">
		<a href="<%=request.getContextPath() %>/admLogistic.do?pageNum=${startPageNum-1 }&field=${field}&keyword=${keyword}">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${startPageNum}" end="${endPageNum }">
		<c:choose>
			<c:when test="${pageNum==i }">
				<a href="<%=request.getContextPath() %>/admLogistic.do?pageNum=${i}&field=${field}&keyword=${keyword}">
				<span style="color:gray">[${i }]</span></a>
			</c:when>
			<c:otherwise>
				<a href="<%=request.getContextPath() %>/admLogistic.do?pageNum=${i}&field=${field}&keyword=${keyword}">
				<span style="color:blue">[${i }]</span></a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${endPageNum<pageCount }">
		<a href="<%=request.getContextPath() %>/admLogistic.do?pageNum=${endPageNum+1 }&field=${field}&keyword=${keyword}">[다음]</a>
	</c:if>
</div>
</div>

<script type="text/javascript">
var msg='${code}';
if(msg!=""){
	alert(msg);
}
	function changeLogi(e){
		var logiinfo=e.target.previousSibling.previousSibling.previousSibling.previousSibling.value;
		var memid=e.target.previousSibling.previousSibling.value;
		var elogiinfo=e.target.parentNode.previousSibling.previousSibling.firstChild.nextSibling.value;

		if(confirm("배송상태를 바꾸시겠습니까?")){
			if(elogiinfo=='배송완료' || elogiinfo=='반품처리'){
				alert("배송완료 또는 반품상태입니다");
			}else{
				location.href="<%=request.getContextPath()%>/logiChange.do?elogiinfo="+elogiinfo+"&memid="+memid+"&logiinfo="+logiinfo;
			}
		}
	}
</script>