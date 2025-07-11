package afero.model;

public class FormaPagto {
	private int cdFormaPagto = 0;
	private String dsFormaPagto = "";
	private String status = "";
	public int getCdFormaPagto() {
		return cdFormaPagto;
	}
	public void setCdFormaPagto(int cdFormaPagto) {
		this.cdFormaPagto = cdFormaPagto;
	}
	public String getDsFormaPagto() {
		return dsFormaPagto;
	}
	public void setDsFormaPagto(String dsFormaPagto) {
		this.dsFormaPagto = dsFormaPagto;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public FormaPagto(int cdFormaPagto, String dsFormaPagto, String status) {
		this.cdFormaPagto = cdFormaPagto;
		this.dsFormaPagto = dsFormaPagto;
		this.status = status;
	}
	public FormaPagto(){}

}
