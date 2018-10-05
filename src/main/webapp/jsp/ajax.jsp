<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/9/28 0028
  Time: 下午 3:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>ajax test</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">

    <script src="../js/jquery-3.3.1.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script type="text/javascript">

        function sendAjax(url, methodType, params, reFun) { // url是请求的地址,methodType是请求的类型,params是请求的参数(须是键值对的形式),retnFunction是一个函数
            var xmlhttp = null;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            }
            else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    reFun(xmlhttp.responseText); // 调用这个函数将返回的数据当作参数传进这个函数
                }
            }

            if (methodType == "get" || methodType == "GET") { // 判断请求类型是get还是post
                xmlhttp.open("GET", url + "?" + params, true);
                xmlhttp.send();
            } else {
                xmlhttp.open("POST", url, true);
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
                xmlhttp.send(params);
            }
        }
        function query() {
            var table = document.getElementById("tbl");
            sendAjax("/getjson", "get", "param", function (responseText) {
                var resultJson = responseText; // 接受返回的数据
                var jsonObject = JSON.parse(resultJson); // 将返回的数据转换为json

                var tcs = table.getElementsByTagName("tr");
                for (var a = tcs.length - 1; a >= 0; a--) {
                    table.deleteRow(a);
                }

                for (var i = 0; i < jsonObject.length; i++) {
                    var tr = document.createElement("tr");

                    var td = document.createElement("td");
                    td.innerHTML = jsonObject[i].bname;

                    var td1 = document.createElement("td");
                    td1.innerHTML = jsonObject[i].price;

                    var td2 = document.createElement("td");
                    var btn = document.createElement("button");
                    btn.innerText="删除";
                    btn.nowTr = tr; // 删除行的话,需要将指定的tr,保存至btn的自定义属性
                    btn.id = jsonObject[i].bid; // 做删除操作的话,需要传入商品的id,将商品的id保存至btn的自定义属性
                    btn.addEventListener("click",function () { // 添加事件监听器
                        var eventEle = event.srcElement; // 调用事件的元素对象
                        table.removeChild(eventEle.nowTr); // 删除行
                        sendAjax("/deljson","GET","bid="+eventEle.id,function (responseText) {
                        });
                    });
                    td2.appendChild(btn);
                    var btn1 = document.createElement("button");
                    btn1.innerText="修改";
                    btn1.obj = jsonObject[i];
                    btn1.addEventListener("click",function () {
                        var eventEle = event.srcElement;
                        document.getElementById('updateDiv').style.display='block';
                        document.getElementsByName("ubname")[0].value = eventEle.obj.bname;
                        document.getElementsByName("uprice")[0].value = eventEle.obj.price;
                        document.getElementsByName("ubid")[0].value = eventEle.obj.bid;
                    });
                    td2.appendChild(btn1);

                    tr.appendChild(td);
                    tr.appendChild(td1);
                    tr.appendChild(td2);

                    table.appendChild(tr);
                }
            });
        }

    function saveBook() {
        var bname = document.getElementsByName("bname")[0].value;
        var price = document.getElementsByName("price")[0].value;
        var author = document.getElementsByName("author")[0].value;
        var image = document.getElementsByName("image")[0].value;
        var cid = document.getElementsByName("cid")[0].value;
        var del = document.getElementsByName("del")[0].value;

        sendAjax("/insjson","POST","bname="+bname+"&price="+price+"&author="+author+"&image="+image+"&cid="+cid+"&del="+del,function (responseText) {
            document.getElementById('addDiv').style.display='none';
            query();
        });
    }

    function updateBook() {
        var bname = document.getElementsByName("ubname")[0].value;
        var price = document.getElementsByName("uprice")[0].value;
        var bid = document.getElementsByName("ubid")[0].value;
        sendAjax("/updjson/"+bid,"POST","_method=put&bname="+bname+"&price="+price,function (responseText) {
        });
    }

    </script>
</head>
<body>
<input type="text" name="bookname"/><input type="button" onclick="query()" value="查询"/><input type="button" value="新增" onclick="document.getElementById('addDiv').style.display='block'"/>
<table class="table table-bordered table-hover table-striped table-condensed">
    <thead>
    <tr>
        <th>书名</th>
        <th>价格</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="tbl">

    </tbody>
</table>

<div id="addDiv" style="position: absolute;left: 15%;top: 70%;border: 1px solid;display: none;width: 250px;height: 250px;">
    bname:<input type="text" name="bname"/><br/>
    price:<input type="text" name="price"/><br/>
    author:<input type="text" name="author"/><br/>
    image:<input type="text" name="image"/><br/>
    cid:<input type="text" name="cid"/><br/>
    del:<input type="text" name="del"/><br/>
    <input type="button" value="保存" onclick="saveBook()"/><input type="button" value="关闭" onclick="document.getElementById('addDiv').style.display='none'"/>
</div>
<div id="updateDiv" style="position: absolute;left: 30%;top: 70%;border: 1px solid;display: none;width: 250px;height: 100px;">
    <input type="hidden" name="ubid"/><br/>
    bname:<input type="text" name="ubname"/><br/>
    price:<input type="text" name="uprice"/><br/>
    <input type="button" value="修改" onclick="updateBook()"/><input type="button" value="关闭" onclick="document.getElementById('updateDiv').style.display='none'"/>
</div>
</body>
</html>
