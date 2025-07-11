package afero.model;

public class CstIcms {
	
	private int cdCstIcms = 0;
	private String dsCstIcms = "";
	
	
	
	public CstIcms() {
		
	}
	public CstIcms(int cdCstIcms, String dsCstIcms) {
		
		this.cdCstIcms = cdCstIcms;
		this.dsCstIcms = dsCstIcms;
	}
	public int getCdCstIcms() {
		return cdCstIcms;
	}
	public void setCdCstIcms(int cdCstIcms) {
		this.cdCstIcms = cdCstIcms;
	}
	public String getDsCstIcms() {
		return dsCstIcms;
	}
	public void setDsCstIcms(String dsCstIcms) {
		this.dsCstIcms = dsCstIcms;
	}
	
	

}
