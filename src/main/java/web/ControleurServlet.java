package web;

import metier.CreditMetier;
import metier.SimulationMetier;
import model.Simulation;

import java.io.*;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "cs", urlPatterns = {"/login", "*.php", "*.do"})
public class ControleurServlet extends HttpServlet {
    SimulationMetier sm;
    CreditMetier metier;
    @Override
    public void init() throws ServletException {
        metier = new CreditMetier();
        try {
            sm = new SimulationMetier();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In the main of Controler servlet");
        this.doFunction(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        double montant = Double.parseDouble(req.getParameter("montant"));
        double taux = Double.parseDouble(req.getParameter("taux"));
        int duree = Integer.parseInt(req.getParameter("duree"));
        int id = Integer.parseInt(req.getParameter("id"));
        int comp = Integer.parseInt(req.getParameter("comp"));

        CreditModel model = new CreditModel();
        model.setMontant(montant);
        model.setTaux(taux);
        model.setDuree(duree);

        double res = metier.calculeMensualite(montant, duree, taux);

        model.setMensualite(res);

        req.setAttribute("mod", model);

        HttpSession session = req.getSession();

        Connection connection;

        List<Simulation> list;


        try {
            Connexion con = new Connexion();
            connection = con.getConnexion();

            System.out.println("connection succeded");


            PreparedStatement ps = connection.prepareStatement("INSERT INTO SIMULATION (loan_amount, loan_term, interest_rate, monthly_pay, date, user) VALUES (?,?,?,?,?,?)");
            PreparedStatement ps2 = connection.prepareStatement("UPDATE PERSON SET compteur = ? WHERE id = ?");


            ps.setDouble(1, montant);
            ps.setInt(2, duree);
            ps.setDouble(3, taux);
            ps.setDouble(4, res);
            ps.setDate(5, Date.valueOf(java.time.LocalDate.now()));
            ps.setInt(6, id);

            ps2.setInt(1, ++comp);
            ps2.setInt(2, id);



            ps.execute();
            ps2.execute();

            System.out.println(Date.valueOf(java.time.LocalDate.now()));
            System.out.println("insert succeded");

            ps.close();

            session.setAttribute("comp", comp);


        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            list = sm.findAll(id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String click = "click";

        req.setAttribute("cli", click);
        req.setAttribute("sims", list);
        req.getRequestDispatcher("VueCredit.jsp").forward(req, resp);

    }

    protected void doFunction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id_user"));
        System.out.println(id+" is the id of the user");

        Connection connection;

        List<Simulation> list;

        try {
            list = sm.findAll(id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String click = "upd";

        req.setAttribute("cli", click);
        req.setAttribute("mod", new CreditModel());
        req.setAttribute("sims", list);
        req.getRequestDispatcher("VueCredit.jsp").forward(req, resp);
    }

}
