<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="config.jsp"%>
<%@include file="menu.jsp"%>


  <style>
  
  /* 
  Max width before this PARTICULAR table gets nasty
  This query will take effect for any screen smaller than 760px
  and also iPads specifically.
  */
  @media 
  only screen and (max-width: 760px),
  (min-device-width: 768px) and (max-device-width: 1004px)  {
  
    /* Force table to not be like tables anymore */
    table, thead, tbody, th, td, tr { 
      display: block; 
    }
    
    /* Hide table headers (but not display: none;, for accessibility) */
    thead tr { 
      position: absolute;
      top: -9999px;
      left: -9999px;
     
    }
    
    tr { border: 1px solid #ccc; }
    
    td { 
      /* Behave  like a "row" */
      border: none;
      border-bottom: 1px solid #eee; 
      position: relative;
      padding-left: 50% !important;
    }
    
    td:before { 
      /* Now like a table header */
      position: absolute;
      /* Top/left values mimic padding */
      top: 6px;
      left: 6px;
      width: 45%; 
      padding-right: 10px; 
      white-space: nowrap;      
    }
    
    /*
    Label the data
    */
    td:nth-of-type(1):before { content: "Loja:"; }
    td:nth-of-type(2):before { content: "Saldo:"; }    
    td:nth-of-type(3):before { content: "Código:"; }
    td:nth-of-type(4):before { content: "Código de barras:"; }
    td:nth-of-type(5):before { content: "Nome Produto:"; }
    td:nth-of-type(6):before { content: "Autor:"; }
    td:nth-of-type(7):before { content: "Editora:"; }
    td:nth-of-type(8):before { content: "Preço:"; }
    
  }
  
  /* Smartphones (portrait and landscape) ----------- */
  @media only screen
  and (min-device-width : 320px)
  and (max-device-width : 480px) {
    body { 
      padding: 0; 
      margin: 0; 
      width: 320px; }
    }
  
  /* iPads (portrait and landscape) ----------- */
  @media only screen and (min-device-width: 768px) and (max-device-width: 1024px){
    body { 
      width: 100%; 
    }
  }
  

  </style>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<%@include file="perfil.jsp"%>
  <!-- Main Header ficava aqui o que estava¡ no arquivo perfil-->

  <!-- Left side column. contains the logo and sidebar ficaria aqui o menu, mas retirei-->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <ol class="breadcrumb">
        <li><a href="index.jsp"><i class="fa fa-dashboard"></i>Nível</a></li>
        <li class="active">Estoque</li>
      </ol>
    </section>
<br>
    <!-- Main content -->
    <section class="content">
      <div class="container logo text-center col-sm-12">
        <img src="assets/imagens/logo.png" alt="logo Escariz" />
      </div>
<br>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">      
      <a href="mailto:ti@escariz.com.br" target="_parent">Suporte</a>
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2021 <a href="index.jsp">Escariz</a>.</strong> All rights reserved.
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.0 -->
<script src="plugins/jQuery/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap2/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

<script>
//para exibir botÃƒÂ£o de voltar para o topo            
jQuery(document).ready(function() {
            // Exibe ou oculta o botÃƒÂ£o
            jQuery(window).scroll(function() {
                if (jQuery(this).scrollTop() > 300) {
                    jQuery('.image-switch').fadeIn(300);
                } else {
                    jQuery('.image-switch').fadeOut(200);
                }
            });
            
            // Faz animaÃƒÂ§ÃƒÂ£o para subir
            jQuery('.image-switch').click(function(event) {
                event.preventDefault();
                jQuery('html, body').animate({scrollTop: 0}, 300);
            })
        });

</script> 

</body>
</html>