package afero.model;

import java.util.*;

public class OrcamentoEmpresaItem {
	
	private int idOrcamentoEmpresaItem = 0;
	private int idOrcamentoEmpresa = 0;
	private int idPlanoConta = 0;
	private double valor = 0;
	private Date dtMov = null;
	private Date dtComp = null;
	private String usuario = "";
	
	
	public OrcamentoEmpresaItem() {
		
		// TODO Auto-generated constructor stub
	}
	
	public OrcamentoEmpresaItem(int idOrcamentoEmpresaItem,
			int idOrcamentoEmpresa, int idPlanoConta, double valor, Date dtMov,
			Date dtComp, String usuario) {
		this.idOrcamentoEmpresaItem = idOrcamentoEmpresaItem;
		this.idOrcamentoEmpresa = idOrcamentoEmpresa;
		this.idPlanoConta = idPlanoConta;
		this.valor = valor;
		this.dtMov = dtMov;
		this.dtComp = dtComp;
		this.usuario = usuario;
	}

	public Date getDtComp() {
		return dtComp;
	}

	public void setDtComp(Date dtComp) {
		this.dtComp = dtComp;
	}

	public int getIdOrcamentoEmpresaItem() {
		return idOrcamentoEmpresaItem;
	}
	public void setIdOrcamentoEmpresaItem(int idOrcamentoEmpresaItem) {
		this.idOrcamentoEmpresaItem = idOrcamentoEmpresaItem;
	}
	public int getIdOrcamentoEmpresa() {
		return idOrcamentoEmpresa;
	}
	public void setIdOrcamentoEmpresa(int idOrcamentoEmpresa) {
		this.idOrcamentoEmpresa = idOrcamentoEmpresa;
	}
	public int getIdPlanoConta() {
		return idPlanoConta;
	}
	public void setIdPlanoConta(int idPlanoConta) {
		this.idPlanoConta = idPlanoConta;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public Date getDtMov() {
		return dtMov;
	}
	public void setDtMov(Date dtMov) {
		this.dtMov = dtMov;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	

}
