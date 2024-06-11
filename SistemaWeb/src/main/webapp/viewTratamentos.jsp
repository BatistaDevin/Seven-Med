<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista de Tratamentos</title>
<style>
    body {
        background-image: url('imagens/azul.jpg');
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 100%;
        max-width: 1000px;
        margin: 50px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0px 0px 20px 0px rgba(0,0,0,0.1);
    }
    h1 {
        text-align: center;
        color: #007bff;
        margin-top: 30px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 10px;
        overflow: hidden;
    }
    th, td {
        border: 1px solid #dee2e6;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #007bff;
        color: #fff;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
    .text-center {
        text-align: center;
        margin-top: 20px;
    }
    .btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #dc3545; /* Vermelho */
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
    }
    .btn:hover {
        background-color: #c82333; /* Vermelho mais escuro */
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Informação de Tratamentos</h1>
        
        <%-- Definição dos exames psicológicos e seus valores --%>
        <%
            Map<String, Double> tratamentos = new HashMap<>();
            tratamentos.put("Teste de Rorschach", 150.00);
            tratamentos.put("Teste de Apercepção Temática (TAT)", 120.00);
            tratamentos.put("Inventário de Personalidade de Minnesota (MMPI)", 200.00);
            tratamentos.put("Inventário de Depressão de Beck (BDI)", 100.00);
            tratamentos.put("Escala de Ansiedade de Hamilton (HAM-A)", 90.00);
            tratamentos.put("Teste de Personalidade de Millon (MCMI)", 180.00);
            tratamentos.put("Teste de Avaliação de Sintomas-90-R (SCL-90-R)", 160.00);
            tratamentos.put("Escala de Avaliação de Mania de Young (YMRS)", 170.00);
            tratamentos.put("Inventário de Ansiedade de Estado-Traço (STAI)", 110.00);
            tratamentos.put("Questionário de Saúde do Paciente (PHQ-9)", 130.00);
        %>
        
        <table border="1">
            <thead>
                <tr>
                    <th>Exame Psicológico</th>
                    <th>Valor (R$)</th>
                </tr>
            </thead>
            <tbody>
                <%-- Iteração sobre os tratamentos para exibir na tabela --%>
                <%
                    for (Map.Entry<String, Double> entry : tratamentos.entrySet()) {
                %>
                <tr>
                    <td><%= entry.getKey() %></td>
                    <td><%= entry.getValue() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <div class="text-center">
            <a href="viewcliente.html" class="btn">Voltar para Home</a>
        </div>
    </div>
</body>
</html>
