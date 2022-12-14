<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>admin</title>
</head>
<body>
    <h1>/sample/admin page</h1>
    <p>principal : <sec:authentication property="principal"/> </p>
    <p>MemberVO : <sec:authentication property="principal.member"/> </p>
    <p>사용자이름 : <sec:authentication property="principal.member.userName"/> </p>
    <p>사용자아이디 : <sec:authentication property="principal.username"/> </p>
    <p>사용자 권한 리스트 : <sec:authentication property="principal.member.authList"/> </p>
    <a href="/customLogout">Logout</a>
</body>
</html>
