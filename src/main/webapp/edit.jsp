<%@ page import="web.CreditModel" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Simulation" %><%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 24/10/2022
  Time: 22:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Simulation sim = (Simulation) request.getAttribute("sim");

%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.4.1/css/mdb.min.css" rel="stylesheet">
    <link rel="shortcut icon" href="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/favicon.ico">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body style="padding: 50px 25vh;" class="bg-light">

<div class="text-center mb-2">
    <h1 style="margin-righ: 40%;"><%= "Simulation" %></h1>
</div>
<div class="card mt-1">
    <div class="card-body">
        <form action="/demo8_war_exploded/update" method="get">
            <div class="form-group">
                <label for="exampleInputName">Name</label>
                <input type="text" class="form-control" id="exampleInputName" aria-describedby="emailHelp" value="<%= session.getAttribute("nom")%>" disabled>
            </div>
            <div class="form-group">
                <label for="exampleInputAge">Age</label>
                <input type="text" class="form-control" id="exampleInputAge" aria-describedby="emailHelp" value="<%= session.getAttribute("age")%>" disabled>
            </div>
            <div class="form-group">
                <label for="email">Email address</label>
                <input type="email" id="email" class="form-control" aria-describedby="emailHelp" value="<%= session.getAttribute("email")%>" disabled>
            </div>
            <div class="form-group">
                <label for="email">Gender </label>
                <input type="text" id="gender" class="form-control" value="<%= session.getAttribute("gender")%>" disabled>
            </div>
            <div class="form-group">
                <label for="exampleInputDate">Date de naissence :</label>
                <input type="date" class="form-control" id="exampleInputDate" value="<%= session.getAttribute("date")%>" disabled>
            </div>

        </form>
    </div>
</div>
<div class="card mt-5 mb-5">
    <div class="card-header">
        Update Simultation Form :
    </div>
    <div class="card-body row">
        <div class="col-md-6 border-secondary" style="border-right: solid; border-width: thin;">
            <div class="text-center mb-5">
                <h5  style="margin-righ: 40%;"><%= "Simulation" %></h5>
            </div>
            <form action="/demo8_war_exploded/update" method="get">
                <div class="form-group">
                    <label for="LoanAmount">Loan Amount : </label>
                    <input type="text" name="montant" class="form-control" id="loanAmount"
                           aria-describedby="emailHelp" placeholder="Enter loan amount" required value="<%= sim.getLoan_amount()%>">
                </div>
                <div class="form-group">
                    <label for="LoanTerm">Loan Term : </label>
                    <input type="text" name="duree" class="form-control" id="loanTerm" aria-describedby="emailHelp" placeholder="Enter loan term" required value="<%= sim.getLoan_term()%>">
                </div>
                <div class="form-group">
                    <label for="Interest">Interest Rate :</label>
                    <input type="text" name="taux" class="form-control" id="Interest" aria-describedby="emailHelp"
                           placeholder="Enter interest rate" required value="<%= sim.getInterest_rate()%>">
                </div>
                <div class="form-group">
                    <input type="text" name="id" class="form-control" id="id" required value="<%= sim.getId()%>" hidden>
                </div>
                <div class="form-group">
                    <input type="text" name="comp" class="form-control" required value="<%= session.getAttribute("comp")%>" hidden>
                </div>
                <input type="text" name="op" class="form-control" required value="update" hidden>

                <input type="text" name="id_user" class="form-control" id="id_user" required value="<%= session.getAttribute("id")%>" hidden>
                <button type="submit" id="calcul" class="btn btn-info">Update</button>




            </form>
        </div>
        <div class="col-md-6">
            <div class="text-center mb-5">
                <h5  style="margin-righ: 40%;"><%= "Result" %></h5>
            </div>
            <div class="form-group">
                <label for="monthlyPayment">Monthly Payment :</label>
                <%if(sim != null){%>
                <input type="text" name="monthlyPayment" class="form-control" id="monthlyPayment"
                       aria-describedby="emailHelp" placeholder="--Enter parameters first !" value="<%= sim.getMonthly_pay()%>" disabled>
                <%}else {%>
                <input type="text" name="monthlyPayment" class="form-control" id="monthlyPayment"
                       aria-describedby="emailHelp" placeholder="--Enter parameters first !">
                <%}%>
            </div>
            <div class="form-group">
                <label for="comp">Compteur utilisateur :</label>
                <input type="text" name="comp" class="form-control" id="comp" required value="<%= session.getAttribute("comp")%>" disabled>
            </div>

        </div>
    </div>
</div>







</body>

</html>
