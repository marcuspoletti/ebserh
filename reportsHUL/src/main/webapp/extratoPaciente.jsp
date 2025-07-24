<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>


<%@ page import="util.Utilitaria" %>
<%@ page import="util.ConverteDate" %>
<%@ page import="dao.ExtratoPacienteDAO" %>
<%@ page import="model.ExtratoPaciente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="iniConexao.jsp"%>

<head>
<meta http-equiv="refresh" content="300">
</head>

<%
String dataInicial = request.getParameter("dataInicial");
String dataFinal = request.getParameter("dataFinal");
System.out.println(dataInicial);
System.out.println(dataFinal);
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
        	<p class="fa fa-dashboard"><strong>Extrato Paciente</strong></p>
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
	
<% if(dataInicial != null && dataFinal != null){ %>	    

          
<%
int cont = 0;
ExtratoPacienteDAO daoExtratoPacienteDAO = new ExtratoPacienteDAO(conn);
List list;
list = daoExtratoPacienteDAO.getExtratoPacienteDAO(dataInicial+" 00:00:00", dataFinal+" 00:00:00");

if(list != null){
%>
	 <table id="mainTable" class="table table-bordered table-striped " >
     <thead>
         <tr>
         <th style="width: 15%;">Nome</th>
         <th style="width: 5%;">Nascimento</th>
         <th style="width: 5%;">Prontuário</th>
         <th style="width: 9%;">Nome Especialidade</th>
         <th style="width: 15%;">Unidade Funcional</th>
         <th style="width: 15%;">Tipo Movimentação Internação</th>
         <th style="width: 5%;">Internação</th>
         <th style="width: 5%;">Lançamento</th>
         <th style="width: 5%;">Alta Médica</th>
         </tr>
     </thead>
       <tbody>
    <%for ( Iterator it = list.iterator(); it.hasNext(); ) {                		
    	ExtratoPaciente daoListExtratoPaciente = (ExtratoPaciente) it.next();  
      		cont++;
      %>
      <tr>
 				<!--mostra na tabela o produto encontrado-->
 				<td scope="row">
                    <%=daoListExtratoPaciente.getNome()%>
                </td>   
                <td scope="row">
                   <%if(daoListExtratoPaciente.getDtNascimento()!= null){ %>
      				<%=ConverteDate.YMDToDMY(daoListExtratoPaciente.getDtNascimento())%>
               <%}else{%>
      	           <%=" SEM REGISTRO " %>
                <%}%>
                </td>
                
                <td scope="row">
                   <%=daoListExtratoPaciente.getProntuario()%>
                </td>
                <td scope="row">
                   <%=daoListExtratoPaciente.getNomeEspecialidade()%>
                </td>
                  <td scope="row">
                   <%=daoListExtratoPaciente.getUnidadeFuncional()%>
                </td>
                 <td scope="row">
                   <%=daoListExtratoPaciente.getTpMovimentoInternacao()%>
                </td>
                 <td scope="row">
                   <%if(daoListExtratoPaciente.getDtInternacao()!= null){ %>
      				<%=ConverteDate.YMDToDMY(daoListExtratoPaciente.getDtInternacao())%>
               <%}else{%>
      	           <%=" SEM REGISTRO " %>
                <%}%>
                </td>
                 <td scope="row">
                <%if(daoListExtratoPaciente.getDtLancamento() != null){ %>
      				<%=ConverteDate.YMDToDMY(daoListExtratoPaciente.getDtLancamento())%>
               <%}else{%>
      	           <%=" SEM REGISTRO " %>
                <%}%>
                </td>
                <%if(daoListExtratoPaciente.getDtAltaMedica() != null){ %>
                <td scope="row" bgcolor="green">
      				<%= ConverteDate.YMDToDMY(daoListExtratoPaciente.getDtAltaMedica()) %>
      			</td>	
               <%}else{%>
      	           <td scope="row" bgcolor="red">
      				<%=" SEM REGISTRO " %>
      			</td>	
                <%}%>
                
             
                </td>
 	 </tr>
 	 <%} %>
<%}else if(list.isEmpty()) { %>
<div class="container table-responsive col-sm-12" >          
	         <div class="row ano_vigente">
	           <div class="col-sm-12">
	             <h3>
	               <center><%="SEM MOVIMENTAÇÃO NO PERÍODO"%>  </center>
	             </h3>
	           </div>
	         </div>
	        </div>

<%
	}
 }
%>   


 <script type="text/javascript">
  $('#data1').mask('99/99/9999');
  $('#data2').mask('99/99/9999');
</script>

<script src="plugins/jQuery/jQuery-2.2.0.min.js"></script> 
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap2/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
</body>
</html>
