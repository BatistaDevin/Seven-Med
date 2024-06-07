<%@ page import="java.sql.*" %>
<%@ page import="com.crudjspjava.dao.LoginDao" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="styleAgenda.css"> <!-- Adicionando o estilo CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="background-image"> <!-- Adicionando a classe para o fundo de imagem -->
    <div class="container">
        <h2>Login Seven Med</h2>
        <form method="post" action="index.jsp">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" class="form-control" id="email" name="email">
            </div>
            <div class="form-group">
                <label for="password">Senha:</label>
                <input type="password" class="form-control" id="password" name="password">
            </div>
            <button type="submit" class="btn btn-primary">Entrar</button>
        </form>

        <% 
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email != null && password != null) {
                LoginDao dao = new LoginDao();
                if (dao.validate(email, password)) {
                    response.sendRedirect("viewconsulta.jsp");
                } else {
                    out.println("<div class='alert alert-danger' role='alert'>Usuário ou senha incorretos</div>");
                }
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger' role='alert'>Erro ao processar a solicitação: " + e.getMessage() + "</div>");
        }
        %>
    </div>
</body>
</html>

