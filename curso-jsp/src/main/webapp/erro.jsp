<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tela que mostra os erros</title>
</head>
<body>
	<h1>Mensagem de Erro, entre em contato com a equipe de suporte do sistema.</h1>
<%-- 	<textarea rows="50" cols="50">${msg}</textarea> --%>
	
<%
out.print(request.getAttribute("msg"));
%>

</body>
</html>