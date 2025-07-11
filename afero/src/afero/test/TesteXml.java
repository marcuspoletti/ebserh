package afero.test;


import afero.test.Livro; 
import afero.test.Autor;
import com.thoughtworks.xstream.XStream; 


public class TesteXml { 
	
	public static void main(String[] args) { 
		 XStream xstream = new XStream();
		 Autor autor = new Autor("Dan Brow", "49025290");
		 Livro livro = new Livro(2000, "Assim Falou Zaratustra", "123", autor); 
		 String xml = xstream.toXML(livro); 
		 System.out.println("XML = "); 
		 System.out.println(xml);
		 //System.out.println(xml.getClass().hashCode()); 
	} 
}

	