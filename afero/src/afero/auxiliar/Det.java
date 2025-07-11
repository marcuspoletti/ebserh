package afero.auxiliar;

import afero.auxiliar.Produtos;
import java.util.List;

public class Det {
	
	List<Produtos>  det= null;
	List<Integer> nItem = null;
	
	
	
	public Det() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Det(List<Produtos> det) {
		super();
		this.det = det;
	}
	public Det(List<Produtos> det, List<Integer> nItem) {
		super();
		this.det = det;
		this.nItem = nItem;
	}
	public List<Produtos> getDet() {
		return det;
	}
	public void setDet(List<Produtos> det) {
		this.det = det;
	}
	public List<Integer> getnItem() {
		return nItem;
	}
	public void setnItem(List<Integer> nItem) {
		this.nItem = nItem;
	}
	
	

}
