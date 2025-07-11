package afero.model;

public class TipoColaborador {
	
	private int idTipoColaborador;
	private String dsColaborador;
	private String status;
	
	public TipoColaborador(){
		
	}
	
	public TipoColaborador(int idTipoColaborador, String dsColaborador, String status){
		this.idTipoColaborador = idTipoColaborador;
		this.dsColaborador     = dsColaborador;
		this.status            = status;
	}
	public int getIdTipoColaborador() {
		return idTipoColaborador;
	}
	public void setIdTipoColaborador(int idTipoColaborador) {
		this.idTipoColaborador = idTipoColaborador;
	}
	public String getDsColaborador() {
		return dsColaborador;
	}
	public void setDsColaborador(String dsColaborador) {
		this.dsColaborador = dsColaborador;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	

}
