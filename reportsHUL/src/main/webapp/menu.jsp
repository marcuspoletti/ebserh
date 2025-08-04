
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="dist/img/logoLivro.png" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
        <!-- <p>UsuÃ¡rio(a) <?=$nome[0]?></p> -->
          <p>Usuário</p>
          <!-- Status -->
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>

      <!-- search form (Optional) -->
      <form action="#" method="get" class="sidebar-form">
      </form>
    
      
      <ul class="sidebar-menu">
        <li class="header">MENU</li>
        <!-- Optionally, you can add icons to the links -->
        <li><a href="http://acesso.hul-ufs.ebserh/" target="_blank"><i class="glyphicon glyphicon-hdd"></i> <span>Acesso HUL</span></a></li>
        
        <li class="treeview">
            <a href="#">
                <i class="glyphicon glyphicon-menu-hamburger"></i> <span>Reports</span>
                <i class="fa fa-angle-left pull-right"></i>
            </a>
            <ul class="treeview-menu">	
            	<li><a href="extratoPaciente.jsp"><i class="glyphicon glyphicon-hdd"></i> <span>Extrato do Paciente</span></a></li> 
        		<li><a href="atendimentoAmbulatorial.jsp"><i class="glyphicon glyphicon-hdd"></i> <span>Atendimentos Ambulatoriais</span></a></li>
        		<li><a href="historicoPreco.jsp"><i class="glyphicon glyphicon-hdd"></i> <span>Historico de Preço</span></a></li>
        		<li><a href="movimentacaoPDVTipo.jsp"><i class="glyphicon glyphicon-hdd"></i> <span>Vendas Por Tipo</span></a></li>
            </ul>
        </li>
        
       
      </ul>
            <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>