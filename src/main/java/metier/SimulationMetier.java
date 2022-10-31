package metier;

import DAO.IDao;
import model.Simulation;
import web.Connexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SimulationMetier implements IDao {
    Connexion con;
    Connection connection;
    public SimulationMetier() throws SQLException, ClassNotFoundException {
        con = new Connexion();
        connection = con.getConnexion();
    }

    @Override
    public void create(Simulation simulation) throws SQLException {
        PreparedStatement ps = connection.prepareStatement("INSERT INTO SIMULATION (loan_amount, loan_term, interest_rate, monthly_pay, date, user) VALUES (?,?,?,?,?,?)");

        ps.setDouble(1, simulation.getLoan_amount());
        ps.setInt(2, simulation.getLoan_term());
        ps.setDouble(3, simulation.getInterest_rate());
        ps.setDouble(4, simulation.getMonthly_pay());
        ps.setDate(5, Date.valueOf(java.time.LocalDate.now()));
        ps.setInt(6, simulation.getUser());

        ps.execute();
        ps.close();
    }

    @Override
    public void update(int id, Simulation sim) throws SQLException {
        PreparedStatement ps = connection.prepareStatement("UPDATE SIMULATION SET loan_amount = ? , loan_term = ? , interest_rate = ? , monthly_pay = ? WHERE id = ?");

        ps.setDouble(1, sim.getLoan_amount());
        ps.setInt(2, sim.getLoan_term());
        ps.setDouble(3, sim.getInterest_rate());
        ps.setDouble(4, sim.getMonthly_pay());
        ps.setInt(5, id);

        ps.execute();

        ps.close();
    }

    @Override
    public void delete(int id) throws SQLException {
        PreparedStatement ps = connection.prepareStatement("DELETE FROM SIMULATION WHERE id = ?");
        ps.setInt(1, id);
        ps.execute();

        ps.close();
    }

    @Override
    public Simulation findById(int id) throws SQLException {
        Simulation sim = new Simulation();

        PreparedStatement ps = connection.prepareStatement("SELECT * FROM SIMULATION WHERE id = ?");
        ps.setInt(1, id);
        ResultSet rs= ps.executeQuery();
        rs.next();
        
        sim.setId(rs.getInt("id"));
        sim.setLoan_amount(rs.getDouble("loan_amount"));
        sim.setLoan_term(rs.getInt("loan_term"));
        sim.setInterest_rate(rs.getDouble("interest_rate"));
        sim.setMonthly_pay(rs.getDouble("monthly_pay"));
        sim.setDate(rs.getDate("date"));
        sim.setUser(rs.getInt("user"));
        return sim;
    }

    @Override
    public ArrayList<Simulation> findAll(int id) throws SQLException {
        ArrayList<Simulation> list = new ArrayList<Simulation>();
        Simulation sim;

        PreparedStatement ps = connection.prepareStatement("SELECT * FROM SIMULATION WHERE user = ?");
        ps.setInt(1, id);
        ResultSet rs= ps.executeQuery();

        while (rs.next()){
            sim = new Simulation();
            sim.setId(rs.getInt("id"));
            sim.setLoan_amount(rs.getDouble("loan_amount"));
            sim.setLoan_term(rs.getInt("loan_term"));
            sim.setInterest_rate(rs.getDouble("interest_rate"));
            sim.setMonthly_pay(rs.getDouble("monthly_pay"));
            sim.setDate(rs.getDate("date"));
            sim.setUser(rs.getInt("user"));
            list.add(sim);
            System.out.println(sim.toString()+"in service");
        }

        System.out.println(list.toString()+" in service");

        return list;
    }
}
