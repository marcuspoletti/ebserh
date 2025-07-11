package afero.model;

public class Mesa {
	
	
	private int idMesa;
	private String dsMesa;
	private String status;
	
	
	
	public Mesa() {
		
	}



	public Mesa(int idMesa, String dsMesa, String status) {
		
		this.idMesa = idMesa;
		this.dsMesa = dsMesa;
		this.status = status;
	}



	public int getIdMesa() {
		return idMesa;
	}



	public void setIdMesa(int idMesa) {
		this.idMesa = idMesa;
	}



	public String getDsMesa() {
		return dsMesa;
	}



	public void setDsMesa(String dsMesa) {
		this.dsMesa = dsMesa;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getHtmlMesa(String alt, String imagem, String dscMesa, String user, String duracao){
		return "<tr> "+
        "<td class='grid' width='10' height='10'><center><img width='50' height='50' border='0' alt='"+alt+"'src='../../WebContent/images/"+imagem+"></center> "+
        "<br><center>"+dscMesa+ " /"+user+ "  Dur:"+duracao+"</center></td> "+
        "</tr>";
	}
	
	

}
