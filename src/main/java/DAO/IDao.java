package DAO;


import model.Simulation;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public interface IDao {
    public void create(Simulation simulation) throws SQLException;
    public void update(int id, Simulation sim) throws SQLException;
    public void delete(int id) throws SQLException;
    public Simulation findById(int id) throws SQLException;
    public ArrayList<Simulation> findAll(int id) throws SQLException;
}
