package web;

import metier.CreditMetier;
import metier.SimulationMetier;
import model.Simulation;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;
import java.util.List;

@WebServlet(name = "auth", urlPatterns = {"/auth", "/edit", "/update", "/delete"})
public class AuthController extends HttpServlet {
    SimulationMetier sm;
    CreditMetier metier;

    @Override
    public void init() throws ServletException {
        super.init();
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
        System.out.println("we have reached here !");
        String op = String.valueOf(req.getParameter("op"));
        System.out.println(op+" is the op");


        if(op.equals("delete")){
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                sm.delete(id);
                System.out.println("item deleted successfully");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        if (op.equals("edit")) {
            System.out.println("in edit if");
            Simulation sim;
            int id_ed = Integer.parseInt(req.getParameter("id_ed"));
            try {
                sim = sm.findById(id_ed);
                req.setAttribute("sim", sim);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.getRequestDispatcher("edit.jsp").forward(req, resp);
        }
        if (op.equals("update")) {
            metier = new CreditMetier();
            System.out.println("in the update func");
            Simulation sim;
            Simulation sim_tomp = new Simulation();
            double montant = Double.parseDouble(req.getParameter("montant"));
            double taux = Double.parseDouble(req.getParameter("taux"));
            int duree = Integer.parseInt(req.getParameter("duree"));
            int id = Integer.parseInt(req.getParameter("id"));
            int id_user = Integer.parseInt(req.getParameter("id_user"));

            sim_tomp.setLoan_amount(montant);
            sim_tomp.setLoan_term(duree);
            sim_tomp.setInterest_rate(taux);


            double res = metier.calculeMensualite(montant, duree, taux);

            sim_tomp.setMonthly_pay(res);

            try {
                sm.update(id, sim_tomp);
                System.out.println("updated !!!!");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.setAttribute("id_user", id_user);
            req.getRequestDispatcher("/main.php").forward(req, resp);
        }
        //req.getRequestDispatcher("VueCredit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String email = req.getParameter("email");
        String password = req.getParameter("password");
        List<Simulation> list;
        int id;

        Connexion con;


        try {
            con = new Connexion();
            Connection connection = con.getConnexion();

            System.out.println("connection succeded");


            PreparedStatement ps = connection.prepareStatement("Select * FROM PERSON WHERE email = ?");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            rs.next();
            HttpSession session = req.getSession();
            if (password.equals(rs.getString("password"))) {


                session.setAttribute("status", "ok");

                session.setAttribute("id", rs.getInt("id"));
                session.setAttribute("nom", rs.getString("nom"));
                session.setAttribute("age", rs.getInt("age"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("password", rs.getString("password"));
                session.setAttribute("gender", rs.getString("genre"));
                session.setAttribute("comp", rs.getInt("compteur"));
                session.setAttribute("date", rs.getDate("date"));

            } else {

                session.setAttribute("status", "rejected");

            }

            System.out.println(session.getAttribute("status"));

            System.out.println(rs.getString("nom"));
            System.out.println(password);
            System.out.println(rs.getString("password"));

            req.setAttribute("id", rs.getInt("id"));



            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


        try {
            list = sm.findAll(Integer.parseInt(req.getAttribute("id").toString()));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        req.setAttribute("sims", list);
        req.setAttribute("mod", new CreditModel());
        req.setAttribute("log", "login");
        req.getRequestDispatcher("VueCredit.jsp").forward(req, resp);
    }

}

