package com.crudjspjava.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Time;
import java.sql.Date;
import com.crudjspjava.bean.Consulta;

public class ConsultaDao {
    
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cliente_db", "root", "");
        } catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }
    
    public static int salvarConsulta(Consulta c) {
        int status = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO consulta (nome, exame, hora, data, concluido, diagnostico) VALUES (?,?,?,?,?,?)");
            ps.setString(1, c.getNome());
            ps.setString(2, c.getExame());
            ps.setTime(3, Time.valueOf(c.getHora()));
            ps.setDate(4, Date.valueOf(c.getData()));
            ps.setBoolean(5, c.isConcluido());
            ps.setString(6, c.getDiagnostico()); // Adicionar diagnóstico
            status = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static int atualizarConsulta(Consulta c) {
        int status = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE consulta SET nome=?, exame=?, hora=?, data=?, concluido=?, diagnostico=? WHERE id=?");
            ps.setString(1, c.getNome());
            ps.setString(2, c.getExame());
            ps.setTime(3, Time.valueOf(c.getHora()));
            ps.setDate(4, Date.valueOf(c.getData()));
            ps.setBoolean(5, c.isConcluido());
            ps.setString(6, c.getDiagnostico()); // Define o diagnóstico
            ps.setInt(7, c.getId());
            status = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    public static Consulta getConsultaById(int id) {
        Consulta consulta = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM consulta WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                consulta = new Consulta();
                consulta.setId(rs.getInt("id"));
                consulta.setNome(rs.getString("nome"));
                consulta.setExame(rs.getString("exame"));
                consulta.setHora(rs.getTime("hora").toLocalTime());
                consulta.setData(rs.getDate("data").toLocalDate());
                consulta.setConcluido(rs.getBoolean("concluido"));
                consulta.setDiagnostico(rs.getString("diagnostico")); // Adicione esta linha para incluir o diagnóstico
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return consulta;
    }

    public static List<Consulta> getAllConsultas() {
        List<Consulta> list = new ArrayList<>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM consulta");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Consulta consulta = new Consulta();
                consulta.setId(rs.getInt("id"));
                consulta.setNome(rs.getString("nome"));
                consulta.setExame(rs.getString("exame"));
                consulta.setHora(rs.getTime("hora").toLocalTime());
                consulta.setData(rs.getDate("data").toLocalDate());
                consulta.setConcluido(rs.getBoolean("concluido"));
                consulta.setDiagnostico(rs.getString("diagnostico")); // Adicionar diagnóstico
                list.add(consulta);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public static Consulta getConsultaByNome(String nome) {
        Consulta consulta = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM consulta WHERE nome = ?");
            ps.setString(1, nome);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                consulta = new Consulta();
                consulta.setId(rs.getInt("id"));
                consulta.setNome(rs.getString("nome"));
                consulta.setExame(rs.getString("exame"));
                consulta.setHora(rs.getTime("hora").toLocalTime());
                consulta.setData(rs.getDate("data").toLocalDate());
                consulta.setConcluido(rs.getBoolean("concluido"));
                consulta.setDiagnostico(rs.getString("diagnostico")); // Adicionar diagnóstico
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return consulta;
    }
}
