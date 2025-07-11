package afero.integracao.xprocess;

public class NfeLote {
	
	private String idNfe;
	private String tpamb;
	private String veraplic;
	private String cstat;
	private String xmotivo;
	private String cuf;
	private String nrec;
	private String dhrecbto;
	private String tmed;
	private String in_status;
	private String nm_usuario;
	private String dt_registro;
	private String ds_xml;
	private String ds_xml_recebido;
	
	
	
	public NfeLote(String idNfe, String tpamb, String veraplic, String cstat,
			String xmotivo, String cuf, String nrec, String dhrecbto,
			String tmed, String in_status, String nm_usuario,
			String dt_registro, String ds_xml, String ds_xml_recebido) {
		super();
		this.idNfe = idNfe;
		this.tpamb = tpamb;
		this.veraplic = veraplic;
		this.cstat = cstat;
		this.xmotivo = xmotivo;
		this.cuf = cuf;
		this.nrec = nrec;
		this.dhrecbto = dhrecbto;
		this.tmed = tmed;
		this.in_status = in_status;
		this.nm_usuario = nm_usuario;
		this.dt_registro = dt_registro;
		this.ds_xml = ds_xml;
		this.ds_xml_recebido = ds_xml_recebido;
	}
	public NfeLote() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public String getIdNfe() {
		return idNfe;
	}
	public void setIdNfe(String idNfe) {
		this.idNfe = idNfe;
	}
	public String getTpamb() {
		return tpamb;
	}
	public void setTpamb(String tpamb) {
		this.tpamb = tpamb;
	}
	public String getVeraplic() {
		return veraplic;
	}
	public void setVeraplic(String veraplic) {
		this.veraplic = veraplic;
	}
	public String getCstat() {
		return cstat;
	}
	public void setCstat(String cstat) {
		this.cstat = cstat;
	}
	public String getXmotivo() {
		return xmotivo;
	}
	public void setXmotivo(String xmotivo) {
		this.xmotivo = xmotivo;
	}
	public String getCuf() {
		return cuf;
	}
	public void setCuf(String cuf) {
		this.cuf = cuf;
	}
	public String getNrec() {
		return nrec;
	}
	public void setNrec(String nrec) {
		this.nrec = nrec;
	}
	public String getDhrecbto() {
		return dhrecbto;
	}
	public void setDhrecbto(String dhrecbto) {
		this.dhrecbto = dhrecbto;
	}
	public String getTmed() {
		return tmed;
	}
	public void setTmed(String tmed) {
		this.tmed = tmed;
	}
	public String getIn_status() {
		return in_status;
	}
	public void setIn_status(String in_status) {
		this.in_status = in_status;
	}
	public String getNm_usuario() {
		return nm_usuario;
	}
	public void setNm_usuario(String nm_usuario) {
		this.nm_usuario = nm_usuario;
	}
	public String getDt_registro() {
		return dt_registro;
	}
	public void setDt_registro(String dt_registro) {
		this.dt_registro = dt_registro;
	}
	public String getDs_xml() {
		return ds_xml;
	}
	public void setDs_xml(String ds_xml) {
		this.ds_xml = ds_xml;
	}
	public String getDs_xml_recebido() {
		return ds_xml_recebido;
	}
	public void setDs_xml_recebido(String ds_xml_recebido) {
		this.ds_xml_recebido = ds_xml_recebido;
	}

}
