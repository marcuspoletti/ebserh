

import static org.mockito.Matchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import junit.framework.TestCase;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.mockito.Mockito;

import com.human.gateway.client.bean.FileResource;
import com.human.gateway.client.bean.ListResource;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.bean.SimpleMessage;
import com.human.gateway.client.enumerator.CallbackTypeEnum;
import com.human.gateway.client.enumerator.LayoutTypeEnum;
import com.human.gateway.client.exception.ClientHumanException;
import com.human.gateway.client.service.MultipleMessageService;
import com.human.gateway.client.service.QueryMessageService;
import com.human.gateway.client.service.SimpleMessageService;
import com.human.gateway.client.service.base.BaseService;
import com.human.gateway.client.util.HttpClientHelper;

public class MainTest extends TestCase {

	private static String ACCOUNT = "account_fornecida";
	private static String CODE = "senha_fornecida";

	public void testSendLoginFail() {
		SimpleMessage msg = new SimpleMessage();
		msg.setFrom("Human");
		msg.setMessage("Teste de envio de SMS com account / code invalidos.");
		msg.setTo("555193429020");
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		SimpleMessageService cliente = new SimpleMessageService(null, null);
		
		//cliente.setAccount(ACCOUNT);
		//cliente.setCode(CODE);

		try {
			System.out.println("<< Teste de envio de SMS com ACCOUNT / CODE invalidos >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
			
			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Field \""+SimpleMessageService.PARAM_ACCOUNT+"\" is required.", e.getMessage());
		}
	}

    public void testSslLoginFail() {
    	SimpleMessage msg = new SimpleMessage();
        msg.setFrom("Human");
        msg.setMessage("Teste de envio de SMS com account / code invalidos.");
        msg.setTo("555193429020");
        msg.setCallback(CallbackTypeEnum.INACTIVE);

        SimpleMessageService cliente = new SimpleMessageService(null, null);
        cliente.setUseSSL(true);

        try {
            System.out.println("<< Teste de envio de SMS com ACCOUNT / CODE invalidos >>");
            List<Response> ret = cliente.send(msg);
            Iterator<Response> it = ret.iterator();
            while (it.hasNext()) {
                System.out.println(((Response)it.next()).toString());
            }
            
            fail("Deve jogar exception");
        } catch (ClientHumanException e) {
            e.printStackTrace();
            assertEquals("Field \""+SimpleMessageService.PARAM_ACCOUNT+"\" is required.", e.getMessage());
        }
    }
    
	public void testSendSMSTooLarge() {
		SimpleMessage msg = new SimpleMessage();
		msg.setFrom("Human");
		msg.setMessage("123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.");
		msg.setTo("555193429020");
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		SimpleMessageService cliente = new SimpleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com MSG muito longo >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Fields \""+SimpleMessageService.PARAM_MSG+"\" + \""+SimpleMessageService.PARAM_FROM+"\" can not exceed "+SimpleMessageService.BODY_MAX_LENGTH+" characters.", e.getMessage());
		}
	}

	public void testSendSMSTooLarge2() {
		SimpleMessage msg = new SimpleMessage();
		//msg.setFrom("Human");
		msg.setMessage("123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123");
		msg.setTo("555193429020");
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		SimpleMessageService cliente = new SimpleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com MSG muito longo e sem FROM >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Fields \""+SimpleMessageService.PARAM_MSG+"\" + \""+SimpleMessageService.PARAM_FROM+"\" can not exceed "+SimpleMessageService.BODY_MAX_LENGTH+" characters.", e.getMessage());
		}
	}

	public void testSendIdTooLarge() {
		SimpleMessage msg = new SimpleMessage();
		msg.setFrom("Human");
		msg.setMessage("Teste de envio de SMS com id invalido.");
		msg.setTo("555193429020");
		msg.setId("123456789.123456789.1");
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		SimpleMessageService cliente = new SimpleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com ID invalidos >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Field \""+SimpleMessageService.PARAM_ID+"\" can not have more than "+SimpleMessageService.ID_MAX_LENGTH+" characters.", e.getMessage());
		}
	}

	public void testSendMissingTo() {
		SimpleMessage msg = new SimpleMessage();
		msg.setFrom("Human");
		msg.setMessage("Teste de envio de SMS sem destinatario.");
		//msg.setTo("555193429020");
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		SimpleMessageService cliente = new SimpleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS sem TO >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Field \""+SimpleMessageService.PARAM_TO+"\" is required.", e.getMessage());
		}
	}

	public void testSendMissingMsg() {
		SimpleMessage msg = new SimpleMessage();
		msg.setFrom("Human");
		//msg.setMessage("Teste de envio de SMS sem destinatario.");
		msg.setTo("555193429020");
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		SimpleMessageService cliente = new SimpleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS sem MSG >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Field \""+SimpleMessageService.PARAM_MSG+"\" is required.", e.getMessage());
		}
	}

	public void testSendFileNotFound() {
		FileResource msg = new FileResource(new File("FileNotFound.txt"), null);
		msg.setCallback(CallbackTypeEnum.INACTIVE);
		
		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo inexistente >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File not found.", e.getMessage());
		}
	}

	public void testSendFileTooLarge() {
		File file = new File(getClass().getResource("FileTooLarge.txt").getPath());
		FileResource msg = new FileResource(file, LayoutTypeEnum.TYPE_A);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo muito grande >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File size exceeds the limit of 1MB.", e.getMessage());
		}
	}

	public void testSendFileMalformedA() {
		File file = new File(getClass().getResource("FileMalformedA.txt").getPath());
		FileResource msg = new FileResource(file, LayoutTypeEnum.TYPE_A);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo com problemas de formatacao (layout A) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendFileMalformedB() {
		File file = new File(getClass().getResource("FileMalformedB.txt").getPath());
		FileResource msg = new FileResource(file, LayoutTypeEnum.TYPE_B);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo com problemas de formatacao (layout B) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendFileMalformedD() {
		File file = new File(getClass().getResource("FileMalformedD.txt").getPath());
		FileResource msg = new FileResource(file, LayoutTypeEnum.TYPE_D);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo com problemas de formatacao (layout D) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendFileMalformedE() {
		File file = new File(getClass().getResource("FileMalformedE.txt").getPath());
		FileResource msg = new FileResource(file, LayoutTypeEnum.TYPE_E);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo com problemas de formatacao (layout E) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
			
			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendFileMalformedEInvalidDate() {
		File file = new File(getClass().getResource("FileMalformedEInvalidDate.txt").getPath());
		FileResource msg = new FileResource(file, LayoutTypeEnum.TYPE_E);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo com problemas de formatacao (layout E) - data invalida >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Date invalid.", e.getMessage());
		}
	}
	
	public void testSendListMalformedA() throws IOException {
		FileReader reader = new FileReader(getClass().getResource("FileMalformedA.txt").getPath());
		StringBuffer sb = new StringBuffer();
		BufferedReader buffer = new BufferedReader(reader);
		String line = buffer.readLine();
		while (line != null) {
			sb.append(line).append("\n");
			line = buffer.readLine();
		}

		ListResource msg = new ListResource(sb.toString(), LayoutTypeEnum.TYPE_A);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com lista com problemas de formatacao (layout A) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendListMalformedB() throws IOException {
		FileReader reader = new FileReader(getClass().getResource("FileMalformedB.txt").getPath());
		StringBuffer sb = new StringBuffer();
		BufferedReader buffer = new BufferedReader(reader);
		String line = buffer.readLine();
		while (line != null) {
			sb.append(line).append("\n");
			line = buffer.readLine();
		}
		
		ListResource msg = new ListResource(sb.toString(), LayoutTypeEnum.TYPE_B);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com lista com problemas de formatacao (layout B) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendListMalformedD() throws IOException {
		FileReader reader = new FileReader(getClass().getResource("FileMalformedD.txt").getPath());
		StringBuffer sb = new StringBuffer();
		BufferedReader buffer = new BufferedReader(reader);
		String line = buffer.readLine();
		while (line != null) {
			sb.append(line).append("\n");
			line = buffer.readLine();
		}
		
		ListResource msg = new ListResource(sb.toString(), LayoutTypeEnum.TYPE_D);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com lista com problemas de formatacao (layout D) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendListMalformedE() throws IOException {
		FileReader reader = new FileReader(getClass().getResource("FileMalformedE.txt").getPath());
		StringBuffer sb = new StringBuffer();
		BufferedReader buffer = new BufferedReader(reader);
		String line = buffer.readLine();
		while (line != null) {
			sb.append(line).append("\n");
			line = buffer.readLine();
		}
		
		ListResource msg = new ListResource(sb.toString(), LayoutTypeEnum.TYPE_E);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com lista com problemas de formatacao (layout E) >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
			
			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("File format invalid.", e.getMessage());
		}
	}

	public void testSendListMalformedEInvalidDate() throws IOException {
		FileReader reader = new FileReader(getClass().getResource("FileMalformedEInvalidDate.txt").getPath());
		StringBuffer sb = new StringBuffer();
		BufferedReader buffer = new BufferedReader(reader);
		String line = buffer.readLine();
		while (line != null) {
			sb.append(line).append("\n");
			line = buffer.readLine();
		}
		
		ListResource msg = new ListResource(sb.toString(), LayoutTypeEnum.TYPE_E);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo com problemas de formatacao (layout E) - data invalida >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}

			fail("Deve jogar exception");
		} catch (ClientHumanException e) {
			e.printStackTrace();
			assertEquals("Date invalid.", e.getMessage());
		}
	}
	
	public void testSendOK() {
		SimpleMessage msg = new SimpleMessage();
		msg.setFrom("Human");
		msg.setMessage("Teste de envio de SMS OK");
		msg.setTo("550093429020");
		msg.setId("TESTE0001");
		msg.setSchedule(new Date());

		SimpleMessageService cliente = new SimpleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS OK >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
			
		} catch (ClientHumanException e) {
			e.printStackTrace();
			fail("Nao deve jogar exception");
		}
	}

	public void testSendFileOK() {
		File file = new File(getClass().getResource("FileOKD.txt").getPath());
		FileResource msg = new FileResource(file, LayoutTypeEnum.TYPE_D);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo OK >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
			
		} catch (ClientHumanException e) {
			e.printStackTrace();
			fail("Nao deve jogar exception");
		}
	}

	public void testSendListOK() throws IOException {
		FileReader reader = new FileReader(getClass().getResource("FileOKD.txt").getPath());
		StringBuffer sb = new StringBuffer();
		int c;
		while ((c = reader.read()) > 0) {
			sb.append((char)c);
		}
		
		ListResource msg = new ListResource(sb.toString(), LayoutTypeEnum.TYPE_D);
		msg.setCallback(CallbackTypeEnum.INACTIVE);

		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de envio de SMS com arquivo OK >>");
			List<Response> ret = cliente.send(msg);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
		
		} catch (ClientHumanException e) {
			e.printStackTrace();
			fail("Nao deve jogar exception");
		}
	}

	public void testCheckOne() {
		SimpleMessageService cliente = new SimpleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de verificacao de status de SMS >>");
			String id = "TESTE0001";
			List<Response> ret = cliente.query(id);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
		} catch (ClientHumanException e) {
			e.printStackTrace();
			fail("Nao deve jogar exception");
		}
	}

	public void testCheckMultiple() {
		MultipleMessageService cliente = new MultipleMessageService(ACCOUNT, CODE);

		try {
			System.out.println("<< Teste de verificacao de status de SMS >>");
			String[] ids = new String[]{"TESTE0001","TESTE0002","TESTE0003"};
			List<Response> ret = cliente.query(ids);
			Iterator<Response> it = ret.iterator();
			while (it.hasNext()) {
				System.out.println(((Response)it.next()).toString());
			}
		} catch (ClientHumanException e) {
			e.printStackTrace();
			fail("Nao deve jogar exception");
		}
	}
	
	public void testDeveFazerARequisicao() throws ClientHumanException{
			HttpClientHelper helper = Mockito.mock(HttpClientHelper.class);
			when(helper.requestAndGetMessages(any(PostMethod.class))).thenReturn(new ArrayList<SimpleMessage>());
			QueryMessageService query = new QueryMessageService(ACCOUNT, CODE, helper);
			query.listReceivedSMS();
			verify(helper).requestAndGetMessages(any(PostMethod.class));			
	}
	
	public void testConsultaDeMensagensRecebidasDeveFalharQuandoAccountForInvalido() {
		HttpClientHelper helper = Mockito.mock(HttpClientHelper.class);
		try {			
			QueryMessageService query = new QueryMessageService(null, CODE, helper);
			query.listReceivedSMS();			
			fail("Deveria ocorrer um erro na validação da conta.");
		} catch (ClientHumanException e) {
			assertEquals("Field \""+BaseService.PARAM_ACCOUNT+"\" is required.", e.getMessage());
		}		
	}
	
	public void testConsultaDeMensagensRecebidasDeveFalharQuandoCodeForInvalido() {
		HttpClientHelper helper = Mockito.mock(HttpClientHelper.class);
		try {			
			QueryMessageService query = new QueryMessageService(ACCOUNT, null, helper);
			query.listReceivedSMS();		
			fail("Deveria ocorrer um erro na validação da conta.");
		} catch (ClientHumanException e) {
			assertEquals("Field \""+BaseService.PARAM_CODE+"\" is required.", e.getMessage());
		}	
	}
		
	public void testConsultDeMensagensRecebidasaDeveFalharQuandoAccountOuCodeForInvalido() {		
		HttpClientHelper helper = Mockito.mock(HttpClientHelper.class);
		try {	
			when(helper.requestAndGetMessages(any(PostMethod.class)) ).thenThrow(new ClientHumanException("900 - Authentication error") );
			QueryMessageService query = new QueryMessageService(ACCOUNT, CODE, helper);
			query.listReceivedSMS();		
			fail("Deveria ocorrer um erro na validação na autenticação.");
		} catch (ClientHumanException e) {
			assertEquals("900 - Authentication error", e.getMessage());
		}	
   }
	
	public void testConsultaDeMensagensRecebidasDeveFalharQuandoConexaoForInvalida() throws HttpException, IOException{		
		HttpClient client = Mockito.mock(HttpClient.class);
		try {
			when(client.executeMethod(any(PostMethod.class)) ).thenThrow(new UnknownHostException("host_invalido"));
			HttpClientHelper helper = new HttpClientHelper();
			helper.setHost("host_invalido");
			helper.setUri("/GatewayIntegration/msgSms.do");
			helper.setPort(80);
			QueryMessageService query = new QueryMessageService(ACCOUNT, CODE, helper );
			query.listReceivedSMS();		
			fail("Deveria ocorrer um erro de conexao");			
		} catch (ClientHumanException e) {
			assertEquals("host_invalido", e.getCause().getMessage());
		}
		
	}	
	
	
}
