/*
Milonic DHTML Menu - JavaScript Website Navigation System.
Version 5.0 - Context Menu Module
Copyright 2003 (c) Milonic Solutions Limited. All Rights Reserved.
This is a commercial application, please visit http://www.milonic.com/ for more information about its use.
*/

contextDisabled=false;
contextMenu="contextMenu";

function rclick(e){
	if(contextDisabled)
	{
		_d.oncontextmenu=null
		return true;
	}
	if(_d.all)ev=event.button; else ev=e.which
	if(ev==2||ev==3){
		_gm=getMenuByName(contextMenu)
		if(_gm!=null)popup(contextMenu,1)
		return false;
	}
	else{
		if(ev==1)closeAllMenus();
	}
	return true;
}

if(ns4){
	_d.captureEvents(Event.MOUSEDOWN);
	_d.onmousedown=rclick;
}
else{
	_d.onmouseup=rclick
	_d.oncontextmenu=new Function("return false");
}