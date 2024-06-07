package com.crudjspjava.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crudjspjava.bean.Consulta;
import com.crudjspjava.dao.ConsultaDao;

@WebServlet("/editarconsulta")
public class EditarConsultaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Receber parâmetros do formulário
        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String exame = request.getParameter("exame");
        LocalTime hora = LocalTime.parse(request.getParameter("hora"));
        LocalDate data = LocalDate.parse(request.getParameter("data"));
        boolean concluido = request.getParameter("concluido") != null;
        String diagnostico = request.getParameter("diagnostico");
        
        // Criar objeto Consulta com os dados recebidos
        Consulta consulta = new Consulta();
        consulta.setId(id);
        consulta.setNome(nome);
        consulta.setExame(exame);
        consulta.setHora(hora);
        consulta.setData(data);
        consulta.setConcluido(concluido);
        consulta.setDiagnostico(diagnostico);
        
        // Atualizar consulta no banco de dados
        int status = ConsultaDao.atualizarConsulta(consulta);
        
        // Redirecionar após a edição
        if (status > 0) {
            response.sendRedirect("viewMedico.jsp"); // Página para exibir todas as consultas ou uma mensagem de sucesso
        } else {
            response.sendRedirect("editconsulta.jsp?id=" + id); // Redirecionar de volta ao formulário de edição em caso de erro
        }
    }
}

