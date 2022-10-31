package model;

import java.util.Date;

public class Simulation {
    private int id;
    private double loan_amount;
    private int loan_term;
    private double interest_rate;
    private double monthly_pay;
    private Date date;
    private int user;

    public Simulation(int id, double loan_amount, int loan_term, double interest_rate, double monthly_pay, Date date, int user) {
        this.id = id;
        this.loan_amount = loan_amount;
        this.loan_term = loan_term;
        this.interest_rate = interest_rate;
        this.monthly_pay = monthly_pay;
        this.date = date;
        this.user = user;
    }

    @Override
    public String toString() {
        return "Simulation{" +
                "id=" + id +
                ", loan_amount=" + loan_amount +
                ", loan_term=" + loan_term +
                ", interest_rate=" + interest_rate +
                ", monthly_pay=" + monthly_pay +
                ", date=" + date +
                ", user=" + user +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Simulation() {
    }

    public double getLoan_amount() {
        return loan_amount;
    }

    public void setLoan_amount(double loan_amount) {
        this.loan_amount = loan_amount;
    }

    public int getLoan_term() {
        return loan_term;
    }

    public void setLoan_term(int loan_term) {
        this.loan_term = loan_term;
    }

    public double getInterest_rate() {
        return interest_rate;
    }

    public void setInterest_rate(double interest_rate) {
        this.interest_rate = interest_rate;
    }

    public double getMonthly_pay() {
        return monthly_pay;
    }

    public void setMonthly_pay(double monthly_pay) {
        this.monthly_pay = monthly_pay;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getUser() {
        return user;
    }

    public void setUser(int user) {
        this.user = user;
    }
}
