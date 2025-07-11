function lercookie() {
	cookie = document.cookie.substring(document.cookie.indexOf(""),document.cookie.indexOf("end"));
	if (cookie=="") document.membros.login.value="";
	else document.membros.login.value=""+cookie+"";
}

function lockaccess() {
	L = document.membros.login.value;
	S = document.membros.senha.value;
	if (L=="" || S=="") document.membros.acesso.disabled=true, document.membros.lembrar.disabled=true;
	else document.membros.acesso.disabled=false, document.membros.lembrar.disabled=false;
}

function logar() {
	if (L.length < 4) alert("O nome de usuário precisa ter pelo menos 4 caracteres!");
	else if (S.length < 4) alert("A senha do usuário precisa ter pelo menos 4 caracteres!");
	else {
		abrir();
	}
}

function abrir() {
	window.open("validacaoLogin.jsp","_self","menubar=no,toolbar=no,location=no,directories=no,scrollbars=yes,status=no,resizable=yes"); 
	//escrever();
}

function escrever() {
	agora = new Date();
	agora.setTime(agora.getTime()+(365*24*60*60*1000));
	if (document.membros.lembrar.checked == true) {
		document.cookie=""+document.membros.login.value+"end"+agora+"; expires="+agora.toGMTString();+"";
	} else {
		document.cookie="end"+agora+"; expires="+agora.toGMTString();+"";
	}
}