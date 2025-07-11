package afero.model;

import java.util.Date;

public class Aniversariantes {
	private int cdEntidade     = 0;
	private String nomeCliente  = "";
	private Date dataNascimento;
	private String email = "";
	


	public Aniversariantes(int cdEntidade, String nomeCliente,
			Date dataNascimento, String email) {
		
		this.cdEntidade = cdEntidade;
		this.nomeCliente = nomeCliente;
		this.dataNascimento = dataNascimento;
		this.email = email;
	}



	public Aniversariantes() {
		
	}



	public int getCdEntidade() {
		return cdEntidade;
	}



	public void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}



	public String getNomeCliente() {
		return nomeCliente;
	}



	public void setNomeCliente(String nomeCliente) {
		this.nomeCliente = nomeCliente;
	}



	public Date getDataNascimento() {
		return dataNascimento;
	}



	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
}
