package web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {
    private static Connection connexion;

    public Connexion() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        this.connexion =  DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_lab4", "root", "");
    }

    public static Connection getConnexion() throws SQLException, ClassNotFoundException {
        if(connexion == null){
            new Connexion();
        }
        return connexion;
    }
}
