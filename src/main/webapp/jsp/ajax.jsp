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

        function sendAjax(url, methodType, params, retnFunction) { // url是请求的地址,methodType是请求的类型,params是请求的参数(须是键值对的形式),retnFunction是一个函数
            var xmlhttp = null;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            }
            else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }

            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    retnFunction(xmlhttp.responseText); // 调用这个函数将返回的数据当作参数传进这个函数
                }
            }

            if (methodType == "get" || methodType == "GET") { // 判断请求类型是get还是post
                xmlhttp.open(methodType, url + "?" + params, true);
                xmlhttp.send();
            } else {
                xmlhttp.open(methodType, url, true);
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
                xmlhttp.send(params);
            }
        }


        window.onload = function () {

            document.getElementById("btn").onclick = function () {
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
                           sendAjax("/deljson","get","bid="+eventEle.id,function (responseText) {
                           });
                        });
                        td2.appendChild(btn);

                        tr.appendChild(td);
                        tr.appendChild(td1);
                        tr.appendChild(td2);

                        table.appendChild(tr);
                    }
                });
            }
        }
    </script>
</head>
<body>
<input type="text" name="bookname"/><input type="button" id="btn" value="查询"/>
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
</body>
</html>
