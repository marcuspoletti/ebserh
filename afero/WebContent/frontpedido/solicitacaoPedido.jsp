<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<html>
<script type="text/javascript">
function digitar() {
  if (document.all.comando.value == '') {
     window.alert("O campo é obrigatório.");
   }
   document.forms[0].submit();
}
function SomenteNumero(e){
    var tecla=(window.event)?event.keyCode:e.which;
    if((tecla > 47 && tecla < 58)) return true;
    else{
    if (tecla != 8) return false;
    else return true;
    }
}
</script>
<body onload="document.forms[0].elements[0].focus();">
<%
String tipoInput = "text";

if((!comandoGarcom.equals("N")) && (garcomOk)){
	tipoInput = "password";
	senhaGarcomOk = true;
	garcomOk = false;
}else if(!comandoGarcomSenha.equals("N") && senhaGarcomOk){
	tipoInput = "text";
	senhaGarcomOk = false;
	garcomOk = false;
	mesaOk = true;
}else if(!comandoMesa.equals("N") && mesaOk){
	tipoInput = "text";
	senhaGarcomOk = false;
	garcomOk = false;
	mesaOk = false;
	produtoOk = true;
}else if(!comandoProduto.equals("N") && produtoOk){
	tipoInput = "text";
	senhaGarcomOk = false;
	garcomOk = false;
	mesaOk = false;
	produtoOk = false;
	quantOk = true;
	
}else if(!comandoQuant.equals("N") && quantOk){
	tipoInput = "text";
	senhaGarcomOk = false;
	garcomOk = false;
	mesaOk = false;
	produtoOk = true;
	quantOk = false;
	
}
if((garcomOk) && (senhaGarcomOk == false)){
	mensagem = "DIGITE O CÓDIGO DO GARÇOM";
}
parametro = "?idPedidoSaida="+idPedidoSaida+"&produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk;
%>
<form name="comandos" method="post" action="logicaSolicitacao.jsp<%=parametro%>">
<table border="0" width="100%">
<tr>
<td>Mesa:<%=mesa%></td>
</tr>
<tr>
 <td class="grid"><font color="red"> <%=mensagem %></font></td>
</tr>
<tr>
 <td><input name="comando" align="left" type="<%=tipoInput%>" title="<%=mensagem%>" size="28" maxlength="28" ></td>
</tr>
</table>
<table border="2" width="100%">
<tr>
 <td class="label"><center><font color="black" size="5"><b> 7</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> 8</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> 9</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b>F3</b></font></center></td>
 </tr>
<tr>
 <td class="label"><center><font color="black" size="5"><b> 4</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> 5</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> 6</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b>F2</b></font></center></td>
</tr>
<tr>
 <td class="label"><center><font color="black" size="5"><b> 1</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> 2</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> 3</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b>F1</b></font></center></td>
</tr>
<tr>
 <td class="label"><center><font color="black" size="5"><b> 0</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> .</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> C</b></font></center></td>
 <td class="label"><center><font color="black" size="5"><b> E</b></font></center></td>
</tr>
</table>
<table border="2" width="50%">
<tr>
 <td>Garçom:<%=garcom%></td>
</tr>
</table>
</form>
</body>
</html>