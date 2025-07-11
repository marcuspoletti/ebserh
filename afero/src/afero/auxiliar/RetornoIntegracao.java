package afero.auxiliar;

public class RetornoIntegracao {
	
	 private Integer idRetornoIntegracao;
	 private String status;
	 private String status_sefaz;
	 private String mensagem_sefaz;
	 private String chave_nfe;
	 private String numero;
	 private String serie;
	 private String caminho_xml_nota_fiscal;
	 private String caminho_danfe;
	 private String requisicao_nota_fiscal;
	 private String protocolo_nota_fiscal;
	 private String versao;
	 private String ambiente;
	 private String versao_aplicativo;
	 private String data_recebimento;
	 private String numero_protocolo;
	 private String digest_value;
	 private String statusValue;
	 private String chave_nfe_value;	 
	 private String motivo;
	 private String qrcode_url;
	 private String url_consulta_nf;
	 private String idPedidoSaida;
	 
	
	public RetornoIntegracao(String status, String status_sefaz,
			String mensagem_sefaz, String chave_nfe, String numero,
			String serie, String caminho_xml_nota_fiscal, String caminho_danfe,
			String requisicao_nota_fiscal, String protocolo_nota_fiscal,
			String versao, String ambiente, String versao_aplicativo,
			String data_recebimento, String numero_protocolo,
			String digest_value, String statusValue, String chave_nfe_value,
			String motivo, String qrcode_url, String url_consulta_nf,
			String idPedidoSaida) {
		super();
		this.status = status;
		this.status_sefaz = status_sefaz;
		this.mensagem_sefaz = mensagem_sefaz;
		this.chave_nfe = chave_nfe;
		this.numero = numero;
		this.serie = serie;
		this.caminho_xml_nota_fiscal = caminho_xml_nota_fiscal;
		this.caminho_danfe = caminho_danfe;
		this.requisicao_nota_fiscal = requisicao_nota_fiscal;
		this.protocolo_nota_fiscal = protocolo_nota_fiscal;
		this.versao = versao;
		this.ambiente = ambiente;
		this.versao_aplicativo = versao_aplicativo;
		this.data_recebimento = data_recebimento;
		this.numero_protocolo = numero_protocolo;
		this.digest_value = digest_value;
		this.statusValue = statusValue;
		this.chave_nfe_value = chave_nfe_value;
		this.motivo = motivo;
		this.qrcode_url = qrcode_url;
		this.url_consulta_nf = url_consulta_nf;
		this.idPedidoSaida = idPedidoSaida;
	}
	
	
	
	
	public RetornoIntegracao(Integer idRetornoIntegracao, String status,
			String status_sefaz, String mensagem_sefaz, String chave_nfe,
			String numero, String serie, String caminho_xml_nota_fiscal,
			String caminho_danfe, String requisicao_nota_fiscal,
			String protocolo_nota_fiscal, String versao, String ambiente,
			String versao_aplicativo, String data_recebimento,
			String numero_protocolo, String digest_value, String statusValue,
			String chave_nfe_value, String motivo, String qrcode_url,
			String url_consulta_nf, String idPedidoSaida) {
		super();
		this.idRetornoIntegracao = idRetornoIntegracao;
		this.status = status;
		this.status_sefaz = status_sefaz;
		this.mensagem_sefaz = mensagem_sefaz;
		this.chave_nfe = chave_nfe;
		this.numero = numero;
		this.serie = serie;
		this.caminho_xml_nota_fiscal = caminho_xml_nota_fiscal;
		this.caminho_danfe = caminho_danfe;
		this.requisicao_nota_fiscal = requisicao_nota_fiscal;
		this.protocolo_nota_fiscal = protocolo_nota_fiscal;
		this.versao = versao;
		this.ambiente = ambiente;
		this.versao_aplicativo = versao_aplicativo;
		this.data_recebimento = data_recebimento;
		this.numero_protocolo = numero_protocolo;
		this.digest_value = digest_value;
		this.statusValue = statusValue;
		this.chave_nfe_value = chave_nfe_value;
		this.motivo = motivo;
		this.qrcode_url = qrcode_url;
		this.url_consulta_nf = url_consulta_nf;
		this.idPedidoSaida = idPedidoSaida;
	}




	public RetornoIntegracao() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public Integer getIdRetornoIntegracao() {
		return idRetornoIntegracao;
	}




	public void setIdRetornoIntegracao(Integer idRetornoIntegracao) {
		this.idRetornoIntegracao = idRetornoIntegracao;
	}




	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatus_sefaz() {
		return status_sefaz;
	}
	public void setStatus_sefaz(String status_sefaz) {
		this.status_sefaz = status_sefaz;
	}
	public String getMensagem_sefaz() {
		return mensagem_sefaz;
	}
	public void setMensagem_sefaz(String mensagem_sefaz) {
		this.mensagem_sefaz = mensagem_sefaz;
	}
	public String getChave_nfe() {
		return chave_nfe;
	}
	public void setChave_nfe(String chave_nfe) {
		this.chave_nfe = chave_nfe;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getSerie() {
		return serie;
	}
	public void setSerie(String serie) {
		this.serie = serie;
	}
	public String getCaminho_xml_nota_fiscal() {
		return caminho_xml_nota_fiscal;
	}
	public void setCaminho_xml_nota_fiscal(String caminho_xml_nota_fiscal) {
		this.caminho_xml_nota_fiscal = caminho_xml_nota_fiscal;
	}
	public String getCaminho_danfe() {
		return caminho_danfe;
	}
	public void setCaminho_danfe(String caminho_danfe) {
		this.caminho_danfe = caminho_danfe;
	}
	public String getRequisicao_nota_fiscal() {
		return requisicao_nota_fiscal;
	}
	public void setRequisicao_nota_fiscal(String requisicao_nota_fiscal) {
		this.requisicao_nota_fiscal = requisicao_nota_fiscal;
	}
	public String getProtocolo_nota_fiscal() {
		return protocolo_nota_fiscal;
	}
	public void setProtocolo_nota_fiscal(String protocolo_nota_fiscal) {
		this.protocolo_nota_fiscal = protocolo_nota_fiscal;
	}
	public String getVersao() {
		return versao;
	}
	public void setVersao(String versao) {
		this.versao = versao;
	}
	public String getAmbiente() {
		return ambiente;
	}
	public void setAmbiente(String ambiente) {
		this.ambiente = ambiente;
	}
	public String getVersao_aplicativo() {
		return versao_aplicativo;
	}
	public void setVersao_aplicativo(String versao_aplicativo) {
		this.versao_aplicativo = versao_aplicativo;
	}
	public String getData_recebimento() {
		return data_recebimento;
	}
	public void setData_recebimento(String data_recebimento) {
		this.data_recebimento = data_recebimento;
	}
	public String getNumero_protocolo() {
		return numero_protocolo;
	}
	public void setNumero_protocolo(String numero_protocolo) {
		this.numero_protocolo = numero_protocolo;
	}
	public String getDigest_value() {
		return digest_value;
	}
	public void setDigest_value(String digest_value) {
		this.digest_value = digest_value;
	}
	public String getStatusValue() {
		return statusValue;
	}
	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}
	public String getChave_nfe_value() {
		return chave_nfe_value;
	}
	public void setChave_nfe_value(String chave_nfe_value) {
		this.chave_nfe_value = chave_nfe_value;
	}
	public String getMotivo() {
		return motivo;
	}
	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}
	public String getQrcode_url() {
		return qrcode_url;
	}
	public void setQrcode_url(String qrcode_url) {
		this.qrcode_url = qrcode_url;
	}
	public String getUrl_consulta_nf() {
		return url_consulta_nf;
	}
	public void setUrl_consulta_nf(String url_consulta_nf) {
		this.url_consulta_nf = url_consulta_nf;
	}
	public String getIdPedidoSaida() {
		return idPedidoSaida;
	}
	public void setIdPedidoSaida(String idPedidoSaida) {
		this.idPedidoSaida = idPedidoSaida;
	}

	 
	 
	 
	 
	 
	 
	 
	 
}
