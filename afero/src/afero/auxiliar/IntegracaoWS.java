package afero.auxiliar;

import javax.ws.rs.core.MediaType;
import java.io.BufferedReader;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLConnection;
import com.sun.jersey.api.client.WebResource;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;


import afero.auxiliar.RetornoIntegracao;

//import sun.net.www.protocol.http.HttpURLConnection;

public class IntegracaoWS {
	   // HTTP GET request
	public String sendGet(String Url) throws Exception {
		 // Cria um objeto HttpURLConnection:
        HttpURLConnection request = (HttpURLConnection) new URL(Url).openConnection();

        try {
            // Define que a conexão pode enviar informações e obtê-las de volta:
            request.setDoOutput(true);
            request.setDoInput(true);

            // Define o content-type:
            request.setRequestProperty("Content-Type", "application/json");

            // Define o método da requisição:
            request.setRequestMethod("POST");

            // Conecta na URL:
            request.connect();
            System.out.println(request.getResponseCode());
            System.out.println(request.getResponseMessage());
            

    		Client client = Client.create();

    		WebResource requestTeste = client.resource(Url);
            ClientResponse resposta = (ClientResponse) requestTeste.get(ClientResponse.class);

    		int HttpCode = resposta.getStatus(); 

    		String body = resposta.getEntity(String.class);

    		/* As três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá 
    		   interpretar e lidar com o retorno*/
    		System.out.print("HTTP Code: ");
    		System.out.print(HttpCode);
    		System.out.printf(body);
            // Caso você queira usar o código HTTP para fazer alguma coisa, descomente esta linha.
            //int response = request.getResponseCode();
            
            
        }catch (IOException ex){
         throw new Exception(ex);
        }finally {
            request.disconnect();
        }
       return readResponse(request);
}
	public String sendPost(String url, String json) throws Exception {

	    
	        // Cria um objeto HttpURLConnection:
	        HttpURLConnection request = (HttpURLConnection) new URL(url).openConnection();

	        try {
	            // Define que a conexão pode enviar informações e obtê-las de volta:
	            request.setDoOutput(true);
	            request.setDoInput(true);

	            // Define o content-type:
	            request.setRequestProperty("Content-Type", "application/json");

	            // Define o método da requisição:
	            request.setRequestMethod("POST");

	            // Conecta na URL:
	            request.connect();

	            // Escreve o objeto JSON usando o OutputStream da requisição:
	            
	            OutputStream outputStream = request.getOutputStream();
	            outputStream.write(json.getBytes("UTF-8"));
	            System.out.println(json.toString());

	            // Caso você queira usar o código HTTP para fazer alguma coisa, descomente esta linha.
	            int response = request.getResponseCode();
	            System.out.println(response);
	           

	           
	       
	        
	    } catch (IOException ex) {
	        ex.printStackTrace();
	    }finally {
            request.disconnect();
        }
	    return readResponse(request);
	}
   
    
	private String readResponse(HttpURLConnection request) throws IOException {
	    ByteArrayOutputStream os = new ByteArrayOutputStream();
	    try {
	    	InputStream is = request.getInputStream();
	        int b;
	        while ((b = is.read()) != -1) {
	            os.write(b);
	        }
	        
	    }catch (IOException ex) {
		        ex.printStackTrace();
		}
	    return new String(os.toByteArray());
	    
	    
	}
	
	public String cancelamentoNotaFiscal(String url)throws Exception{
    	int HttpCode = 0;
    	String body = "";
    	try{
    		Client client = Client.create();

    		WebResource request = client.resource(url);

    		ClientResponse resposta = (ClientResponse) request.post(ClientResponse.class);

    		HttpCode = resposta.getStatus(); 

    		body = resposta.getEntity(String.class);
		
		/* As três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá 
		   interpretar e lidar com o retorno*/
    		System.out.print("HTTP Code: ");
    		System.out.print(HttpCode);
    		System.out.printf(body);
    		
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    		
    	return HttpCode + " - " +body;
		
	}
		
	public String consultaNotaFiscal(String url)throws Exception{
    	int HttpCode = 0;
    	String body = "";
    	try{
    		Client client = Client.create();

    		WebResource request = client.resource(url);

    		ClientResponse resposta = (ClientResponse) request.post(ClientResponse.class);

    		HttpCode = resposta.getStatus(); 

    		body = resposta.getEntity(String.class);
		
		/* As três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá 
		   interpretar e lidar com o retorno*/
    		System.out.print("HTTP Code: ");
    		System.out.print(HttpCode);
    		System.out.printf(body);
    		
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    		
    	return HttpCode + " - " +body;
		
	}
	
	public String enviarNotaFiscal(String url, String json)throws Exception{
		int HttpCode = 0;
		String body = "";
		try{
		   Client client = Client.create();
		   WebResource request = client.resource(url);
		   ClientResponse resposta = request.accept(MediaType.APPLICATION_JSON).post(ClientResponse.class, json);
		   HttpCode = resposta.getStatus(); 
		   body = resposta.getEntity(String.class);
		
		/* As três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá 
		   interpretar e lidar com o retorno*/
		   System.out.print("HTTP Code: ");
		   System.out.print(HttpCode);
		   System.out.printf(body);
		}catch(Exception e){
			e.printStackTrace();
		}
		return HttpCode + " - " +body;
		
	}
	public String cartaCorrecaoNotaFiscal(String url)throws Exception{
    	int HttpCode = 0;
    	String body = "";
    	try{
    		Client client = Client.create();

    		WebResource request = client.resource(url);

    		ClientResponse resposta = (ClientResponse) request.post(ClientResponse.class);

    		HttpCode = resposta.getStatus(); 

    		body = resposta.getEntity(String.class);
		
		/* As três linhas abaixo imprimem as informações retornadas pela API, aqui o seu sistema deverá 
		   interpretar e lidar com o retorno*/
    		System.out.print("HTTP Code: ");
    		System.out.print(HttpCode);
    		System.out.printf(body);
    		
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    		
    	return HttpCode + " - " +body;
		
	}		

}
