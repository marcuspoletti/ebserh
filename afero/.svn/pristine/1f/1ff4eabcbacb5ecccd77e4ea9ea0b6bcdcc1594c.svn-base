function isEnter(tecla, funcao) {
  if (tecla.keyCode == 13) {
    eval(funcao);
  }
}

function comboSelect(combo,key) {
  var err = window.onerror; 
  window.onerror = new Function('return true'); 
  if (!combo) return; 
  combo.selectedIndex=-1; 
  for (var i = 0; i < combo.options.length; i++) {
    if (combo.multiple) {
      combo.options[i].selected=((","+key+",").indexOf(","+combo.options[i].value+",") != -1); 
    } else {
      combo.options[i].selected=(combo.options[i].value == key);
    }
  }
  window.onerror = err;
}

function radioSelect(radio,key) {
    var err = window.onerror; 
    window.onerror = new Function('return true'); 
    if (!radio) return; for (var i = 0; i < radio.length; i++) {
        radio[i].checked=(','+key+',').indexOf(','+radio[i].value+',')!=-1; 
    }
    window.onerror = err;
}

function reloadImages(caminho, imagens) {
  var lista = imagens.split(",");
  for (var i = 0; i < lista.length; i++) {
    new Image().src = caminho + lista[i];
  }
}

function excluir(msg){
  if (!msg) msg = "Deseja excluir o registro?";
  return confirm(msg);
}

function chkRequiredCombo(frm, msg){
	if (!msg || msg == "")
		msg = "Campo obrigatório não preenchido";
	var combo = frm.getElementsByTagName('SELECT');
	for (var i = 0; i < combo.length; i++)
      	if (combo[i].getAttribute("REQUIRED") == "true")
			if (combo[i].value == -1){ 
  				alert(msg);
				combo[i].focus();
				return false;
		}
   return true;
}

function nextFocus(i) {
  if (document.forms.length==0) return;
  var f = window.document.forms[0]; 
  var e = null; 
  var firstLoop = true;
  if (i >= f.elements.length) i = 0;
  while (f.elements.length>i) {
    e = f.elements[i];
    if ((e.type == 'hidden') ||(e.type == null)) {
      i=i+1;
      if (i >= f.elements.length) {
	if (!firstLoop) return;
	firstLoop=false;
	i = 0;
      }
      continue;
    }
    if (e.disabled) {
      i=i+1;
      if (i >= f.elements.length) {
        if (!firstLoop) return;
        firstLoop=false;
        i = 0;
      }
      continue;
    }
    if (e.readOnly) {
      i=i+1;
      if (i >= f.elements.length) {
        if (!firstLoop) return;
        firstLoop=false;
        i = 0;
       }
       continue;
    }		
    if ((e.style.display == "none") || (e.style.visibility == "hidden")) {
      i=i+1;
      if (i >= f.elements.length) {
	if (!firstLoop) return;
 	firstLoop=false;
  	i = 0;
      }
      continue;
    }
    e.focus();
    break;
  }
}

function mTr(s,s1,s2) {
   var p;
   var sai="";
   for (var j=0; j<s.length; j++) {
    p=s1.indexOf(s.substring(j,j+1));
    sai=sai + (p<0 ? s.substring(j, j+1) : s2.substring(p, p+1));
   }
   return sai;
}

// radio = document.forms[0].elements["nome do radio"];
function getValueRadio(radio) {
   if (radio) {
       if (!radio.length) {
         if (radio.checked) return radio.value;
         return "undefined";
       }
       for (var i = 0; i < radio.length; i++) {
          if (radio[i].checked) return radio[i].value;
       }
   }
   return "undefined";
}

function trim(txt) {
   while((txt.charAt(0)==" ")||(txt.charAt(txt.length-1)==" "))
      txt = txt.replace(/^ /,"").replace(/ $/,"");
   return txt;
}

function marcar(id, valor) {
  var obj = document.getElementsByTagName("input");
  if (obj) {
    if (obj.length) {
      for (i = 0; i < obj.length; i++) if (obj[i] && obj[i].id == id) obj[i].checked = valor;
    } else {
      obj.checked = valor;
    }
  }
}

//FormataValor(this,event) 2 casas decimais e não aceita sinal negativo
function FormataValor(campo,tecla, dec, fl_neg) {
	if (dec==undefined) dec=2;
	if (tecla.keyCode == 35 || tecla.keyCode == 36 || tecla.keyCode == 37 || tecla.keyCode == 38 ||
	    tecla.keyCode == 39 || tecla.keyCode == 40 || tecla.keyCode == 34 || tecla.keyCode == 33 || tecla.keyCode == 9)
		return;
	var vr = new String(campo.value);
	if (fl_neg=='negativo')
	{
	  var neg = vr.indexOf('-');
	}
	
	vr = Limpar(vr,"0123456789");
	if (vr.length > 0) {
	  while (vr.charAt(0) == '0' && vr.length > 1) vr = vr.substring(1);
	}
	var tam = vr.length;
	var aux = "";
	if ( tam <= dec ){ 
	    for (i=tam-1; i<dec;i++) { 
			vr = "0" + vr;
			tam = vr.length;
		}
		campo.value = vr ; }
 	if ( (tam > dec) && (tam <= dec+3) ){
		if (dec == 0) {
 		  campo.value = vr.substr( 0, tam - dec ) ;
		} else {
 		  campo.value = vr.substr( 0, tam - dec ) + ',' + vr.substr( tam - dec, tam ) ; 
		}
	}
 	if ( (tam >= dec+4) && (tam <= dec+6) ){
		if (dec == 0) {
 		  campo.value = vr.substr( 0, tam - (dec+3) ) + '.' + vr.substr( tam - (dec+3), 3 ); 
		} else {
 		  campo.value = vr.substr( 0, tam - (dec+3) ) + '.' + vr.substr( tam - (dec+3), 3 ) + ',' + vr.substr( tam - dec, tam ) ; 
		}
	}
 	if ( (tam >= dec+7) && (tam <= dec+9) ){
		if (dec == 0) {
 		  campo.value = vr.substr( 0, tam - (dec+6) ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) ; 
		} else {
 		  campo.value = vr.substr( 0, tam - (dec+6) ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) + ',' + vr.substr( tam - dec, tam ) ; 
		}
	}
 	if ( (tam >= dec+10) && (tam <= dec+12) ){
		if (dec == 0) {
 		  campo.value = vr.substr( 0, tam - (dec+9) ) + '.' + vr.substr( tam - (dec+9), 3 ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) ;
		} else {
 		  campo.value = vr.substr( 0, tam - (dec+9) ) + '.' + vr.substr( tam - (dec+9), 3 ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) + ',' + vr.substr( tam - dec, tam ) ;
		}
	}
 	if ( (tam >= dec+13) && (tam <= dec+15) ){
		if (dec == 0) {
 		  campo.value = vr.substr( 0, tam - (dec+12) ) + '.' + vr.substr( tam - (dec+12), 3 ) + '.' + vr.substr( tam - (dec+9), 3 ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) ;
		} else {
 		  campo.value = vr.substr( 0, tam - (dec+12) ) + '.' + vr.substr( tam - (dec+12), 3 ) + '.' + vr.substr( tam - (dec+9), 3 ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) + ',' + vr.substr( tam - dec, tam ) ;
		}
	}
 	if ( (tam >= dec+16) && (tam <= dec+18) ){
		if (dec == 0) {
 		  campo.value = vr.substr( 0, tam - (dec+15) ) + '.' + vr.substr( tam - (dec+15), 3 ) + '.' + vr.substr( tam - (dec+12), 3 ) + '.' + vr.substr( tam - (dec+9), 3 ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) ;
		} else {
 		  campo.value = vr.substr( 0, tam - (dec+15) ) + '.' + vr.substr( tam - (dec+15), 3 ) + '.' + vr.substr( tam - (dec+12), 3 ) + '.' + vr.substr( tam - (dec+9), 3 ) + '.' + vr.substr( tam - (dec+6), 3 ) + '.' + vr.substr( tam - (dec+3), 3 ) + ',' + vr.substr( tam - dec, tam ) ;
		}
	}
	var aux = "0,";
        if (dec == 0) aux = "0";
	for (i = 0; i < dec; i++) {
	  aux = aux + "0";
	}

	if (aux == campo.value && (tecla.keyCode == 8 || tecla.keyCode == 46)) campo.value = "";
	if (fl_neg=='negativo')
	{
          if (neg=='0') {campo.value='-'+campo.value; aux='-'+aux;}
	}

}

// remove formataçao de numeros, deixando apenas um ponto decimal
// exemplo: limpaNumero("1.234,56") -> retorna 1234.56
function limpaNumero(c){
  c=c.replace(/,/g,".");
  p=c.lastIndexOf(".")
   if (p == -1) p = c.length;
  c=c.substr(0,p).replace(/\./g,"")+c.substr(p);
  return c;
}

function FormatarInv(Str, Fmt) {
// O mesmo que o anterior, iniciando pelo final do molde.
  var Sai = "";
  var j = Str.length-1;
  for (var i=Fmt.length-1; i>=0; i--)
    if (Fmt.substring(i,i+1)=="_") {
       Sai = Str.substring(j,j+1) + Sai;
       j = j - 1;
       if (j<0) break;
    } else {
      Sai = Fmt.substring(i, i+1) + Sai;
    }
  return Sai;
}

function Limpar(valor, validos) {
// retira caracteres invalidos da string
  var result = "";
  var aux;
  for (var i=0; i < valor.length; i++) {
    val = valor.substring(i, i+1);
    aux = validos.indexOf(val);
      if (aux>=0) {
        result += val;
      }
  }
  return result;
}

function cData(data,mask) {
/* retorna -1 se data nao tiver 6 ou 8 digitos numericos
   retorna -2 se mes for invalido
   retorna -3 se dia for invalido
   retorna a data (ddmmaaaa) se ok
*/
  data = Limpar(data,"0123456789");
  if ((data.length != 8) &&(data.length != 6)) { return -1; }
  // transforma os valores em inteiros
  var dia = parseInt(data.substring(0,2),10);
  var mes = parseInt(data.substring(2,4),10);
  var ano = parseInt(data.substring(4),10);
  // corrige ano (no caso de ter apenas 2 digitos)
  if (ano < 100) { 
    if (ano < 50) { ano += 2000; }
    else { ano += 1900; }
  }
  //verifica o mes
  if (mes > 12) { return -2; }
  // verifica o numero de dias do mes
  switch (mes) {
  case 1: case 3: case 5: case 7: case 8: case 10: case 12:
      numdias = 31;
      break;
  case 4: case 6: case 9: case 11:
      numdias = 30;
      break;
  case 2:
    if (bissexto(ano)) { numdias = 29; }
    else {numdias = 28; }
  }
  //verifica o numero de dias
  if (dia > numdias) { return -3; }
  sdia = ((dia<10) ? "0" : "") + dia;
  smes = ((mes<10) ? "0" : "") + mes;
  sano4 = ano+""; 
  sano2= (ano+"").substring(2,4);
  d = /dd/; m = /MM/; y2 = /yy/; y4= /yyyy/;
  ret=mask.replace(d, sdia).replace(m,smes).replace(y4,sano4).replace(y2,sano2);
  return ret;
}

function bissexto(strano) {
/* retorna true se o ano for bissexto */
  var ano = parseInt(strano+"",10);
  if ((ano%4)!= 0) { return false; }
  if (((ano%100) == 0) &&((ano%400)!=0)) { return false; }
  return true;
}


function CNPJdv(CNPJ) {
  CNPJ = Limpar(CNPJ,"0123456789");
  if (CNPJ.length != 12) { return ""; }
  var checar = CNPJ.substring(12);
  CNPJ = CNPJ.substring(0,12);
  var soma = 0;
  for (var i=0; i<4; i++) { 
    soma = soma + CNPJ.substring(i,i+1)*(5-i);
  }
  for (var i=4; i<12; i++) { 
    soma = soma + CNPJ.substring(i,i+1)*(13-i);
  }
  var cnpjdv = 11 - (soma % 11);
  if ( cnpjdv >= 10 ) { 
    cnpjdv = 0;
  }
  soma = 0;
  for (var i = 0; i<5; i++) { 
    soma = soma + CNPJ.substring(i,i+1)*(6-i);
  }
  for (var i = 5; i<12; i++) { 
    soma = soma + CNPJ.substring(i,i+1)*(14-i);
  }
  soma = soma + cnpjdv * 2;
  var cnpjdv2 = 11 - (soma%11);
  if ( cnpjdv2 >= 10 ) { 
    cnpjdv2 = 0;
  }
  cnpjdv += "" + cnpjdv2;
  return cnpjdv;
}     


function CPFdv(CPF) {
  CPF = Limpar(CPF,"0123456789");
  if (CPF.length != 9) { return ""; }
  var soma = 0;
  var checar = CPF.substring(9);
  CPF = CPF.substring(0,9);
  for (var i=0; i<9; i++) { 
    soma = soma + CPF.substring(i,i+1)*(10-i);
  }
  var cpfdv = 11 - (soma % 11);
  if ( cpfdv >= 10 ) { 
    cpfdv = 0;
  }
  soma = 0;
  for (var i=0; i<9; i++) {
    soma = soma + CPF.substring(i,i+1)*(11-i);
  }
  soma = soma + cpfdv * 2;
  var cpfdv2 = 11 - (soma%11);
  if ( cpfdv2 >= 10 ) { 
    cpfdv2 = 0;
  }
  cpfdv += ""+cpfdv2;
  return cpfdv;
}

function piece(str,delim,ind) {
   var aux = str.split(delim);
   if (ind <= aux.length) {
     return aux[ind-1];
   }
}   

var xpObj = null;
function msgErr(obj,msg) {
   if (msg!="") alert (msg);
   xpObj = obj;
   setTimeout("selObj()",10);
}

function selObj () {
   if (!xpObj) return;
   xpObj.focus(); 
   xpObj.select();
   xpObj = null;
}

// chkInt(this)
function chkInt(obj, msg) {
   if (!obj || obj.value=="") return;
   if (isNaN(parseInt(obj.value, 10))) {
      if (!msg || msg=="") msg = "Não é um número válido.";
      msgErr (obj, msg);
   }
}

// chkNum(this)
function chkNum(obj, msg) {
   if (!obj || obj.value=="") return;
   var n = parseFloat(limpaNumero(obj.value), 10);
   if (n=="NaN") {
      if (!msg || msg=="") msg = "Não é um número válido.";
      msgErr (obj, msg);
   }
}


// chkCep(this)
function chkCep(obj,msg) {
   if (!msg || msg=="") msg = "Não é um número válido.";
   if (!obj) return;
   var val=mTr (obj.value, ",.-/", "");
   if (obj.value=="") return;
   msg = msg +  " Deve conter 8 números"
   if (val.length!=8) return msgErr(obj,msg);
   if (Limpar(val, "0123456789") != val) return msgErr(obj,msg);
   obj.value = FormatarInv(val, "_____-___");
}

// chkData(this,'dd/MM/yyyy')
function chkData(obj, mask, msg) {
   if (!obj || obj.value=="") return;
   if (!mask || mask== "") mask = "dd/MM/yyyy"; 
   var st = cData(obj.value, mask);
   if (!msg) msg = "";
   if (st == -1) return msgErr(obj, msg + " Deve conter 6 ou 8 números");
   if (st == -2) return msgErr(obj, msg + " Mês inválido");
   if (st == -3) return msgErr(obj, msg + " Dia inválido");
   obj.value =  st;
}

// chkCPFCNPJ(this)
function chkCPFCNPJ(obj, msg) {
  if (!msg) msg = "";
  if (!obj || obj.value=="") return;
  var CPFCNPJ = obj.value;
  CPFCNPJ = Limpar(CPFCNPJ,"0123456789");
  if (CPFCNPJ.length != 14 && CPFCNPJ.length != 11) { return msgErr(obj, msg + " Deve conter 11 ou 14 números"); }
  if (CPFCNPJ.length == 14) {
    if (CNPJdv(CPFCNPJ.substring(0,12)) == CPFCNPJ.substring(12)) {
      return fmtCNPJ(obj);
    } else {
      msgErr(obj, msg + " CNPJ incorreto");
    }
  } else if (CPFCNPJ.length == 11) {
    if (CPFdv(CPFCNPJ.substring(0,9)) == CPFCNPJ.substring(9)) {
      return fmtCPF(obj);
    } else {
      msgErr(obj, msg + " CPF incorreto");
    }
  }
}

// chkCNPJ(this)
function chkCNPJ(obj, msg) {
  if (!msg) msg = "";
  if (!obj || obj.value=="") return;
  var CNPJ = obj.value;
  CNPJ = Limpar(CNPJ,"0123456789");
  if (CNPJ.length != 14) { return msgErr(obj, msg + " Deve conter 14 números"); }
  if (CNPJdv(CNPJ.substring(0,12)) == CNPJ.substring(12)) {
    return fmtCNPJ(obj);
  }
  else {
    msgErr(obj, msg + " CNPJ incorreto");
  }
}     

// fmtCNPJ(this)
function fmtCNPJ(obj) {
  if (!obj || obj.value=="") return;
  var CNPJ = obj.value;
  CNPJ = Limpar(CNPJ,"0123456789");
  if (CNPJ.length != 14) { return ""; }
  var parte1 = CNPJ.substring(0,2);
  var parte2 = CNPJ.substring(2,5);
  var parte3 = CNPJ.substring(5,8);
  var parte4 = CNPJ.substring(8,12);
  var parte5 = CNPJ.substring(12,14);
  obj.value = parte1 + "." + parte2 + "." + parte3 + "/" + parte4 + "-" + parte5;
}

// chkCPF(this)
function chkCPF(obj, msg) {
  if (!msg) msg = "";
  if (!obj || obj.value=="") return;
  var CPF = obj.value;
  CPF = Limpar(CPF,"0123456789");
  if (CPF.length != 11) { return msgErr(obj, msg + " Deve conter 11 números") }
  if (CPFdv(CPF.substring(0,9)) == CPF.substring(9)) {
    return fmtCPF(obj);
  }
  else {
    msgErr(obj, msg + " CPF incorreto");
  }
}

// fmtCPF(this)
function fmtCPF(obj) {
  if (!obj || obj.value=="") return;
  var CPF = obj.value;
  CPF = Limpar(CPF,"0123456789");
  if (CPF.length != 11) { return ""; }
  var parte1 = CPF.substring(0,3);
  var parte2 = CPF.substring(3,6);
  var parte3 = CPF.substring(6,9);
  var parte4 = CPF.substring(9,11);
  obj.value = parte1 + "." + parte2 + "." + parte3 + "-" + parte4;
}

// chkEmail(this)
function chkEmail(obj, msg) {
   if (obj.value=="") return;
   if (!msg) msg = "";
   var dlm=", ",s="";
   var array = obj.value.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi);
   if (array)
      for (var i=0; i<array.length; i++) {
         if (i!=0) s+=dlm;
         s+=array[i];
      }
   if (s=="") return msgErr(obj, msg + " Formato inválido do e-mail");
   return "";
}

// chkTime(this)
function chkTime(obj, msg) {
 var val=obj.value;
 if (val=="") return;
 if (!msg) msg = "";
 val = mTr (val, "h.,", ":::");
 if (Limpar(val, ":0123456789") != val) return msgErr(obj, msg + " Digite somente números");
 if (val.indexOf(":")<0) val = val.substring(0,2) + ":" + val.substring(2,4);
 var H = eval (piece(val, ":", 1) + " + 0");
 var M = eval (piece(val, ":", 2) + " + 0");

 if (H>23) return msgErr(obj,msg+" Hora inválida");
 if (M>59) return msgErr(obj,msg+" Minuto inválido");
 H = "" + H;
 M = "" + M;
 if (H.length==1) H="0" + H;
 if (M.length==0) M="00";
 if (M.length==1) M="0" + M;
 obj.value = FormatarInv("" + H + M, "__:__");
}

function xpOpen(url, target, props) {
   if (target) {
      if (target.toLowerCase()=="_blank") {
         target = Date.parse(new Date())+new Date().getMilliseconds();
      }
   } else target = "_self";
   var frm = document.createElement("FORM");
   frm.action = url;
   frm.target = target;
   frm.method = "post";
   document.body.appendChild(frm);
   var wnd;
   if (target!="")  {
      wnd = window.open('',target,props);
   }
   frm.submit();
   document.body.removeChild(frm);
   return wnd;
}

// verifica se algum campo obrigatório de um form deixou de ser preenchido
// exemplo de INPUT: (deve conter a expressão required="true")
//   <input type="text" required="true" name="texto2">
// parametro: frm = form a ser submetido
//          :  msg = mensagem de erro
// usar em OnSubmit do form.
// chkRequired(this)
function chkRequired(frm, msg){
   if (!msg || msg=="") msg="Campo obrigatório não preenchido";
   for (var i=0; i<frm.elements.length; i++) {   
      if (frm.elements[i].getAttribute("required")=="true") {
         var ok = false;
         if (frm.elements[i].type.toLowerCase()=="radio") {
            for (var j=0; j<frm[frm.elements[i].name].length; j++) {
               if (frm[frm.elements[i].name][j].checked) {
                  ok = true; break
               }
            }
         } else ok = !(frm.elements[i].value=="") 
         if (!ok) {
          alert(msg);
        frm.elements[i].focus();
        return false;
      }
      }
  }
   return true;
}

function autoTab(input,len, e) {
  if (isNaN(parseInt(len, 10))) return;
  var isNN = (navigator.appName.indexOf("Netscape")!=-1);
  var keyCode = (isNN) ? e.which : e.keyCode; 
  var filter = (isNN) ? [0,8,9] : [0,8,9,16,17,18,37,38,39,40,46];
  if (input.value.length >= len && !containsElement(filter,keyCode)) {
    input.value = input.value.slice(0, len);
    nextFocus((getIndex(input)+1) % input.form.length);
  }
}

function mostrar(id) {
  var obj = document.getElementById(id);
  if (obj) {
    if (obj.style.display == "none") {
      obj.style.display = "block";
    } else {
      obj.style.display = "none";
    }
  }
}

function esconder(id) {
  var obj = document.getElementById(id);
  if (obj) {
      obj.style.display = "none";
  }
}

function exibir(id) {
  var obj = document.getElementById(id);
  if (obj) {
      obj.style.display = "inline";
  }
}

function getData(valor) {
  // As datas tem que estar no format dd/MM/yyyy
  var str = new String(valor);
  var t = 0;
  if (valor != "") {
    var dia = str.substring(0,2);
    var mes = str.substring(3,5);
    var ano = str.substr(6);
    mes = parseInt(mes)-1;
    var dt = new Date(ano,mes,dia);
    t = dt.getTime();
  }
  return t;
}

function difDias(data_1, data_2) {
  // As datas tem que estar no format dd/MM/yyyy
  return Math.round((getData(data_1) - getData(data_2))/86400000);
}

function replace(s, t, u) {
  /*
  **  Replace a token in a string
  **    s  string to be processed
  **    t  token to be found and removed
  **    u  token to be inserted
  **  returns new String
  */
  i = s.indexOf(t);
  r = "";
  if (i == -1) return s;
  r += s.substring(0,i) + u;
  if ( i + t.length < s.length)
    r += replace(s.substring(i + t.length, s.length), t, u);
  return r;
}

//para que o numero 33,22 fique 33.22
//transforma 1.234,56 para 1234.56
function numero(num) {
  return replace(replace(num,'.',''),',','.');
}

// "Internal" function to return the decoded value of a cookie
//
function getCookieVal (offset) {
    var endstr = document.cookie.indexOf (";", offset);
    if (endstr == -1)
    endstr = document.cookie.length;
    return unescape(document.cookie.substring(offset, endstr));
}

//
// Function to return the value of the cookie specified by "name".
// name - String object containing the cookie name.
// returns - String object containing the cookie value, or null if
// the cookie does not exist.
//
function getCookie (name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while (i < clen) {
        var j = i + alen;
        if (document.cookie.substring(i, j) == arg)
        return getCookieVal (j);
        i = document.cookie.indexOf(" ", i) + 1;
        if (i == 0) break;
    }
    return null;
}
//
// Function to create or update a cookie.
// name - String object containing the cookie name.
// value - String object containing the cookie value. May contain
// any valid string characters.
// [expires] - Date object containing the expiration data of the cookie. If
// omitted or null, expires the cookie at the end of the current session.
// [path] - String object indicating the path for which the cookie is valid.
// If omitted or null, uses the path of the calling document.
// [domain] - String object indicating the domain for which the cookie is
// valid. If omitted or null, uses the domain of the calling document.
// [secure] - Boolean (true/false) value indicating whether cookie transmission
// requires a secure channel (HTTPS).
//
// The first two parameters are required. The others, if supplied, must
// be passed in the order listed above. To omit an unused optional field,
// use null as a place holder. For example, to call SetCookie using name,
// value and path, you would code:
//
// setCookie ("myCookieName", "myCookieValue", null, "/");
//
// Note that trailing omitted parameters do not require a placeholder.
//
// To set a secure cookie for path "/myPath", that expires after the
// current session, you might code:
//
// setCookie (myCookieVar, cookieValueVar, null, "/myPath", null, true);
//
function setCookie (name,value,expires,path,domain,secure) {
    document.cookie = name + "=" + escape (value) +
    ((expires) ? "; expires=" + expires.toGMTString() : "") +
    ((path) ? "; path=" + path : "") +
    ((domain) ? "; domain=" + domain : "") +
    ((secure) ? "; secure" : "");
}

// Function to delete a cookie. (Sets expiration date to start of epoch)
// name - String object containing the cookie name
// path - String object containing the path of the cookie to delete. This MUST
// be the same as the path used to create the cookie, or null/omitted if
// no path was specified when creating the cookie.
// domain - String object containing the domain of the cookie to delete. This MUST
// be the same as the domain used to create the cookie, or null/omitted if
// no domain was specified when creating the cookie.
//
function deleteCookie (name,path,domain) {
    if (getCookie(name)) {
        document.cookie = name + "=" +
        ((path) ? "; path=" + path : "") +
        ((domain) ? "; domain=" + domain : "") +
        "; expires=Thu, 01-Jan-70 00:00:01 GMT";
    }
}
