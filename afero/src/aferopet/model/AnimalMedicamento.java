package aferopet.model;
import java.util.Date;

public class AnimalMedicamento {
	
	private int idAnimalMedicamento;
	private int idAnimalFicha;
	private int idMedicamento;
	private String nrLote;
	private Date dtFab;
	private Date dtVal;
	private Date dtMod;
	private String Usuario;
	
	public AnimalMedicamento() {
	}

	public AnimalMedicamento(int idAnimalMedicamento, int idAnimalFicha,
			int idMedicamento, String nrLote, Date dtFab, Date dtVal,
			Date dtMod, String usuario) {
		super();
		this.idAnimalMedicamento = idAnimalMedicamento;
		this.idAnimalFicha = idAnimalFicha;
		this.idMedicamento = idMedicamento;
		this.nrLote = nrLote;
		this.dtFab = dtFab;
		this.dtVal = dtVal;
		this.dtMod = dtMod;
		Usuario = usuario;
	}

	public int getIdAnimalMedicamento() {
		return idAnimalMedicamento;
	}

	public void setIdAnimalMedicamento(int idAnimalMedicamento) {
		this.idAnimalMedicamento = idAnimalMedicamento;
	}

	public int getIdAnimalFicha() {
		return idAnimalFicha;
	}

	public void setIdAnimalFicha(int idAnimalFicha) {
		this.idAnimalFicha = idAnimalFicha;
	}

	public int getIdMedicamento() {
		return idMedicamento;
	}

	public void setIdMedicamento(int idMedicamento) {
		this.idMedicamento = idMedicamento;
	}

	public String getNrLote() {
		return nrLote;
	}

	public void setNrLote(String nrLote) {
		this.nrLote = nrLote;
	}

	public Date getDtFab() {
		return dtFab;
	}

	public void setDtFab(Date dtFab) {
		this.dtFab = dtFab;
	}

	public Date getDtVal() {
		return dtVal;
	}

	public void setDtVal(Date dtVal) {
		this.dtVal = dtVal;
	}

	public Date getDtMod() {
		return dtMod;
	}

	public void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}

	public String getUsuario() {
		return Usuario;
	}

	public void setUsuario(String usuario) {
		Usuario = usuario;
	}

}
