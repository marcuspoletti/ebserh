package afero.model;

public class RelacaoUnidade {
	
	
	private int idRelacaoUnidade;
	private int idUnidadeDe;
	private int idUnidadePara;
	private float fatorConversao;
	private UnidadeRelacaoUnidade unidRelacaoUnid = null; 
	
	

	public RelacaoUnidade(int idRelacaoUnidade, int idUnidadeDe,
			int idUnidadePara, float fatorConversao) {
	
		this.idRelacaoUnidade = idRelacaoUnidade;
		this.idUnidadeDe = idUnidadeDe;
		this.idUnidadePara = idUnidadePara;
		this.fatorConversao = fatorConversao;
	}

	public RelacaoUnidade(){
		
	}

	

	public int getIdUnidadeDe() {
		return idUnidadeDe;
	}
	public void setIdUnidadeDe(int idUnidadeDe) {
		this.idUnidadeDe = idUnidadeDe;
	}
	public int getIdUnidadePara() {
		return idUnidadePara;
	}
	public void setIdUnidadePara(int idUnidadePara) {
		this.idUnidadePara = idUnidadePara;
	}
	public float getFatorConversao() {
		return fatorConversao;
	}
	public void setFatorConversao(float fatorConversao) {
		this.fatorConversao = fatorConversao;
	}

	public int getIdRelacaoUnidade() {
		return idRelacaoUnidade;
	}

	public void setIdRelacaoUnidade(int idRelacaoUnidade) {
		this.idRelacaoUnidade = idRelacaoUnidade;
	}
	
	public void setUnidadeRelacaoUnidade(UnidadeRelacaoUnidade unidRelacaoUnid){
		this.unidRelacaoUnid = unidRelacaoUnid;
		
	}
	
	public UnidadeRelacaoUnidade getUnidadeRelacaoUnidade(){
		return this.unidRelacaoUnid;
	}
	

}
