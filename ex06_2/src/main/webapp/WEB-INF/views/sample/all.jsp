<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>all</title>
</head>
<body>
<%-- all or member or admin --%>
<h1>/sample/all page</h1>

<%--
표현식
hasRole([role]), hasAuthority([authority]) : 해당 권한이 있으면 true
hasAnyRole([role.role2]), hasAnyAuthority([authority]) : 여러 권한들 중에서 하나라도 해당하는 권한이 있으면 true
principal : 현재 사용자 정보를 의미
permitAll : 모든 사용자에게 허용
denyAll : 모든 사용자에게 거부
isAnonymous() : 익명의 사용자의 경우(로그인을 하지 않은 경우도 해당)
isAuthenticated() : 인증된 사용자면 true
isFullyAuthenticated() : Remember-me로 인증된 것이 아닌 인증된 사용자인 경우 true
--%>
<sec:authorize access="isAnonymous()">
    <a href="/customLogin">로그인</a>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <a href="/customLogout">로그아웃</a>
</sec:authorize>

</body>
</html>
