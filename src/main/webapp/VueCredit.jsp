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
    CreditModel mod = (CreditModel) request.getAttribute("mod");
    List<Simulation> sims = (List<Simulation>) request.getAttribute("sims");

%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.4.1/css/mdb.min.css" rel="stylesheet">
    <link rel="shortcut icon" href="https://mdbootstrap.com/wp-content/themes/mdbootstrap4/favicon.ico">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 0%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            -webkit-animation-name: fadeIn; /* Fade in the background */
            -webkit-animation-duration: 0.4s;
            animation-name: fadeIn;
            animation-duration: 0.4s
        }

        /* Modal Content */
        .modal-content {
            position: fixed;
            bottom: 0;
            width: 30%;
            height: 7%;
            -webkit-animation-name: slideIn;
            -webkit-animation-duration: 0.4s;
            animation-name: slideIn;
            animation-duration: 0.4s;
            margin-bottom: 5vh;
            margin-left: 67vw;
        }

        /* Add Animation */
        @-webkit-keyframes slideIn {
            from {bottom: -300px; opacity: 0}
            to {bottom: 0; opacity: 1}
        }

        @keyframes slideIn {
            from {bottom: -300px; opacity: 0}
            to {bottom: 0; opacity: 1}
        }

        @-webkit-keyframes fadeIn {
            from {opacity: 0}
            to {opacity: 1}
        }

        @keyframes fadeIn {
            from {opacity: 0}
            to {opacity: 1}
        }
    </style>
</head>
<body style="padding: 50px 25vh;" class="bg-light">
<input type="text" class="form-control" id="click" value="<%= String.valueOf(request.getAttribute("cli"))%>" hidden>
<button id="myBtn-delete" hidden>Open Modal</button>
<button id="myBtn-upd" hidden>Open Modal</button>
<button id="myBtn" hidden>Open Modal</button>
<div id="myModal" class="modal">
    <!-- Modal content -->
    <div class="modal-content bg-success">
        <div class="modal-body text-white">
            <span class="close btn-close">&times;</span>
            <h5>The simulation was added successfully !</h5>
        </div>
    </div>

</div>
<div id="myModal-delete" class="modal">
    <!-- Modal content -->
    <div class="modal-content bg-danger">
        <!--div class="modal-header">
            <span class="close btn-close">&times;</span>
        </div-->
        <div class="modal-body text-white">
            <span id="close" class="close btn-close">&times;</span>
            <h5>The simulation was deleted successfully !</h5>
        </div>
    </div>

</div>
<div id="myModal-update" class="modal">
    <!-- Modal content -->
    <div class="modal-content bg-info">
        <!--div class="modal-header">
            <span class="close btn-close">&times;</span>
        </div-->
        <div class="modal-body text-white">
            <span id="close-update" class="close btn-close">&times;</span>
            <h5>The simulation was updated successfully !</h5>
        </div>
    </div>

</div>

<div class="text-center mb-2">
    <h1 style="margin-righ: 40%;"><%= "Simulation" %></h1>
</div>
<div class="card mt-1">
    <div class="card-body">
        <form>
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
        Simultation Form :
    </div>
    <div class="card-body row">
        <div class="col-md-6 border-secondary" style="border-right: solid; border-width: thin;">
            <div class="text-center mb-5">
                <h5  style="margin-righ: 40%;"><%= "Simulation" %></h5>
            </div>
            <form action="calcul.php" method="post">
                <div class="form-group">
                    <label for="LoanAmount">Loan Amount : </label>
                    <input type="text" name="montant" class="form-control" id="loanAmount"
                           aria-describedby="emailHelp" placeholder="Enter loan amount" required value="<%= mod.getMontant()%>">
                </div>
                <div class="form-group">
                    <label for="LoanTerm">Loan Term : </label>
                    <input type="text" name="duree" class="form-control" id="loanTerm" aria-describedby="emailHelp" placeholder="Enter loan term" required value="<%= mod.getDuree()%>">
                </div>
                <div class="form-group">
                    <label for="Interest">Interest Rate :</label>
                    <input type="text" name="taux" class="form-control" id="Interest" aria-describedby="emailHelp"
                           placeholder="Enter interest rate" required value="<%= mod.getTaux()%>">
                </div>
                <div class="form-group">
                    <input type="text" name="id" class="form-control" id="id" required value="<%= session.getAttribute("id")%>" hidden>
                </div>
                <div class="form-group">
                    <input type="text" name="comp" class="form-control" required value="<%= session.getAttribute("comp")%>" hidden>
                </div>



                <button type="submit" id="calcul" class="btn btn-primary">Calcul</button>




            </form>
        </div>
        <div class="col-md-6">
            <div class="text-center mb-5">
                <h5  style="margin-righ: 40%;"><%= "Result" %></h5>
            </div>
            <div class="form-group">
                <label for="monthlyPayment">Monthly Payment :</label>
                <%if(mod != null){%>
                <input type="text" name="monthlyPayment" class="form-control" id="monthlyPayment"
                       aria-describedby="emailHelp" placeholder="--Enter parameters first !" value="<%= mod.getMensualite()%>" disabled>
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

<div class="card mt-5 mb-5">
    <div class="card-header">
        User Simulations :
    </div>
    <div class="card-body row">
        <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for loan amounts..">
            <table class="table" id="myTable">
                <thead>
                <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Loan amount</th>
                    <th scope="col">Loan term</th>
                    <th scope="col">Interest rate</th>
                    <th scope="col">Monthly payment</th>
                    <th scope="col">Date</th>
                    <th scope="col">Operations</th>
                </tr>
                </thead>
                <tbody>
                <% for(Simulation sim: sims) {%>
                    <tr>
                        <th scope="row" id="iden" style="align-content: center;" value="<%String.valueOf(sim.getId());%>"><%= String.valueOf(sim.getId()) %></th>
                        <td id="loan"><%= String.valueOf(sim.getLoan_amount()) %></td>
                        <td><%= String.valueOf(sim.getLoan_term()) %></td>
                        <td><%= String.valueOf(sim.getInterest_rate()) %></td>
                        <td class="mont"><%= String.valueOf(sim.getMonthly_pay()) %></td>
                        <td><%= String.valueOf(sim.getDate()) %></td>
                        <td class="row">
                            <form method="get" action="/demo8_war_exploded/edit" class="mb-0">
                                <input type="text" name="op" class="form-control" id="op" required value="edit" hidden>
                                <input type="text" name="id_ed" class="form-control" id="id_ed" required value="<%=sim.getId()%>" hidden>
                                <button type="submit" class="btn btn-info">Edit</button>
                            </form>
                            <button type="button" id="delete" class="btn btn-danger" value="<%=sim.getId()%>">Delete</button>
                            <!--input type="button" id="delete" class="btn btn-danger" value="<%=sim.getId()%>" -->
                        </td>
                    </tr>
                <%}%>
                </tbody>
            </table>
    </div>
</div>




</body>
<script>
    $(document).ready(function (){
        console.log($('#click').val());
        if($('#click').val() == "click"){
            $('#myBtn').click();
        }else if($('#click').val() == "upd"){
            $('#myBtn-upd').click();
        }
        console.log('started');
        $('.btn-danger').on('click', function (){
            var iden = $(this).closest('tr').find('th').text();
            $(this).closest('tr').remove();
            $.ajax({
                url:'/demo8_war_exploded/delete',
                data:{op: 'delete', id: iden},
                type: 'GET',
                success: function (data, textStatus, jqXHR) {
                    console.log('item deleted successfully !');
                    $('#myBtn-delete').click();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log('an error has occured while deleting !!')
                }
            });




            /**
            var montant = $(this).closest('tr').find('td').eq(0).text();
            var duree = $(this).closest('tr').find('td').eq(2).text();
            var interest = $(this).closest('tr').find('td').eq(3).text();

            console.log(id);
            console.log(montant);
            console.log(duree);
            console.log(interest);
            */
        });
        $('#myModal').on('shown.bs.modal', function () {
            $('#myInput').trigger('focus')
        })
    });
</script>
<script>
    // Get the modal
    var modal = document.getElementById("myModal");

    // Get the button that opens the modal
    var btn = document.getElementById("myBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks the button, open the modal
    btn.onclick = function() {
        modal.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
<script>
    // Get the modal
    var modal_delete = document.getElementById("myModal-delete");

    // Get the button that opens the modal
    var btn_delete = document.getElementById("myBtn-delete");

    // Get the <span> element that closes the modal
    var span_delete = document.getElementById("close");

    // When the user clicks the button, open the modal
    btn_delete.onclick = function() {
        modal_delete.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    span_delete.onclick = function() {
        modal_delete.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal_delete) {
            modal_delete.style.display = "none";
        }
    }
</script>
<script>
    // Get the modal
    var modal_update = document.getElementById("myModal-update");

    // Get the button that opens the modal
    var btn_update = document.getElementById("myBtn-upd");

    // Get the <span> element that closes the modal
    var span_update = document.getElementById("close-update");

    // When the user clicks the button, open the modal
    btn_update.onclick = function() {
        modal_update.style.display = "block";
    }

    // When the user clicks on <span> (x), close the modal
    span_update.onclick = function() {
        modal_update.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal_delete) {
            modal_update.style.display = "none";
        }
    }
</script>
<script>
    function myFunction() {
        // Declare variables
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByClassName("mont")[0];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>
</html>
