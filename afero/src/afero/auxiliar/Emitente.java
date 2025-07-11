package afero.auxiliar;

public class Emitente {
	
	private String emit = null;
	private String CNPJ;
	private String xNome;
	private String xFant;	
	private EnderEmit ender;
	private String IE;	
	private String IEST;	
	private String IM;	
	private String CNAE;
	private String CRT;
	
	
	public Emitente(String cNPJ, String xNome, String xFant, EnderEmit ender,
			String iE, String iEST, String iM, String cNAE, String cRT) {
		
		CNPJ = cNPJ;
		this.xNome = xNome;
		this.xFant = xFant;
		this.ender = ender;
		IE = iE;
		IEST = iEST;
		IM = iM;
		CNAE = cNAE;
		CRT = cRT;
	}



	public Emitente(String emit, String cNPJ, String xNome, String xFant,
			EnderEmit ender, String iE, String iEST, String iM, String cNAE,
			String cRT) {
		super();
		this.emit = emit;
		CNPJ = cNPJ;
		this.xNome = xNome;
		this.xFant = xFant;
		this.ender = ender;
		IE = iE;
		IEST = iEST;
		IM = iM;
		CNAE = cNAE;
		CRT = cRT;
	}



	public String getEmit() {
		return emit;
	}



	public void setAvulsa(String emit) {
		this.emit = emit;
	}



	public Emitente() {
		
	}


	
	public String getCNPJ() {
		return CNPJ;
	}


	public void setCNPJ(String cNPJ) {
		CNPJ = cNPJ;
	}


	public String getxNome() {
		return xNome;
	}


	public void setxNome(String xNome) {
		this.xNome = xNome;
	}


	public String getxFant() {
		return xFant;
	}


	public void setxFant(String xFant) {
		this.xFant = xFant;
	}



	public String getIE() {
		return IE;
	}


	public void setIE(String iE) {
		IE = iE;
	}


	public String getIEST() {
		return IEST;
	}


	public void setIEST(String iEST) {
		IEST = iEST;
	}


	public String getIM() {
		return IM;
	}


	public void setIM(String iM) {
		IM = iM;
	}


	public String getCNAE() {
		return CNAE;
	}


	public void setCNAE(String cNAE) {
		CNAE = cNAE;
	}


	public String getCRT() {
		return CRT;
	}


	public void setCRT(String cRT) {
		CRT = cRT;
	}



	public EnderEmit getEnder() {
		return ender;
	}



	public void setEnder(EnderEmit ender) {
		this.ender = ender;
	}
	
	
	
	

}
