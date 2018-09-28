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
        window.onload = function () {
            document.getElementById("btn").onclick = function () {
                var xmlhttp = null;
                if (window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                }
                else {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }

                var table = document.getElementById("tbl");

                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var resultJson = xmlhttp.responseText; // 接受返回的数据
                        var jsonObject = JSON.parse(resultJson); // 将返回的数据转换为json

                        var tcs = table.getElementsByTagName("tr");
                        for(var a=tcs.length-1;a>=1;a--){
                            table.deleteRow(a);
                        }

                        for (var i = 0; i < jsonObject.length; i++) {
                            var tr = document.createElement("tr");
                            var td = document.createElement("td");
                            td.innerHTML = jsonObject[i].bname;
                            var td1 = document.createElement("td");
                            td1.innerHTML = jsonObject[i].price;
                            tr.appendChild(td);
                            tr.appendChild(td1);
                            table.appendChild(tr);
                        }
                    }
                }
                xmlhttp.open("GET", "/getjson", true);
                xmlhttp.send();
            }
        }
    </script>
</head>
<body>
<input type="text" name="bookname"/><input type="button" id="btn" value="查询"/>
<table id="tbl" class="table table-bordered table-hover table-striped">
<tr><th>书名</th><th>价格</th><th>操作</th></tr>
</table>
</body>
</html>
