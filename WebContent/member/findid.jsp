<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>member/findid.html</title>
    <script type="text/javascript">
        window.onload=function() {
            let findword = document.getElementById('findword');
            let mailexp = /^[a-z0-9_+.]+@[a-z0-9.]+\.\w{2,4}$/;
            let phone = /^(\d{3})-?(\d{4})-?(\d{4})$/;
            let findMsg = document.getElementById('findMsg');
            let result = document.getElementById('result');
            let find = document.getElementById('find');
            
            find.addEventListener('click', findid, false);
            findword.addEventListener("keyup", check, false);
            findword.addEventListener("keydown", function (e) {
                // console.log(e.keyCode);
                if (e.keyCode==13) {
                    findid();
                }
            }, false);
            function check() {
                findMsg.textContent="";
                let param = null;
                // console.log(findword.value);
                let tmp = findword.value;
                if (mailexp.test(tmp)) {
                    param = "target=email&value="+tmp;
                    // findMsg.textContent="mail";
                }else if (phone.test(tmp)) {
                    param = "target=phone&value="+tmp;
                    // findMsg.textContent="phone";
                }else if (tmp.length!=0) {
                    if (param!=null) param=null;
                    findMsg.textContent="잘못된 입력입니다.";
                }else {
                    if (param!=null) param=null;
                    findMsg.textContent="";
                }
                return param;
            }

            function findid() {
                result.innerHTML="";
                let param = check();
                // console.log(param);
                if (param==null) {}
                else {
                    let xhr = new XMLHttpRequest();
                    xhr.onreadystatechange=function() {
                        if (xhr.readyState==4 && xhr.status==200) {
                            let json = JSON.parse(xhr.responseText);
                            console.log(json);
                            console.log(json.result);
                            console.log(json.find);
                            // console.log(json.find + json.result);
                            let resultMsg = document.createElement("p");
                            //TODO:CSS
                            //@jeungInOh
                            /* resultMsg.setAttribute('id' )
                            resultMsg.setAttribute('class' ) */

                            if (JSON.parse(json.find)) {
                                resultMsg.textContent="ID는 "+json.result+"입니다.";
                            }else resultMsg.textContent=json.result;
                            result.append(resultMsg);
                        }
                    };
                    xhr.open('post', '../member/findid.do', true);
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.send(param);
                }
            }
        }
    </script>
</head>
<body>
    <div id="content">
        <h1>아이디찾기</h1>
        <!-- <form action="" method="get"> -->
            <div id="result"></div>
            <div>
                <label for="findword">이메일이나 전화번호를 입력하세요</label>
                <span id="findMsg"></span>
                <div id="findrow" class="inputrow">
                    <input type="text" name="" id="findword" placeholder="이메일or전화번호">
                </div>
            </div>
        <!-- </form> -->
        <div id="btns">
            <input type="button" value="돌아가기" onclick="history.back()">
            <!-- <input type="submit" value="조회하기"> -->
            <input type="button" value="조회하기" id='find'>
        </div>
    </div>
</body>
</html>