<%@ page import="java.util.ArrayList, java.util.Collections, java.util.Comparator" %>
<%@ page import="com.crudjspjava.dao.ConsultaDao, com.crudjspjava.bean.Consulta, java.util.List, java.util.Map, java.util.HashMap, java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="ISO-8859-1">
    <title>Consulta de Agendamentos</title>
    <link rel="stylesheet" href="styleViewMedico.css"> <!-- Ajuste o caminho para seu arquivo CSS -->
</head>
<body>
    <div class="container">
        <h1>SevenMed.ltda</h1>
        <h1>Portal do Médico</h1>
        
        <%
        List<Consulta> list = ConsultaDao.getAllConsultas();
        request.setAttribute("list", list);
        
        Map<java.sql.Date, Integer> consultasConcluidasPorDia = new HashMap<>();
        for (Consulta consulta : list) {
            LocalDate localDate = consulta.getData();
            java.sql.Date data = java.sql.Date.valueOf(localDate);
            int totalConsultas = consultasConcluidasPorDia.getOrDefault(data, 0);
            if (consulta.isConcluido()) {
                totalConsultas++;
            }
            consultasConcluidasPorDia.put(data, totalConsultas);
        }
        
        // Converter o mapa em uma lista de pares chave-valor
        List<Map.Entry<java.sql.Date, Integer>> entryList = new ArrayList<>(consultasConcluidasPorDia.entrySet());
        
        // Ordenar a lista com base nas datas
        Collections.sort(entryList, new Comparator<Map.Entry<java.sql.Date, Integer>>() {
            public int compare(Map.Entry<java.sql.Date, Integer> o1, Map.Entry<java.sql.Date, Integer> o2) {
                return o1.getKey().compareTo(o2.getKey());
            }
        });
        
        request.setAttribute("consultasConcluidasPorDia", entryList);
        %>
        
        <h2>Total de Consultas Concluídas por Dia</h2>
        <table>
            <thead>
                <tr>
                    <th>Data</th>
                    <th>Total Concluídas</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${consultasConcluidasPorDia}" var="entry"> 
                    <tr>
                        <td>${entry.key}</td>
                        <td>${entry.value}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <h2>Lista de Consultas</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>    
                    <th>Nome</th>
                    <th>Exame</th>
                    <th>Hora</th>
                    <th>Data</th>
                    <th>Concluído</th>
                    <th>Diagnóstico</th> <!-- Adicionando a coluna de diagnóstico -->
                    <th>Editar</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="consulta"> 
                    <tr>
                        <td>${consulta.getId()}</td>
                        <td>${consulta.getNome()}</td>
                        <td>${consulta.getExame()}</td>
                        <td>${consulta.getHora()}</td>
                        <td>${consulta.getData()}</td>
                        <td>${consulta.isConcluido() ? "Sim" : "Não"}</td>
                        <td>${consulta.getDiagnostico()}</td> <!-- Exibindo o diagnóstico -->
                        <td><a href="editconsulta.jsp?id=${consulta.getId()}" class="edit-btn">Editar</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
