<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin/memberlist.jsp</title>
<style type="text/css">
    #content div{align-self: center;}
    /* #list{margin:auto; padding:auto;} */
    #list{width:fit-content;}
    #pagectrl{text-align: center;}
    #pagectrl *{display:inline-block; }
    .paging{padding: 20px;}
    .paging_before{padding: 20px;}
    .paging_after{padding:20px;}
    #currpage{font-size: 2em;}
    #errMsg{text-align: center;}
    #eukyunpoint{width:80px;}
</style>
</head>
<body>
    <div id="content">
        <div id="listctrl">
            <label for="rowsize">리스트크기</label>
            <select name="rowsize" id="rowsize">
                <option value="10" selected>10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="25">25</option>
            </select>
            <label for="orderby">컬럼</label>
            <select name="orderby" id="orderby">
                <option value="memid" selected>회원번호</option>
                <option value="id">아이디</option>
                <option value="age">나이</option>
                <option value="email">이메일</option>
                <option value="addr">주소</option>
                <option value="regdate">가입일</option>
                <option value="phone">전화번호</option>
                <option value="point">포인트</option>
            </select>
            <label for="order">순서</label>
            <select name="order" id="order">
                <option value="asc" selected>오름차순</option>
                <option value="desc">내림차순</option>
            </select>
            <label for="pagesize">페이지 수</label>
            <select name="pagesize" id="pagesize">
                <option value="5">5</option>
                <option value="10" selected>10</option>
            </select>
        </div>
        <div id="list">
            <table id='table'>
            	<thead>
	            	<tr>
		                <th><input type="checkbox" name="체크" id="checkall"></th>
		                <th id="t_memid">회원번호</th>
		                <th id="t_id">아이디</th>
		                <th id="t_age">생년월일</th>
		                <th id="t_sex">성별</th>
		                <th id="t_email">이메일</th>
		                <th id="t_addr">주소</th>
		                <th id="t_regdate">가입일</th>
		                <th id="t_phone">전화번호</th>
		                <th id="t_point">포인트</th>
	                	<th id="t_status">회원종류</th>
	                	<th id="t_cancel"></th>
	                </tr>
            	</thead>
	            <tbody id='tbody'></tbody>
            </table>
        </div>
        <div id="pagectrl"></div>
        <div id="searchctrl">
            <label for="type">검색</label>
            <select name="type" id="type"><option value="memid" selected>회원번호</option><option value="id">아이디</option><option value="age">생년월일</option><option value="sex">성별</option><option value="regdate">가입일</option><option value="point">포인트</option><option value="status">회원종류</option></select>
            <input type="text" name="search" id="search">
            <label for="details">상세검색</label>
            <input type="checkbox" name="details" id="details">
            <input type="button" value="검색하기" id="searchbtn">

            <!-- TODO: -->
            <label for="batchedittype">일괄수정</label>
                <select name="batchedittype" id="batchedittype">
                    <option value="point">포인트</option>
                    <option value="status">회원종류</option>
                </select>
            </label>
            <input type="text" id="batcheditpoint" placeholder="+, -, *, /">
            <select id="batcheditstatus"><option value="-1">탈퇴회원</option><option value="1">일반회원</option><option value="2">관리자</option></select>

            <input type="button" value="변경하기" id='batcheditbtn'>

            <div id="detailsearch">
                <!-- 상세검색 -->
                <div id="d_age"><label for="d_age">생년월일</label><input type="text" name="agemin" id="agemin" placeholder="최소">~<input type="text" name="agemax" id="agemax" placeholder="최대"></div>
                <div id="d_regdate"><label for="d_regdate">가입일</label><input type="text" name="regdatemin" id="regdatemin" placeholder="최소">~<input type="text" name="regdatemax" id="regdatemax" placeholder="최대"></div>
                <div id="d_point"><label for="d_point">포인트</label><input type="text" name="pointmin" id="pointmin" placeholder="최소">~<input type="text" name="pointmax" id="pointmax" placeholder="최대"></div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        //페이지설정용 엘리먼트
        let rowsize = document.getElementById('rowsize');
        let order = document.getElementById('order');
        let orderby = document.getElementById('orderby');
        let pagesize = document.getElementById('pagesize');
        rowsize.addEventListener("change", showlist, false);
        order.addEventListener("change", showlist, false);
        orderby.addEventListener("change", showlist, false);
        pagesize.addEventListener("change", showlist, false);
        
        //페이지번호용 엘리먼트
        let pagectrl = document.getElementById('pagectrl');
        
        //검색용 엘리먼트
        let searchctl = document.getElementById('searchctl');
        searchctrl.addEventListener("keydown", function (e) {
            if (e.keyCode==13) showlist(e);
        }, false);
        let type = document.getElementById('type');
        let search = document.getElementById('search');
        let details = document.getElementById('details');
        let detailsearch = document.getElementById('detailsearch');
        let searchbtn = document.getElementById('searchbtn');
        detailsearch.style="display:none";
        searchbtn.addEventListener('click', showlist, false);
        let batchedittype = document.getElementById('batchedittype');
        let batcheditpoint = document.getElementById('batcheditpoint');
        let batcheditstatus = document.getElementById('batcheditstatus');
        
        let batcheditbtn = document.getElementById('batcheditbtn');
        



        let agemin = document.getElementById('agemin');
        let agemax = document.getElementById('agemax');
        let regdatemin = document.getElementById('regdatemin');
        let regdatemax = document.getElementById('regdatemax');
        let pointmin = document.getElementById('pointmin');
        let pointmax = document.getElementById('pointmax');

        details.addEventListener('click', detailhide, false);
        function detailhide() {
            if (details.checked) {
                detailsearch.style="display:";
            }else {
                detailsearch.style="display:none";
                agemin.value="";
                agemax.value="";
                regdatemin.value="";
                regdatemax.value="";
                pointmin.value="";
                pointmax.value="";
            }
        }

        //order 설정 영역
        let t_memid = document.getElementById('t_memid');
        let t_id = document.getElementById('t_id');
        let t_age = document.getElementById('t_age');
        let t_sex = document.getElementById('t_sex');
        let t_email = document.getElementById('t_email');
        let t_addr = document.getElementById('t_addr');
        let t_regdate = document.getElementById('t_regdate');
        let t_phone = document.getElementById('t_phone');
        let t_point = document.getElementById('t_point');
        let t_status = document.getElementById('t_status');
        let t_cancel = document.getElementById('t_cancel');
        


//#region 멤버 선택 기능
/**
 * checkbox로 선택하는 기능
 * 선택된걸 기억하고 다른 페이지로 돌아왔을 때 다시 선택되게 해야 함
 * 검색조건이 바뀌면 초기화됨
 */
        
        const selected = [];
        
        let checkall = document.getElementById('checkall');
        checkall.addEventListener('click', function(e){
            let selmem = document.getElementsByName('selectmember');
            selmem.forEach((entries)=>{
                if (checkall.checked){
                    if (!entries.checked) {
                        entries.checked=true;
                        tdcheckboxevent(entries);
                    }
                }else {
                    if (entries.checked) {
                        entries.checked=false;
                        tdcheckboxevent(entries);
                    }
                }
            });
        });

        function checkallstate() {
            let selmem = document.getElementsByName('selectmember');
            let allgreen = Array.from(selmem).some(box=>{return !box.checked;});
            checkall.checked=!allgreen;
        }
        function tdcheckboxevent(tgt) {
            if (tgt.checked) selected.push(tgt.value);
            else {
                let idx = selected.findIndex((element)=>element==tgt.value);
                if (idx>=0) selected.splice(idx, 1);
            }
            console.log(selected);
        }

        function selected_cleanall() {
            selected.splice(0);
            checkallstate();
        }

        function tdcheckboxmaker(memid){
            let box = document.createElement("input");
            box.type='checkbox';
            box.name='selectmember';
            box.value=memid;
            if (selected.findIndex((element)=>element==memid)>=0) box.setAttribute("checked", true);
            box.addEventListener('click', function(e){
                tdcheckboxevent(e.target);
                checkallstate();
            });
            return box;
        }
//#endregion
//#region 일괄수정기능
        batcheditstatus.style.display="none";
        batchedittype.addEventListener("change", batchedittypeevent);
        batcheditbtn.addEventListener('click', function(e) {
            batchedit();
        });

        function batchedittypeevent(e) {
            if (e.target.value=='point') {
                batcheditstatus.style.display="none";
                batcheditpoint.style.display="";
            }else {
                batcheditstatus.style.display="";
                batcheditpoint.style.display="none";
            }
        }

        function batchedit() {
            if (selected.length>0) {
                let pass=false;
                let param="";
                selected.forEach(function (elem) {
                    param+="memids="+elem+"&";
                });
                param+="type="+batchedittype.value;
                if (batchedittype.value=='point') {
                    if (/^[+-/*]??\d+$/.test(batcheditpoint.value)) {
                        param+="&value="+encodeURIComponent(batcheditpoint.value);
                        pass=true;
                    } else {
                        alert("잘못된 입력입니다.");
                        batcheditpoint.value="";
                    }
                }else {
                    param+="&value="+batcheditstatus.value;
                    pass=true;
                }
                console.log(param+pass);

                if (pass) {
                    let xhr = new XMLHttpRequest();
                    xhr.onreadystatechange=function() {
                        if (xhr.readyState==4 && xhr.status==200) {
                            let json = JSON.parse(xhr.responseText);
                            if (JSON.parse(json.result)) {
                                alert("변경되었습니다.");
                            }else alert("에러 발생");
                            showlist();
                        }
                    };
                    xhr.open('post', '../admin/memberlist.edit', true);
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.send(param);
                    
                    // console.log("aaa"+scl.findIndex((element)=>element=='일반회원'));
                }
            }
        }
        //^[+-/*]??\d+$
//#endregion



//#region list생성용 엘리먼트
        let list = document.getElementById('list');
        let table = document.getElementById('table');
        let tbody = document.getElementById('tbody');
        const scl = ["탈퇴회원", "에러", "일반회원", "관리자", "임시회원"];
        const sex = ["", "남자", "여자", "남자", "여자"];
        const ageexp = /(.{6})(.)/;
        
        /** 
         *페이지 내에서 유지되는 파라미터(검색조건이 수정되었지만 검색하지 않을 때 필요함)
         *검색어를 입력했지만 검색버튼을 누르지 않고 페이지 버튼을 눌렀을때 사용
         */
        let unchangedparameters="";
        let pagenum=1;
        /**
         * @param args 숫자면 page 변경, 숫자가 아니면...
         * 받는 event의 종류
         * 검색관련 - searchctrl, searchbtn - 검색조건이 바뀜(페이지는 1페이지로 초기화)
         * 페이지설정관련 - rowsize, pagesize- 검색조건이 바뀌지 않음(페이지는 1페이지로 초기화)
         * order, orderby - 페이지 초기화할 필요가 없음
         */
        function showlist(args) {
            let param = "order="+order.value+"&orderby="+orderby.value+"&rowsize="+rowsize.value+"&pagesize="+pagesize.value;
            if (args==undefined) param+="&pagenum="+pagenum;
            else if (args!=event) {
                pagenum=args;
                param+="&pagenum="+pagenum;
            }
            else if (args.target.id.includes('order',0)) {
                param+="&pagenum="+pagenum;
            }
            else if (args.target.id.includes('search',0)) {
                selected_cleanall(); //선택된 목록도 초기화한다.
                let searchparam = "&type="+type.value+"&search="+search.value;
                if (details.checked) searchparam+="&agemin="+agemin.value+"&agemax="+agemax.value+"&regdatemin="+regdatemin.value+"&regdatemax="+regdatemax.value+"&pointmin="+pointmin.value+"&pointmax="+pointmax.value;
                unchangedparameters=searchparam;
            }
            param+=unchangedparameters;
            

            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange=function() {
                if (xhr.readyState==4 && xhr.status==200) {
                    cleartable();
                    const json = JSON.parse(xhr.responseText);
                    pagenum=JSON.parse(json.pagenum);
                    console.log("pagenum renew: "+pagenum);
                    const startpage=JSON.parse(json.startpage);
                    const endpage = JSON.parse(json.endpage);
                    const maxpage = JSON.parse(json.maxpage);
                    const endrow = JSON.parse(json.endrow);
                    const startrow = JSON.parse(json.startrow);
                    const rowsize = JSON.parse(json.rowsize);
                    if (rowsize==0) {
                        const tr = document.createElement("tr");
                        const td = document.createElement("td");
                        td.setAttribute('colspan', 11);
                        const nothing = document.createElement("p");
                        nothing.id="errMsg";
                        nothing.innerText="결과가 없습니다.";
                        td.append(nothing);
                        tr.append(td);
                        tbody.append(tr);
                    }
                    else{
                        //#region 리스트생성
                        for (let index = 0; index<Math.min(endrow, rowsize)-startrow+1; index++) {
                            const mem = json.list[index];
                            const tr = document.createElement("tr");
                            tr.id=mem.memid;
                            tr.className="listrows";

                            const tdcheckbox = document.createElement("td");
                            const tdcheckboxlabel = document.createElement("label");
                            tdcheckboxlabel.setAttribute('for', mem.memid);
                            tdcheckboxlabel.textContent=mem.rnum;
                            const tdcheckboxinput = tdcheckboxmaker(mem.memid);

                            tdcheckboxlabel.append(tdcheckboxinput);
                            tdcheckbox.append(tdcheckboxlabel);

                            const tdmemid = document.createElement("td");
                            tdmemid.textContent=mem.memid;
                            
                            const tdid = document.createElement("td");
                            tdid.textContent=mem.id;
                            
                            const tdage = document.createElement("td");
                            tdage.textContent=mem.age.toString().replace(ageexp, "$1");
                            
                            const tdsex = document.createElement("td");
                            tdsex.textContent=sex[mem.age.toString().replace(ageexp, "$2")];
                            
                            const tdemail = document.createElement("td");
                            tdemail.textContent=mem.email;
                            
                            const tdaddr = document.createElement("td");
                            tdaddr.textContent=mem.addr;
                            
                            const tdregdate = document.createElement("td");
                            tdregdate.textContent=mem.regdate;
                            
                            const tdphone = document.createElement("td");
                            tdphone.textContent=mem.phone;
                            
                            const tdpoint = document.createElement("td");
                            tdpoint.append(tdpointinput(mem.point));
                            
                            const tdstatus = document.createElement("td");
                            // tdstatus.textContent=scl[JSON.parse(mem.status)+1];
                            tdstatus.append(tdstatusinput(JSON.parse(mem.status)+1));

                            // const tdcancel = document.createElement("td");

                            tr.append(tdcheckbox);
                            tr.append(tdmemid);
                            tr.append(tdid);
                            tr.append(tdage);
                            tr.append(tdsex);
                            tr.append(tdemail);
                            tr.append(tdaddr);
                            tr.append(tdregdate);
                            tr.append(tdphone);
                            tr.append(tdpoint);
                            tr.append(tdstatus);
                            // tr.append(tdcancel);
                            tbody.append(tr);
                            checkallstate();
                        }
                        //#endregion
                        //#region paging
                        let div = document.createElement("div");
                        function makepagingp(index) {
                            let p = document.createElement("p");
                            p.addEventListener('click', function (e) {
                                showlist(e.target.textContent);
                            }, false);
                            p.innerText = index;
                            return p;
                        }
                        // div.className = "paging";
                        if (startpage>pagesize.value) {
                            let p = makepagingp(startpage-1);
                            p.className="paging_before";
                            div.append(p);
                        }
                        for (let i=startpage; i<=endpage; i++) {
                            let p = makepagingp(i);
                            p.className="paging";
                            if (i==pagenum) p.id="currpage";
                            div.append(p);
                        }
                        if (maxpage>endpage) {
                            let p = makepagingp(endpage+1);
                            p.className="paging_after";
                            div.append(p);
                        }
                        pagectrl.append(div);
                        //#endregion
                    }
                }else if (xhr.readyState==4 && xhr.status!=200) {
                    let tr = document.createElement("tr");
                    let td = document.createElement("td");
                    td.setAttribute('colspan', 11);
                    let nothing = document.createElement("p");
                    nothing.id="errMsg";
                    nothing.innerText="에러가 발생했습니다.";
                    td.append(nothing);
                    tr.append(td);
                    tbody.append(tr);
                }
            }
            xhr.open('post', '../admin/memberlist', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            console.log(param);
            xhr.send(param);
        }

        /**
         * 리스트 초기화 처리
         */
        function cleartable() {
            while(tbody.firstChild) {tbody.firstChild.remove();}
            while(pagectrl.firstChild) {pagectrl.firstChild.remove();}
            //selectedclean은 여기 넣지 않는다.
        }
//#endregion

//#region 검색부
        function tdpointinput(value) {
            const input = document.createElement("input");
            input.type="text";
            input.className="point";
            input.id="eukyunpoint";
            input.value=value;
            input.setAttribute("data-orig", value);
            input.addEventListener('keyup', function (e) {
                if (!/^\d+$/.test(e.target.value)) e.target.value = e.target.value.replace(/[\D]/g, "");
                else{
                    console.log(e.target);
                    console.log(e.target.parentNode.parentNode.id);
                    memedit(e.target);
                }
            });
            return input;
        }
        
        function tdstatusinput(value) {
            const select = document.createElement("select");
            select.className="status";
            for(let i=0;i<scl.length; i++) {
                const opt = document.createElement("option");
                opt.value=i-1;
                opt.textContent=scl[i];
                if (i==value) opt.setAttribute("selected", true);
                select.append(opt);
            }
            select.addEventListener('change', function(e){
                // showcancel(e.target);
                memedit(e.target);
            });
            return select;
        }
//#endregion




        // function showcancel() {
        //     //TODO: 취소버튼, update
        //     console.log(arguments);
        // }
        function memedit(elem) {
            let edittarget = elem.parentNode.parentNode.id;
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange=function() {
                if (xhr.readyState==4 && xhr.status==200) {
                    let json = JSON.parse(xhr.responseText);
                    if (!JSON.parse(json.result)) {
                        alert("에러가 발생했습니다.");
                    }
                    showlist();
                }
            };
            xhr.open('post', '../admin/memberlist.edit', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            let param = "memids="+edittarget+"&type="+elem.className+"&value="+elem.value;
            console.log(param);
            xhr.send(param);
        }
        
        


        //페이지 로드 후 자동 실행
        showlist();
    </script>
</body>
</html>