package utilitario;






public class TesteComunicacaoBanco {
	

	/**
	 * @param args
	 * @throws EscarizDAOException 
	 */
	public static void main(String[] args) throws Exception {
	//	try{
			ConnectionFactory.getConnection();
			
			System.out.println("Conexão Estabelecida");
			
		//}catch(Exception e){
		//	e.getStackTrace();
	//	}
		

	}

}
