package afero.test;
import afero.util.ImpressaoBobina;
public class TesteImpressora {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ImpressaoBobina impressao = new ImpressaoBobina();
		impressao.detectaImpressoras();
		boolean status = impressao.imprime("TESTE ");
		System.out.println(status);
		// TODO Auto-generated method stub

	}

}
