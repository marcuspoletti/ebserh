package afero.test;

public class Autor {
	
	
	private String nomeAutor = "";
	private String Isbn = "";
	
	
	
	
	public Autor() {
	
	}
	public Autor(String nomeAutor, String isbn) {
		
		this.nomeAutor = nomeAutor;
		Isbn = isbn;
	}
	public String getNomeAutor() {
		return nomeAutor;
	}
	public void setNomeAutor(String nomeAutor) {
		this.nomeAutor = nomeAutor;
	}
	public String getIsbn() {
		return Isbn;
	}
	public void setIsbn(String isbn) {
		Isbn = isbn;
	}
		
		

}
