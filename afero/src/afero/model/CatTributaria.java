package afero.model;

import java.util.Date;
public class CatTributaria {
	
	private int idCatTributaria;
	private String dsCatTributaria;
	private int cdCstIpi;
	private float pIpi;
	private String classeEnquadramento;
	private String codigoEnquadramento;
	private String cnpjProdutor;
	private int cdCstPis;
	private float pPis;
	private int cdCstCofins;
	private float pCofins;
	private String status;
	private Date dtMod;
	private String usuario;
	
	
	public CatTributaria(int idCatTributaria, String dsCatTributaria,
			int cdCstIpi, float pIpi, String classeEnquadramento,
			String codigoEnquadramento, String cnpjProdutor, int cdCstPis,
			float pPis, int cdCstCofins, float pCofins, String status,
			Date dtMod, String usuario) {
		
		this.idCatTributaria = idCatTributaria;
		this.dsCatTributaria = dsCatTributaria;
		this.cdCstIpi = cdCstIpi;
		this.pIpi = pIpi;
		this.classeEnquadramento = classeEnquadramento;
		this.codigoEnquadramento = codigoEnquadramento;
		this.cnpjProdutor = cnpjProdutor;
		this.cdCstPis = cdCstPis;
		this.pPis = pPis;
		this.cdCstCofins = cdCstCofins;
		this.pCofins = pCofins;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}


	public CatTributaria() {
		
		// TODO Auto-generated constructor stub
	}


	public int getIdCatTributaria() {
		return idCatTributaria;
	}


	public void setIdCatTributaria(int idCatTributaria) {
		this.idCatTributaria = idCatTributaria;
	}


	public String getDsCatTributaria() {
		return dsCatTributaria;
	}


	public void setDsCatTributaria(String dsCatTributaria) {
		this.dsCatTributaria = dsCatTributaria;
	}


	public int getCdCstIpi() {
		return cdCstIpi;
	}


	public void setCdCstIpi(int cdCstIpi) {
		this.cdCstIpi = cdCstIpi;
	}


	public float getpIpi() {
		return pIpi;
	}


	public void setpIpi(float pIpi) {
		this.pIpi = pIpi;
	}


	public String getClasseEnquadramento() {
		return classeEnquadramento;
	}


	public void setClasseEnquadramento(String classeEnquadramento) {
		this.classeEnquadramento = classeEnquadramento;
	}


	public String getCodigoEnquadramento() {
		return codigoEnquadramento;
	}


	public void setCodigoEnquadramento(String codigoEnquadramento) {
		this.codigoEnquadramento = codigoEnquadramento;
	}


	public String getCnpjProdutor() {
		return cnpjProdutor;
	}


	public void setCnpjProdutor(String cnpjProdutor) {
		this.cnpjProdutor = cnpjProdutor;
	}


	public int getCdCstPis() {
		return cdCstPis;
	}


	public void setCdCstPis(int cdCstPis) {
		this.cdCstPis = cdCstPis;
	}


	public float getpPis() {
		return pPis;
	}


	public void setpPis(float pPis) {
		this.pPis = pPis;
	}


	public int getCdCstCofins() {
		return cdCstCofins;
	}


	public void setCdCstCofins(int cdCstCofins) {
		this.cdCstCofins = cdCstCofins;
	}


	public float getpCofins() {
		return pCofins;
	}


	public void setpCofins(float pCofins) {
		this.pCofins = pCofins;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public Date getDtMod() {
		return dtMod;
	}


	public void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}


	public String getUsuario() {
		return usuario;
	}


	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	
	
	
	
	
	

}
