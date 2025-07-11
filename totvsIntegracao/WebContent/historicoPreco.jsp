<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="config.jsp"%>
<%@include file="menu.jsp"%>


<%@ page import="model.HistoricoPreco" %>
<%@ page import="utilitario.Utilitaria" %>
<%@ page import="persistence.HistoricoPrecoDAO" %>
<%@ page import="utilitario.ConverteDate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="iniConexao.jsp"%>


<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

<%@include file="perfil.jsp"%>

<%
String codigo = request.getParameter("codigo");
String database = request.getParameter("database");
%>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Nível</a></li>
        <li class="active">Historioco de Preço</li>
      </ol>
    </section>
<br>
    <!-- Main content -->
    <section class="content">
      <div class="container logo text-center col-sm-12">
        <img src="assets/imagens/logo.png" alt="logo Escariz" />
      </div>
    <br>
    
        <div class="container text-center col-md-offset-3 col-sm-5 col-xs-12">
          <form name="frmBusca" method="post" action="historicoPreco.jsp?" >
              <div class="container text-center col-md-offset-5 col-sm-6">
                <label for="frmBusca">Data Base</label>
                <input type="text" id="data1" maxlength="15" name="database" autofocus class="form-transferencia text-center" placeholder="31/12/2020" required/>
                </br>
              </div>
              <input type="text" name="codigo" autofocus class="form-control text-center" placeholder="Digite Código de Barras do Produto" required/>    
              <button type="text"  value="Buscar" class="btn btn-danger dropdown-toggle pull-right hidden-xs"> 
                <i class="glyphicon glyphicon-search"></i> Buscar
              </button>
          </form>
        </div>
        
<% if( codigo != null){

	int cont = 0;
	HistoricoPrecoDAO dao = new HistoricoPrecoDAO(conn);
	List list;
	list = dao.historicoPreco(database,codigo);

%>

<%if(list != null){ %>

     
    <div class="container table-responsive col-sm-12" >          
      <div class="row ano_vigente">
        <div class="col-sm-12">
          <br>
          <h3>
            <center><%="Historico do Produto Encontrado:" + codigo %></center>
            
          </h3>
        </div>
      </div>        
     
            <table id="mainTable" class="table table-bordered table-striped " >
              <thead>
                  <tr>
                  <th style="width: 4%;">Produto</th>
                  <th style="width: 9%;">Preço Atual</th>
                  <th style="width: 9%;">Ultimo Preço Vendido</th>
                  <th style="width: 9%;">Data Ultimo Preço Vendido</th>
                  <th style="width: 9%;">Penultimo Preço Vendido</th>
                  <th style="width: 9%;">Data Penultimo Preço Vendido</th>
                  </tr>
              </thead>
                <tbody>
                
<%

for ( Iterator it = list.iterator(); it.hasNext(); ) {
	HistoricoPreco historicoPreco = (HistoricoPreco) it.next();
	cont++;
	
%> 
                    
                    <tr >
                <!--mostra na tabela o produto encontrado-->                                  
                  <td scope="row">
                     <%=historicoPreco.getProduto()%>
                  </td>
                  <td scope="row">
                     <%=Utilitaria.formatarDinheiro(historicoPreco.getPrecoAtual()).toString()%>  
                  </td>
                  <td scope="row"> 
                   	 <%=Utilitaria.formatarDinheiro(historicoPreco.getUltimoPrecoVendido()).toString()%>
                  </td>
                  <td scope="row">
                     <%=historicoPreco.getDataUltimoPrecoVendido() %>
                  </td>
                  <td scope="row">
                     <%=Utilitaria.formatarDinheiro(historicoPreco.getPenultimoPreçoVendido()).toString()%>
                  </td>
                  <td scope="row">
                      <%=historicoPreco.getDataPenultimoPreçoVendido()%>
                  </td>
                  
                  </tr>
                  
   <%} %> 
                  <!-- para exibir botÃ£o de voltar para o topo -->
                  <a href="#"><img class="image-switch" title="Ir para o topo"/></a>  
                </tbody>                                
            </table>                
           
    </div>
    
    <%}else if( list != null) { %>
		<div class="alert alert-error" >
        	<strong><center> <%="Nenhum produto foi encontrado, você digitou:" + codigo %> </center></strong>
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
      <a href="mailto:ti@escariz.com.br" target="_parent">TI ESCARIZ</a>
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2020 <a href="#">Escariz</a>.</strong> All rights reserved.
  </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- REQUIRED JS SCRIPTS -->
<script type="text/javascript">
  $('#data1').mask('99/99/9999'); 
</script>

<!-- jQuery 2.2.0 -->
<script src="plugins/jQuery/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap2/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

<script>
//para exibir botÃ£o de voltar para o topo            
jQuery(document).ready(function() {
            // Exibe ou oculta o botÃ£o
            jQuery(window).scroll(function() {
                if (jQuery(this).scrollTop() > 300) {
                    jQuery('.image-switch').fadeIn(300);
                } else {
                    jQuery('.image-switch').fadeOut(200);
                }
            });
            
            // Faz animaÃ§Ã£o para subir
            jQuery('.image-switch').click(function(event) {
                event.preventDefault();
                jQuery('html, body').animate({scrollTop: 0}, 300);
            })
        });

</script>
</body>
</html>
