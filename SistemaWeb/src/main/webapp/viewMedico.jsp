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
    <style>
        .container {
            width: 100%; /* Aumentando a largura */
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 20px 0px rgba(0,0,0,0.1);
        }
        .text-center {
            text-align: center;
            margin-top: 30px; /* Adicionando margem superior */
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            color: #fff;
            background-color: #dc3545;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #c82333;
        }
    </style>
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
                    <th>Excluir</th> <!-- Adicionando a coluna de excluir -->
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
                        <td>
                            <form action="deleteconsulta.jsp" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${consulta.getId()}" />
                                <button type="submit" class="delete-btn">Excluir</button>
                            </form>
                        </td> <!-- Adicionando o botão de excluir -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="text-center">
            <a href="viewcliente.html" class="btn">Voltar para Home</a>
        </div>
    </div>
</body>
</html>

