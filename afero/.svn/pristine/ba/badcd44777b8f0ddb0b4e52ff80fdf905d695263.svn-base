package afero.util;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;  
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.swing.JOptionPane; 


public class ImpressaoBobina {
	
	
	private static PrintService impressora;
	
	
	public  ImpressaoBobina(){
		
	}
	
	public static List<String> retornaImressoras(){
		List<String> listaImpressoras = new ArrayList<String>();
        try {
            DocFlavor df = DocFlavor.SERVICE_FORMATTED.PRINTABLE;  
            PrintService[] ps = PrintServiceLookup.lookupPrintServices(df, null);  
            for (PrintService p : ps) {  
                listaImpressoras.add(p.getName());     
            }  
            return listaImpressoras;
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return listaImpressoras;
    }
	
	
	public void detectaImpressoras(String impressoraSelecionada) {  //Passa por parâmetro o nome salvo da impressora
	        try {  
	            DocFlavor df = DocFlavor.SERVICE_FORMATTED.PRINTABLE;  
	            PrintService[] ps = PrintServiceLookup.lookupPrintServices(df, null);  
	            for (PrintService p : ps) {  
	                if(p.getName()!=null && p.getName().contains(impressoraSelecionada)){  
	                    impressora = p;  
	                }     
	            }  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	}
	
	 public void detectaImpressoras() {
	        try {
	            DocFlavor df = DocFlavor.SERVICE_FORMATTED.PRINTABLE;
	            PrintService[] ps = PrintServiceLookup.lookupPrintServices(df, null);
	            for (PrintService p: ps) {
	                System.out.println("Impressora encontrada: " + p.getName());
	                if (p.getName().contains("4200") || p.getName().contains("4200"))  {
		                System.out.println("Impressora Selecionada: " + p.getName());
	                    impressora = p;
	                    System.out.println(impressora.toString());
	                    break;
	                }
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	 
	 public synchronized boolean imprime(String texto) {
		    detectaImpressoras();
	        // se nao existir impressora, entao avisa usuario
	        // senao imprime texto
	        if (impressora == null) {
	            String msg = "Nennhuma impressora foi encontrada. Instale uma impressora padrão \r\n(Generic Text Only) e reinicie o programa.";
		       	System.out.println(msg);
	        } else {
	            try {
	                DocPrintJob dpj = impressora.createPrintJob();
	                InputStream stream = new ByteArrayInputStream(texto.getBytes());
	                DocFlavor flavor = DocFlavor.INPUT_STREAM.AUTOSENSE;
	                Doc doc = new SimpleDoc(stream, flavor, null);
	                dpj.print(doc, null);
	                return true;
	            } catch (PrintException e) {
	                e.printStackTrace();
	            }
	        }
	        return false;
	    }
	
	
	
	public static void Impressao(String textoBobina)throws Exception{
	FileOutputStream fos = null;
	PrintStream ps = null;
	try{ 
		fos = new FileOutputStream("LPT1:");
	}catch (Exception ex) {
	   ex.printStackTrace();   
	}
	try {
		ps = new PrintStream(fos);
	}catch (Exception exception) {
		exception.printStackTrace();
	} 
		ps.println((textoBobina));

}
	public final boolean ImpLine( String msg ) {
	     File fporta = new File("LPT1:");
	     byte[] buf = new byte[ msg.length() ];
	     msg.getBytes(0, msg.length(), buf, 0);
	     try {
	       FileOutputStream porta = new FileOutputStream( fporta );
	       porta.write( buf );
	       porta.flush();
	       porta.close();
	     } catch (IOException ioe) {
	         fporta.exists();
	         return false;
	        }
	     fporta.exists();
	   return true;
	  }
	
	public void acionarGuilhotina(){
        imprime(""+(char)27+(char)109);
    }
	
	public static void imprimirTextoBobina(String textoBobina) throws PrintException {    
	       
	     FileOutputStream fos = null;  
	     PrintStream ps = null;  
	  
	  try  
	  {  
	    fos = new FileOutputStream("LPT1:");  
	  }  
	  catch (Exception ex)  
	  {  
	      JOptionPane.showMessageDialog(null,"Erro porta"+"n/"+ex);  
	  }  
	  
	  try  
	  {  
	   ps = new PrintStream(fos);  
	     
	  }  
	  catch (Exception exception)  
	  {  
	    JOptionPane.showMessageDialog(null,"Erro Saida"+"n/"+exception);  
	  }  
	    
	    
	     ps.print(textoBobina);  
	       
	  
	} 
	
	
	

}
