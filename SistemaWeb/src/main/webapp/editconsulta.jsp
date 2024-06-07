<%@ page import="com.crudjspjava.bean.Consulta, com.crudjspjava.dao.ConsultaDao" %>
<%
    String id = request.getParameter("id");
    Consulta consulta = null;
    if (id != null && !id.trim().isEmpty()) {
        try {
            consulta = ConsultaDao.getConsultaById(Integer.parseInt(id));
        } catch (NumberFormatException e) {
            System.out.println("ID inv�lido: " + e.getMessage());
        }
    } else {
        System.out.println("ID n�o fornecido ou est� vazio.");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edi��o de Consulta</title>
</head>
<body>
    <h1>EDI��O DE CONSULTA</h1>
    <% if (consulta != null) { %>
        <form action="editarconsulta" method="post">
            <input type="hidden" name="id" value="<%=consulta.getId()%>"/>
            <table>
                <tr>
                    <td>Nome:</td>
                    <td><input type="text" name="nome" value="<%=consulta.getNome()%>"/></td>
                </tr>
                <tr>
                    <td>Exame:</td>
                    <td><input type="text" name="exame" value="<%=consulta.getExame()%>"/></td>
                </tr>
                <tr>
                    <td>Hora:</td>
                    <td><input type="time" name="hora" value="<%=consulta.getHora()%>"/></td>
                </tr>
                <tr>
                    <td>Data:</td>
                    <td><input type="date" name="data" value="<%=consulta.getData()%>"/></td>
                </tr>
                <tr>
                    <td>Conclu�do:</td>
                    <td><input type="checkbox" name="concluido" <%= consulta.isConcluido() ? "checked" : "" %> /></td>
                </tr>
                <tr>
                    <td>Diagn�stico:</td>
                    <td><input type="text" name="diagnostico" value="<%=consulta.getDiagnostico()%>"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Salvar"/></td>
                </tr>
            </table>
        </form>
    <% } else { %>
        <p>Consulta n�o encontrada ou ID n�o fornecido.</p>
    <% } %>
</body>
</html>
