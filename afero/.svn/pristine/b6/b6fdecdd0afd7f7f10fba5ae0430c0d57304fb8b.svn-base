package afero.util;

import java.io.IOException;

public class TesteMain {
	public static void main(String[] args) {
		
		/*
		try{
           SendMail send = new SendMail();
           send.sendMail("mvpoletti@yahoo.com.br","marcusvpoletti@gmail.com", "TESTE AFERO", "SERVIÇOS NOVOS DO AFERO, AGORA MANDA EMAIL");
           System.out.println("SUCESSO DE ENVIO..........");
		}catch(Exception e){
			e.printStackTrace();
		}
		*/
		/*
		String[] cep = Cep.consultarEnderecoCorreios("49025290");
		if(cep[0].length() > 0){
			System.out.println(cep[0]);
			System.out.println(cep[1]);
			System.out.println(cep[2]);
			System.out.println(cep[3]);
			System.out.println(cep[4]);
			//System.out.println(cep[5]);
		}else{
			System.out.println("CEP NÃO ENCONTRADO");
		}
		*/
		BuscaCep busca = new BuscaCep();
		try {
			System.out.println(busca.getEndereco("49045100"));
			System.out.println(busca.getUF("49045-100"));
			System.out.println(busca.getCidade("49045100"));
			System.out.println(busca.getBairro("49045-100"));
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
