<html>
<head>
<title>teste</title>

<script language="JavaScript">
function FormataValor(campo,tammax,teclapres) {
var tecla = teclapres.keyCode;
vr = document.form[campo].value;
vr = vr.replace( "/", "" );
vr = vr.replace( "/", "" );
vr = vr.replace( ",", "" );
vr = vr.replace( ".", "" );
vr = vr.replace( ".", "" );
vr = vr.replace( ".", "" );
vr = vr.replace( ".", "" );
tam = vr.length;
if (tam < tammax && tecla != 8){ tam = vr.length; }
if (tecla == 8 ){ tam = tam - 1; }
if ( tecla == 8 || tecla >= 48 && tecla <= 57 || tecla >= 96 && tecla <= 105 ){
if ( tam <= 2 ){
document.form[campo].value = vr; }
if ( (tam > 2) && (tam <= 5) ){
document.form[campo].value = vr.substr( 0, tam - 2 ) + ',' + vr.substr( tam - 2, tam ); }
if ( (tam >= 6) && (tam <= 8) ){
document.form[campo].value = vr.substr( 0, tam - 5 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ); }
if ( (tam >= 9) && (tam <= 11) ){
document.form[campo].value = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ); }
if ( (tam >= 12) && (tam <= 14) ){
document.form[campo].value = vr.substr( 0, tam - 11 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ); }
if ( (tam >= 15) && (tam <= 17) ){
document.form[campo].value = vr.substr( 0, tam - 14 ) + '.' + vr.substr( tam - 14, 3 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam );}
}
}

</script>
</head>

<body>
<form method="POST" name="form">
<p><input type="Text" name="valor" size="23" maxlength="17" onKeyUp="FormataValor('valor', 13, event)"></p>
</form>
</body>
</html>