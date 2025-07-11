package afero.model;


import java.util.Date;
public class LogUsuario {
	
	private Integer idLogUsuario;
	private Integer idLoja;
	private String usuario;
	private Date dtAcesso;
	private Date dtSaida;
	
	
	
	
	public LogUsuario(Integer idLogUsuario, Integer idLoja, String usuario,
			Date dtAcesso, Date dtSaida) {
		this.idLogUsuario = idLogUsuario;
		this.idLoja = idLoja;
		this.usuario = usuario;
		this.dtAcesso = dtAcesso;
		this.dtSaida = dtSaida;
	}
	public LogUsuario(Integer idLogUsuario, String usuario, Date dtAcesso,
			Date dtSaida) {
		
		this.idLogUsuario = idLogUsuario;
		this.usuario = usuario;
		this.dtAcesso = dtAcesso;
		this.dtSaida = dtSaida;
	}
	public LogUsuario() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public Integer getIdLoja() {
		return idLoja;
	}
	public void setIdLoja(Integer idLoja) {
		this.idLoja = idLoja;
	}
	public Integer getIdLogUsuario() {
		return idLogUsuario;
	}
	public void setIdLogUsuario(Integer idLogUsuario) {
		this.idLogUsuario = idLogUsuario;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public Date getDtAcesso() {
		return dtAcesso;
	}
	public void setDtAcesso(Date dtAcesso) {
		this.dtAcesso = dtAcesso;
	}
	public Date getDtSaida() {
		return dtSaida;
	}
	public void setDtSaida(Date dtSaida) {
		this.dtSaida = dtSaida;
	}
	
}
