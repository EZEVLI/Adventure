<%-- 
    Document   : Search
    Created on : Mar 10, 2021, 7:14:29 PM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Το προφίλ μου</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <!-- Google Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
        <!-- Bootstrap core CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Material Design Bootstrap -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
        <!-- JQuery -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- Bootstrap tooltips -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
        <!-- Bootstrap core JavaScript -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <!-- MDB core JavaScript -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
              integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
              crossorigin=""/>
        <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
                integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
                crossorigin=""
        ></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="http://localhost:8080/Adventure/css/company_index.css" rel="stylesheet" type="text/css">
        <link href="http://localhost:8080/Adventure/css/footer.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="container-fluid">   
            <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
                <div class="container-fluid">
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <ul class="navbar-nav me-auto mb-2 mb-md-0">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="http://localhost:8080/Adventure">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/event/search">Δράστηριοτητες</a>
                            </li>
                            <security:authorize access="hasAuthority('CUSTOMER')">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/event/register">Κράτηση</a>
                                </li>
                            </security:authorize>
                            <security:authorize access="hasAuthority('COMPANY')">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/event/create">Καταχωρήση</a>
                                </li>
                            </security:authorize>
                            <li class="nav-item">
                                <a class="nav-link" href="http:/localhost:8080/Adventure/#aboutus">Σχετικά με εμάς</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#footer">Πληροφορίες</a>
                            </li>
                        </ul>
                    </div>
                    <div id="loginregister">
                        <c:if test="${loggedInUser == null}">
                            <a class="nav-link"  href="http://localhost:8080/Adventure/loginPage">Σύνδεση</a>
                            <a class="nav-link" href="http://localhost:8080/Adventure/register">Εγγραφή</a>
                        </c:if>
                        <c:if test="${loggedInUser != null}">
                            <security:authorize access="hasAuthority('CUSTOMER')">
                                <a class="nav-link"  href="http://localhost:8080/Adventure/customer">Το προφίλ μου</a>
                            </security:authorize>
                            <security:authorize access="hasAuthority('COMPANY')">
                                <a class="nav-link"  href="http://localhost:8080/Adventure/company">Το προφίλ μου</a>
                            </security:authorize>
                            <form:form class="d-flex" action="${pageContext.request.contextPath}/logout" method="POST">
                                <input type="submit" value="Logout" class="form-control me-2">
                            </form:form>
                        </c:if>
                    </div>
                </div>
            </nav>
        </div>
    <div class="container">
        <main>
            <h1 class="font-weight-bold py-3">Adventure Booking</h1>
            <h3>Το προφίλ μου</h3>
            <p>Ονόμα εταιρία: ${loggedInUser.company.name}</p>
            <p>Διευθυνση εταιρίας: ${loggedInUser.company.address}</p>
            <div hidden id="companyid">${loggedInUser.company.id}</div>

            <h3 id="number"></h3>

            <div class="row row-cols-1 row-cols-md-4 g-4">
                <c:forEach items="${companysEvents}" var = "event">
                    <div class="col">
                        <div class="card h-100">
                            <img
                                src="${pageContext.request.contextPath}/img/${event.categoryId.imgurl}"
                                class="card-img-top"
                                alt="${event.categoryId.categoryName}"
                                style="height: 200px"
                                />
                            <div class="card-body card-main">
                                <h5 class="card-title">${event.name}</h5>
                                <p class="card-text">${event.description}</p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">Cras justo odio</li>
                                <li class="list-group-item">Dapibus ac facilisis in</li>
                                <li class="list-group-item">Vestibulum at eros</li>
                            </ul>
                            <div class="card-body">
                                <a href="${pageContext.request.contextPath}/event/update/${event.id}" class="btn btn-primary btn-md">Επεξεργασία</a>
                                <a href="${pageContext.request.contextPath}/event/delete?id=${event.id}" class="btn btn-primary btn-md">Ακύρωση</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="col-sm" id="map">
            </div>
        </main>
    </div>
                    <footer class="footer" id="footer">
            <div class="inner_footer">
                <div class="logo_container">

                </div>

                <div class="footer_third">
                    <h1>Χρειάζεστε βοήθεια;</h1>
                    <a href="#">Όροι &amp; Προϋποθέσεις</a>
                    <a href="#">Πολιτική απορρήτου</a>
                    <a href="${pageContext.request.contextPath}/chat">Online Βοήθεια</a>
                </div>
                <div class="footer_third">
                    <h1>Περισσότερα</h1>
                    <a href="#">Φυλλάδια</a>
                    <a href="#">Δωρεά</a>
                    <a href="#">Διακυβέρνηση</a>
                    <a href="#">Αναφορές αντικτύπου</a>
                </div>
                <div class="footer_third">
                    <h1>Ακολουθησέ μας</h1>
                    <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                    <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                    <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                    <li><a href="#"><i class="fa fa-youtube"></i></a></li>
                    <li><a href="#"><i class="fa fa-pinterest"></i></a></li>
                    <li><a href="#"><i class="fa fa-google-plus-official"></i></a></li>

                    <span>
                        © 2021 Adventure Booking<br>
                        Greece, Athens<br>
                        77 Ermou Street 18537<br>
                        Monday - Saturday 09:00 - 18:00<br>
                        2106000018, 6983333347<br>
                        adventurebookinggroupproject@gmail.com
                    </span>
                </div>
                <div class="map">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d12580.106256748013!2d23.718013433025146!3d37.97650937556948!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14a1bd2327d1bb15%3A0xa3501c4310ecdfb8!2zzpXPgc68zr_PjSA3NywgzpHOuM6uzr3OsSAxMDUgNTU!5e0!3m2!1sel!2sgr!4v1609183451261!5m2!1sel!2sgr"
                        width="300" height="300" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false"
                        tabindex="0"></iframe>
                </div>
            </div>
        </footer>
    <script src="js/company_index.js"></script>
</body>
</html>
