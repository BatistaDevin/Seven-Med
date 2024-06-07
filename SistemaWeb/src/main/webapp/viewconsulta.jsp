<%@ page import="java.util.List" %>
<%@ page import="com.crudjspjava.bean.Consulta" %>
<%@ page import="com.crudjspjava.dao.ConsultaDao" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consulta de Exames</title>
    <link rel="stylesheet" href="styleAgenda.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="background-image">
    <div class="container">
        <h2>Consulta de Exames</h2>
        
        <%-- Verificar se há uma mensagem para exibir --%>
        <% String mensagem = request.getParameter("mensagem");
           if (mensagem != null && !mensagem.isEmpty()) { %>
            <div class="alert alert-success" role="alert">
                <%= mensagem %>
            </div>
        <% } %>
        
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Exame</th>
                    <th>Hora</th>
                    <th>Data</th>
                </tr>
            </thead>
            <tbody>
                <% 
                // Obtendo o nome da pessoa preenchido no formulário
                String nomeConsulta = request.getParameter("nome");
                
                // Verificar se o nome foi fornecido
                if (nomeConsulta != null && !nomeConsulta.isEmpty()) {
                    // Obtendo apenas a consulta agendada para a pessoa
                    Consulta consulta = ConsultaDao.getConsultaByNome(nomeConsulta);
                    if (consulta != null) {
                %>
                <tr>
                    <td><%= consulta.getId() %></td>
                    <td><%= consulta.getNome() %></td>
                    <td><%= consulta.getExame() %></td>
                    <td><%= consulta.getHora() %></td>
                    <td><%= consulta.getData() %></td>
                </tr>
                <% } else { %>
                <tr>
                    <td colspan="5">Nenhuma consulta agendada para <%= nomeConsulta %></td>
                </tr>
                <% } 
                } else { %>
                <tr>
                    <td colspan="5">Nenhum nome de consulta fornecido</td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <h2>Adicionar Nova Consulta</h2>
        <form method="post" action="adicionarConsulta.jsp">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" class="form-control" id="nome" name="nome">
            </div>
            <div class="form-group">
                <label for="exame">Exame:</label>
                <input type="text" class="form-control" id="exame" name="exame">
            </div>
            <div class="form-group">
                <label for="hora">Hora:</label>
                <input type="time" class="form-control" id="hora" name="hora">
            </div>
            <div class="form-group">
                <label for="data">Data:</label>
                <input type="date" class="form-control" id="data" name="data">
            </div>
            <button type="submit" class="btn btn-primary">Adicionar Consulta</button>
        </form>
        
        <!-- Botão "Voltar para Home" -->
        <div class="text-left mt-3">
            <a href="viewcliente.html" class="btn btn-danger">Voltar para Home</a>
        </div>
    </div>
</body>
</html>
