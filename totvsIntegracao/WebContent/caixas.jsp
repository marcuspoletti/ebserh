<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>
<%@include file="perfil.jsp"%>

<%@ page import="model.VendasLojas" %>
<%@ page import="utilitario.Utilitaria" %>
<%@ page import="utilitario.ConverteDate" %>
<%@ page import="persistence.VendasDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="iniConexao.jsp"%>
<head>
<meta http-equiv="refresh" content="300">
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<%@include file="perfil.jsp"%>
  <!-- Main Header ficava aqui o que estÃƒÂ¡ no arquivo perfil-->
  
  <!-- Left side column. contains the logo and sidebar ficaria aqui o menu, mas retirei-->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Nível</a></li>
        <li class="active">Movimentação Caixa</li>
      </ol>
    </section>
<br>
<br>
    <!-- Main content -->
    <section class="content">   
    	<div class="container logo text-center col-sm-12">
        	<img src="assets/imagens/logo.png" alt="logo Escariz" />
      	</div>		
      	   
      <div class="container table-responsive" >
      </div>
              
        <div class="row ano_vigente">
          <div class="col-sm-12">
<%
double somatotal = 0;
VendasDAO daoVendas = new VendasDAO(conn);
String dataAtual = daoVendas.dataAtual();
String clausula = "";
List list = daoVendas.listarVendas(daoVendas.dataAtualInvertida());

if(list != null){

%>
            <p class="title font4" align="center">
              <%="Movimentação dos Caixas: "+ dataAtual%>               
            </p>           
            <br>
                  <%for ( Iterator it = list.iterator(); it.hasNext(); ) {
                		
                		VendasLojas vendasLojas = (VendasLojas) it.next();
                		
                %>
                    
                            
                 
 
                  <div class="col-md-4 col-sm-6 col-xs-12">
                  <div class="info-box">
                    <span class="info-box-icon bg-aqua"><i class="fa fa-shopping-cart"></i></span>

                    <div class="info-box-content">

                      <span class="info-box-text">
                       <%=vendasLojas.getLojaDesc(vendasLojas.getFilial()) %>
                      </span>
                      <span class="info-box-number">
                       <%=vendasLojas.getValorVendas()%>
                      </span>

                    </div>
                    <!-- /.info-box-content -->
                  </div>
                  <!-- /.info-box -->
                </div>
                <%
                somatotal +=vendasLojas.getValorVendas();
                %>

           <%} %>
               

          <div class="col-xs-12">
            <p class="title2 font5" align="center">
              <%=somatotal%>

            </p>
          </div>
        </div>

        <%      
    		}else {        
        %>
       
        
          <div class="alert alert-error" >
          <strong>
          <center><%= "Nenhuma venda foi encontrada na data: " + dataAtual %> </center>
          </strong>
          </div>
          <%} %>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      <a href="mailto:ti@escariz.com.br" target="_parent">Ti Escariz</a>
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2021 <a href="#">Escariz</a>.</strong> All rights reserved.
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.0 -->
<script type="text/javascript">
  $('#data1').mask('99/99/9999');
  $('#data2').mask('99/99/9999');
</script>

<script src="plugins/jQuery/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap2/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<%@include file="fimConexao.jsp"%>
</body>
</html>
