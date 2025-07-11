<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>
<%@include file="perfil.jsp"%>

<%@ page import="model.MovimentacaoPDVTipo" %>
<%@ page import="utilitario.Utilitaria" %>
<%@ page import="utilitario.ConverteDate" %>
<%@ page import="persistence.MovimentacaoPDVTipoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="iniConexao.jsp"%>
<head>
<meta http-equiv="refresh" content="300">
</head>



<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<%@include file="perfil.jsp"%>

<%
String dataInicial = request.getParameter("dataInicial");
String dataFinal = request.getParameter("dataFinal");
%>
  <!-- Main Header ficava aqui o que estÃƒÂ¡ no arquivo perfil-->
  
  <!-- Left side column. contains the logo and sidebar ficaria aqui o menu, mas retirei-->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Nível</a></li>
        <li class="active">Movimentação PDV POR TIPO</li>
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
		<div class="container text-center col-md-offset-5 col-sm-2">
			<form name="frmBusca" method="post" action="movimentacaoPDVTipo.jsp?" >
				<label for="frmBusca">Data Inicial</label>
					<input type="text" id="data1" maxlength="10" name="dataInicial" autofocus class="form-transferencia text-center" placeholder="08/12/2011" required/>
				<label for="frmBusca">Data Final</label>              
					<input type="text" id="data2" maxlength="10" name="dataFinal" autofocus class="form-transferencia text-center" placeholder="31/01/2016" required/>
				</br>
				 
				<button type="text"  value="Buscar" class="btn btn-danger transferencia dropdown-toggle "> 
					<i class="glyphicon glyphicon-search"></i> Buscar
				</button>
			</form>
			<br>
		</div>
	</div>
<br>
<br>


<% if(dataInicial != null && dataFinal != null){ %>	    

          
<%
int cont = 0;
MovimentacaoPDVTipoDAO dao = new MovimentacaoPDVTipoDAO(conn);
List list;
list = dao.movimentacaoPDVtipo(dataInicial,dataFinal);

if(list != null){

%>

    <div class="container table-responsive col-sm-12" >          
      <div class="row ano_vigente">
        <div class="col-sm-12">
          <br>
          <h3>
            <center><%="Movimentação dos PDV's: "+ dataInicial + " até " + dataFinal %> </center>  
          </h3>
        </div>
      </div>
      
      <table id="mainTable" class="table table-bordered table-striped " >
              <thead>
                  <tr>
                  <th style="width: 4%;">Filial</th>
                  <th style="width: 9%;">Quantidade Vendida</th>
                  <th style="width: 9%;">Tipo</th>
                  
                  </tr>
              </thead>
                <tbody>
            
      <%for ( Iterator it = list.iterator(); it.hasNext(); ) {                		
      	 	MovimentacaoPDVTipo movimentacaoPDVTipo = (MovimentacaoPDVTipo) it.next();  
      		cont++;
      %>
 			<tr>
 				<!--mostra na tabela o produto encontrado-->
 				<td scope="row">
                    <%=movimentacaoPDVTipo.getLojaDesc(movimentacaoPDVTipo.getFilial())%>
                </td>   
                <td scope="row">
                    <%=Utilitaria.formatarDinheiro(movimentacaoPDVTipo.getQuantidadeVendida()).toString()%>
                </td>
                <td scope="row">
                   <%=movimentacaoPDVTipo.getTipo()%>
                </td>
 			</tr>
 	<%} %>

   <!-- para exibir botão de voltar para o topo -->
     <a href="movimentacaoPDVTipo.jsp"><img class="image-switch" title="Ir para o topo"/></a>  
        </tbody>                                
     </table>
     
 </div>
 
 <%}else if(list.isEmpty()) { %>
	       <div class="container table-responsive col-sm-12" >          
	         <div class="row ano_vigente">
	           <div class="col-sm-12">
	             <h3>
	               <center><%="PERIODO SEM VENDAS"%>  </center>
	             </h3>
	           </div>
	         </div>
	        </div>

<%
	}
 }
%>                 

                   

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
    <strong>Copyright &copy; 2020 <a href="#">Escariz</a>.</strong> All rights reserved.
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
