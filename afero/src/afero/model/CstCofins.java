package afero.model;

public class CstCofins {
	
	private int cdCstCofins = 0;
	private String dsCstCofins = "";
	
	
	public CstCofins(int cdCstCofins, String dsCstCofins) {
		
		this.cdCstCofins = cdCstCofins;
		this.dsCstCofins = dsCstCofins;
	}
	public CstCofins() {
		
	}
	public int getCdCstCofins() {
		return cdCstCofins;
	}
	public void setCdCstCofins(int cdCstCofins) {
		this.cdCstCofins = cdCstCofins;
	}
	public String getDsCstCofins() {
		return dsCstCofins;
	}
	public void setDsCstCofins(String dsCstCofins) {
		this.dsCstCofins = dsCstCofins;
	}
	

}
