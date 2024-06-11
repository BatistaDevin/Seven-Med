<%@ page import="com.crudjspjava.dao.ConsultaDao" %>
<%
String id = request.getParameter("id");
if (id != null) {
    try {
        int consultaId = Integer.parseInt(id);
        int status = ConsultaDao.deleteConsulta(consultaId);
        if (status > 0) {
            response.sendRedirect("viewMedico.jsp?mensagem=Consulta exclu�da com sucesso");
        } else {
            out.println("<div class='alert alert-danger' role='alert'>Erro ao excluir a consulta.</div>");
        }
    } catch (Exception e) {
        out.println("<div class='alert alert-danger' role='alert'>Erro ao excluir a consulta: " + e.getMessage() + "</div>");
    }
} else {
    out.println("<div class='alert alert-danger' role='alert'>ID inv�lido para exclus�o.</div>");
}
%>
