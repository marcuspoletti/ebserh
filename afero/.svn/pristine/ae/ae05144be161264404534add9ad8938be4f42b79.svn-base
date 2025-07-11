
function stAba(menu,conteudo)
{
	this.menu = menu;
	this.conteudo = conteudo;
}

var arAbas = new Array();

function DefinirAbas(tamanho)
{
	for (i=0;i<tamanho;i++)
	{
	arAbas[i] = new stAba('td_aba'+(i+1),'div_aba'+(i+1));
	}
}

function AlternarAbas(td,div,tamanho)
{
	menu = 'td_aba'+td;
	conteudo = 'div_aba'+div;
	for (i=0;i<tamanho;i++)
	{
		m = document.getElementById(arAbas[i].menu);
		m.className = 'abas-menu';
		c = document.getElementById(arAbas[i].conteudo)
		c.style.display = 'none';
	}
	m = document.getElementById(menu)
	m.className = 'abas-menu-sel';
	c = document.getElementById(conteudo)
	c.style.display = '';
}
