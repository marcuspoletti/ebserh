package afero.integracao.xprocess;

	
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
    import java.util.ArrayList;
    import java.util.Iterator;
    import java.util.List;

import afero.util.ConnectionFactory;
	import afero.util.Utilitaria;
    import afero.integracao.xprocess.Vendedores;
	import afero.persistence.AferoDAOException;

	//Arquivo

	import java.io.BufferedWriter;
	import java.io.File;
	import java.io.FileWriter;
import java.io.IOException;


	public class GerarArquivoVendedores {

		
		public String listarVendedores(int idLoja, Connection conn) throws AferoDAOException {
			PreparedStatement ps = null;
			ResultSet rs = null;
			//List<Vendedores> list = null;
			StringBuilder sb = new StringBuilder();

			try {
				String sql = "SELECT idColaborador, idLoja, idTipoColaborador, idUsuario, convert(nome using ascii), apelido, endereco, cep, bairro, cidade, estado, cmpEndereco, " +
						"nroRg, cpf, orgRg, ufRg, telefone, celular, email, dtCad, dtMod, status, usuario FROM tbcolaborador WHERE status = 'A' AND idLoja = ?";
				
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idLoja);
				rs = ps.executeQuery();
				//list = new ArrayList<Vendedores>();
				while (rs.next()) {

					Integer tipo = 4;
					sb.append("4");
//					String idVendedor = Utilitaria.completarZeros("".valueOf(rs.getInt(1)), 7);
					sb.append(Utilitaria.completarZeros("".valueOf(rs.getInt(1)), 7));
//					String nomeVendedor = (Utilitaria.completarBrancos(rs.getString(5), 80));
					sb.append(Utilitaria.completarBrancos(rs.getString(5), 80));
//					list.add(new Vendedores(tipo, idVendedor, nomeVendedor));
					sb.append("\n");
					
				}
				
			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} 
			return sb.toString();
		}
		
		public void GerarArquivoTxt(List list){
			File arquivo = new File("/VENDEDORES.txt");
			 
			try {
			 
			if (!arquivo.exists()) {
			//cria um arquivo (vazio)
			arquivo.createNewFile();
			}
			 
			//caso seja um diretório, é possível listar seus arquivos e diretórios
			//File[] arquivos = arquivo.listFiles();
			 
			//escreve no arquivo
			FileWriter fw = new FileWriter(arquivo, true);
			 
			BufferedWriter bw = new BufferedWriter(fw);
			for ( Iterator it = list.iterator(); it.hasNext(); ) {
				Vendedores vendedor = (Vendedores) it.next();
				if(!vendedor.getIdVendedor().equalsIgnoreCase("0000086")){
					bw.write(vendedor.getTipo()+vendedor.getIdVendedor()+vendedor.getNomeVendedor());
					bw.newLine();
				}
			}
			bw.close();
			fw.close();
			 
			}catch (IOException ex) {
				ex.printStackTrace();
		}

	}


}
