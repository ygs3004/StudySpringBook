<%--
  Created by IntelliJ IDEA.
  User: ygs30
  Date: 2022-10-09
  Time: 오후 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
  <form action="uploadFormAction" method="post" enctype="multipart/form-data">
    <input type="file" name="uploadFile" multiple>
    <button>Submit</button>
  </form>
</body>
</html>
