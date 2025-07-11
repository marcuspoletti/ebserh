package afero.model;

public class Crt {
	
	private Integer idCrt;
	private Integer codigo;
	private String descricao;
	
	
	
	public Crt() {
		
		// TODO Auto-generated constructor stub
	}



	public Crt(Integer idCrt, Integer codigo, String descricao) {
		
		this.idCrt = idCrt;
		this.codigo = codigo;
		this.descricao = descricao;
	}



	public Integer getIdCrt() {
		return idCrt;
	}



	public void setIdCrt(Integer idCrt) {
		this.idCrt = idCrt;
	}



	public Integer getCodigo() {
		return codigo;
	}



	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}



	public String getDescricao() {
		return descricao;
	}



	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	
	
	

}
