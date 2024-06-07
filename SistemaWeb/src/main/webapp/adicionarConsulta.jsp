<%@ page import="com.crudjspjava.bean.Consulta" %>
<%@ page import="com.crudjspjava.dao.ConsultaDao" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.LocalDate" %>

<%
String nome = request.getParameter("nome");
String exame = request.getParameter("exame");
String horaStr = request.getParameter("hora");
String dataStr = request.getParameter("data");

if (horaStr != null && !horaStr.isEmpty() && dataStr != null && !dataStr.isEmpty()) {
    try {
        LocalTime hora = LocalTime.parse(horaStr);
        LocalDate data = LocalDate.parse(dataStr);

        Consulta consulta = new Consulta();
        consulta.setNome(nome);
        consulta.setExame(exame);
        consulta.setHora(hora);
        consulta.setData(data);

        int status = ConsultaDao.salvarConsulta(consulta);

        if (status > 0) {
            response.sendRedirect("viewconsulta.jsp?nome=" + nome);
        } else {
            response.sendRedirect("viewconsulta.jsp?mensagem=Erro%20ao%20agendar%20consulta");
        }
    } catch (Exception e) {
        response.sendRedirect("adicionarConsulta.jsp?mensagem=Formato%20de%20hora%20ou%20data%20inválido");
    }
} else {
    response.sendRedirect("viewconsulta.jsp?mensagem=Preencha%20todos%20os%20campos%20corretamente");
}
%>