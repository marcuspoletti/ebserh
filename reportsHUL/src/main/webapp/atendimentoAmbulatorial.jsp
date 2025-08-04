<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>


<%@ page import="util.Utilitaria" %>
<%@ page import="util.ConverteDate" %>
<%@ page import="dao.AtendimentoAmbulatorialDAO" %>
<%@ page import="model.AtendimentoAmbulatorial" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="iniConexao.jsp"%>

<head>
<meta http-equiv="refresh" content="300">
</head>

<%
String dataInicial = request.getParameter("dataInicial");
String dataFinal = request.getParameter("dataFinal");
dataInicial += " 00:00:00";
dataFinal += " 00:00:00";
System.out.println("INICIAL---->"+dataInicial);
System.out.println("FINAL------>"+dataFinal);
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
        <li class="active">Atendimentos Ambulatoriais</li>
      </ol>
    </section>
<br>
 
<br>
   
  
    <!-- Main content -->
    <section class="content"> 
    
    	<div class="container logo text-center col-sm-12">
        	<p class="fa fa-dashboard"><strong>Atendimentos Ambulatoriais</strong></p>
      	</div>
    
    <div class="container table-responsive" >
		<div class="container text-center col-md-offset-5 col-sm-2">
			<form name="frmBusca" method="post" action="atendimentoAmbulatorial.jsp?" >
			
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
AtendimentoAmbulatorialDAO daoAtendimentoAmbulatorialDAO = new AtendimentoAmbulatorialDAO(conn);
List list;
list = daoAtendimentoAmbulatorialDAO.getAtendimentoAmbulatorialDAO(dataInicial, dataFinal);

int gridSize = 100;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize+1; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}



if(list != null){
%>
	 <table id="mainTable" class="table table-bordered table-striped " >
     <thead>
         <tr>
         <th style="width: 1%;">&nbsp;</th>
         <th style="width: 15%;">Paciente</th>
         <th style="width: 5%;">Prontuário</th>
         <th style="width: 5%;">Cód. Paciente</th>
         <th style="width: 5%;">Sexo</th>
         <th style="width: 5%;">Nascimento</th>
         <th style="width: 5%;">Consulta</th>
         <th style="width: 5%;">Especialidade</th>
         <th style="width: 5%;">Marcação Med.</th>
         <th style="width: 5%;">Início Con. Médica</th>
         <th style="width: 5%;">Fim Con. Médica</th>
         <th style="width: 5%;">Tempo Espera</th>
         <th style="width: 5%;">Tempo Atendimento</th>
         </tr>
     </thead>
       <tbody>
    <%for ( Iterator it = list.iterator(); it.hasNext(); ) {                		
    	AtendimentoAmbulatorial daoListAtendimentoAmbulatorial = (AtendimentoAmbulatorial) it.next();  
      		cont++;
      %>
      <tr>
 				<!--mostra na tabela o produto encontrado-->
 				<td scope="row">
                    <%=rowNum+cont%>
                </td> 
 				<td scope="row">
                    <%=daoListAtendimentoAmbulatorial.getPaciente()%>
                </td>   
                <td scope="row">
                   <%if(daoListAtendimentoAmbulatorial.getPacProntuario()!= null){ %>
      				<%=daoListAtendimentoAmbulatorial.getPacProntuario()%>
               <%}else{%>
      	           <%=" SEM REGISTRO " %>
                <%}%>
                </td>
                
                <td scope="row">
                   <%=daoListAtendimentoAmbulatorial.getCodPaciente()%>
                </td>
                <td scope="row">
                   <%=daoListAtendimentoAmbulatorial.getSexo()%>
                </td>
                  <td scope="row">
                   <%=daoListAtendimentoAmbulatorial.getDtNascimento()%>
                </td>
                 <td scope="row">
                   <%=daoListAtendimentoAmbulatorial.getNumConsulta()%>
                </td>
                 <td scope="row">
                   <%if(daoListAtendimentoAmbulatorial.getSiglaEsp()!= null){ %>
      				<%=daoListAtendimentoAmbulatorial.getSiglaEsp()%>
               <%}else{%>
      	           <%=" SEM REGISTRO " %>
                <%}%>
                </td>
                 <td scope="row">
                <%if(daoListAtendimentoAmbulatorial != null){ %>
      				<%=daoListAtendimentoAmbulatorial.getMarcacaoMedica()%>
               <%}else{%>
      	           <%=" SEM REGISTRO " %>
                <%}%>
                </td>
                <%if(daoListAtendimentoAmbulatorial.getIniConMed() != null){ %>
                <td scope="row">
      				<%= daoListAtendimentoAmbulatorial.getIniConMed() %>
      			</td>	
               <%}else{%>
      	           <td scope="row" bgcolor="red">
      				<%=" SEM REGISTRO " %>
      			</td>	
                <%}%>
                <td scope="row">
      				<%= daoListAtendimentoAmbulatorial.getFimConMed() %>
      			</td>
      			<td scope="row">
      				<%=daoListAtendimentoAmbulatorial.getTempoEspera() %>
      			</td>
             	<td scope="row">
      				<%=daoListAtendimentoAmbulatorial.getTempoAtendimento() %>
      			</td>
                
 	 </tr>
 	 <%} %>
 </table>
 	 
 	 
 	 
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
%>

	 <br >
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="atendimentoAmbulatorial.jsp?rowNum=<%=0%>&dataInicial=<%=dataInicial%>&dataFinal=<%=dataFinal%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="atendimentoAmbulatorial.jsp?rowNum=<%=rowNum-gridSize%>&dataInicial=<%=dataInicial%>&dataFinal=<%=dataFinal%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="atendimentoAmbulatorial.jsp?rowNum=<%=rowNum+gridSize%>&dataInicial=<%=dataInicial%>&dataFinal=<%=dataFinal%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="atendimentoAmbulatorial.jsp?rowNum=<%=rowCount-gridSize%>&dataInicial=<%=dataInicial%>&dataFinal=<%=dataFinal%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>

<%
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
