<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>
<%@include file="perfil.jsp"%>

<%@ page import="util.Utilitaria" %>
<%@ page import="util.ConverteDate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>

<head>
<meta http-equiv="refresh" content="300">
</head>

<%
//String dataInicial = request.getParameter("dataInicial");
//String dataFinal = request.getParameter("dataFinal");
%>

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
        <li class="active">Extrato de Pacientes</li>
      </ol>
    </section>
<br>
<br>
    <!-- Main content -->
    <section class="content"> 
    
    	<div class="container logo text-center col-sm-12">
        	<img src="assets/imagens/t3.jpg" alt="logo HUL-UFS" />
      	</div>
    
    <div class="container table-responsive" >
		<div class="container text-center col-md-offset-5 col-sm-2">
			<form name="frmBusca" method="post" action="extratoPaciente.jsp?" >
			
				<label for="frmBusca">Data Inicial</label>
					<input type="text" id="data1" maxlength="10" name="dataInicial" autofocus class="form-transferencia text-center" placeholder="08/12/2011" required/>
			
			
				<label for="frmBusca">Data Final</label>              
					<input type="text" id="data2" maxlength="10" name="dataFinal" autofocus class="form-transferencia text-center" placeholder="31/01/2016" required/>
			 <br>
				<button type="text"  value="Buscar" class="btn btn-danger transferencia dropdown-toggle "> 
					<i class="glyphicon glyphicon-search"></i> Buscar
				</button>
			</form>
			<br>
		</div>
	</div> 
	
<% //if(dataInicial != null && dataFinal != null){ %>	    
      <div class="container table-responsive" >
      </div>
              
        <div class="row ano_vigente">
          <div class="col-sm-12">
<%
double somatotal = 0;
//VendasPeriodoDAO daoVendasPeriodo = new VendasPeriodoDAO(conn);
//String dataAtual = daoVendasPeriodo.dataAtual();
//String clausula =  " AND SL1.L1_EMISSAO BETWEEN '"+ConverteDate.convertData2(dataInicial)+"' AND '"+ConverteDate.convertData2(dataFinal)+"'"+
//				   " GROUP BY SL1.L1_FILIAL "+
///				   " ORDER BY SL1.L1_FILIAL ";
//List list;
//list = daoVendasPeriodo.listarVendasPeriodo(clausula);

//if(list != null){

%>
            <p class="title font4" align="center">
              <%="Movimentação dos Caixas: " %>               
            </p>           
            <br>
                  <%--for ( Iterator it = list.iterator(); it.hasNext(); ) {
                		
 //               	  VendasPeriodo vendasPeriodo = (VendasPeriodo) it.next();
                		
                --%>
                    
                            
                 
 
                  <div class="col-md-4 col-sm-6 col-xs-12">
                  <div class="info-box">
                    <span class="info-box-icon bg-aqua"><i class="fa fa-shopping-cart"></i></span>

                    <div class="info-box-content">

                      <span class="info-box-text">
                       <%--vendasPeriodo.getLojaDesc(vendasPeriodo.getFilial()) --%>
                      </span>
                      <span class="info-box-number">
                       <%--Utilitaria.formatarDinheiro(vendasPeriodo.getValorVendas()).toString() --%>
                      </span>

                    </div>
                    <!-- /.info-box-content -->
                  </div>
                  <!-- /.info-box -->
                </div>
                <%
                //omatotal +=vendasPeriodo.getValorVendas();
                %>

           <%//} %>
               

          <div class="col-xs-12">
            <p class="title2 font5" align="center">
              <%--Utilitaria.formatarDinheiro(somatotal).toString()--%>

            </p>
          </div>
        </div>

        <%      
    	//	}else {        
        %>
       
        
          <div class="alert alert-error" >
          <strong>
          <center><%= "Nenhuma venda foi encontrada na data: "%> </center>
          </strong>
          </div>
          <% %>
<% %>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      <a href="mailto:sgpti.hul@ebserh.gov.br" target="_parent">Hul-UFS</a>
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2025 <a href="#">HUL-UFS</a>.</strong> All rights reserved.
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

 jQuery 2.2.0 
   <script type="text/javascript">
  $('#data1').mask('99/99/9999');
  $('#data2').mask('99/99/9999');
</script>

<script>
$(function() {
    $("#data2").datepicker({
        dateFormat: 'dd/mm/yy',
        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
        dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez']
    });
    
    $("#data1").datepicker({
        dateFormat: 'dd/mm/yy',
        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
        dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez']
    });
});
</script>



				


  <script src="plugins/jQuery/jQuery-2.2.0.min.js"></script> 
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap2/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

</body>
</html>
