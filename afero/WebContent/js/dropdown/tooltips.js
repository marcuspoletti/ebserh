M_ToolTipDelay=700    // Milliseconds after menu has been displayed before showing tooltip
M_maxWidth=0          // Sets the maximum width, set to 0 for 100%

with(M_toolTipStyle=new mm_style()){
    offbgcolor = "#ffffa1";
      offcolor = "#000000";
   bordercolor = "#999999";
   borderstyle = "solid";
       padding = 1;
   borderwidth = 1;
      fontsize = "10px";
     fontstyle = "normal";
    fontfamily = "tahoma, verdana";   
    overfilter = "Fade(duration=0.2);Shadow(color='#777777', Direction=135, Strength=5)"
}
with(new menuname("M_toolTips"))
{
	top="offset=22";
	left="offset=10";
	style=M_toolTipStyle;
	aI("text=;");
}

drawMenus()



function buildTips(_ttext)                // Function for showing Tooltips
{
	_Tmnu=getMenuByName("M_toolTips")     // Get a reference to the tooltips menu
	_Tgm=gmobj("menu"+_Tmnu)              // Get the object reference to the tooltips menu
	if(!ns4&&(!_m[_Tmnu][23]&&!_startM))  // If the menu hasn't been built yet, build it
	{
		_m[_Tmnu][23]=_Tmnu               // Set the menu built flag
		BDMenu(_Tmnu)                     // Build the menu, this only happens once, or at least should do.
	}

	_el=_m[_Tmnu][0][0]                   // Set the menu element reference for building the menu items
	_mi[_el][1]=_ttext                    // Set the menu items text. This is the text that will be displayed
	if(ns4)
	{
		dte="<table width=1 cellpadding=0 cellspacing=0 border=0>"+drawItem(_el)+"</table>";
		with(_Tgm.document){open();write(dte);close()}
		_brd=gmobj("bord"+_Tmnu)
		_brdwid=(_m[_Tmnu][6].borderwidth*2)
		_brd.clip.width=_Tgm.clip.width+_brdwid
		_brd.clip.height=_Tgm.clip.height+_brdwid
		_brd.bgColor=_m[_Tmnu][6].bordercolor
		
	}
	else
	{
		_Tgm.innerHTML=_drawMenu(_Tmnu)   // change the menu item for browsers other than Netscape 4
	}
		
	_ttgm=gmobj("el"+_m[_Tmnu][0][0])
	_gp=gpos(_Tgm)
	if(M_maxWidth&&_gp[3]>M_maxWidth)
	{
	//	spos(_ttgm,_n,_n,_n,M_maxWidth);
	}
	
	popup("M_toolTips",1);                // display the menu based on MouseX and MouseY coordinates
	if(ns4)
	{
		_brd.zIndex=_zi+1
		_zi++
		_Tgm.zIndex=_zi+1
	}
}

function showtip(_ttext)                  // This function that sets the timer for showing the tooltip
{
	$CtI(_Mtip);                          // Clear the ToolTop timer
	_Mtip=null                            // Need to set the timer to null for Konquerers sake.
	if(!op5&&!op6)                        // Don't bother if Opera 5 or Opera6, the browsers do not support dynamic change of text
	_Mtip=setTimeout("buildTips('"+_ttext+"',1)",_menuOpenDelay+M_ToolTipDelay) // Set the tooltip timer
}

