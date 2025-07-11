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
import afero.integracao.xprocess.Secao;
import afero.persistence.AferoDAOException;

//Arquivo

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


public class GerarArquivoSecao {

	
	public String listarDivisao(int idLoja, Connection conn) throws AferoDAOException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		//List<Secao> list = null;
		StringBuilder sb = new StringBuilder();

		try {
			String sql = "SELECT distinct d.idDivisao, convert(d.dsDivisao using ascii) from tbdivisao d "+
                         "JOIN tbproduto p on d.idDivisao = p.idDivisao "+
                         "JOIN tbestoque e on p.idProduto = e.idProduto "+
                         "WHERE d.status = 'A' AND e.idLoja = ? AND p.status = 'A'";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idLoja);
			rs = ps.executeQuery();
			//list = new ArrayList<Secao>();
			while (rs.next()) {

				//String idSecao = Utilitaria.completarZeros("".valueOf(rs.getInt(1)), 7);
				sb.append(Utilitaria.completarZeros("".valueOf(rs.getInt(1)), 7));
				//String nomeSecao = (Utilitaria.completarBrancos(rs.getString(2), 60));
				sb.append(Utilitaria.completarBrancos(rs.getString(2), 60));
				//list.add(new Secao(idSecao, nomeSecao));
				sb.append("\n");
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return sb.toString();
	}
	
	public void GerarArquivoTxt(List list){
		File arquivo = new File("/SECAO.txt");
		 
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
			Secao secao = (Secao) it.next();
			if(secao.getNomeSecao() != null || secao.getNomeSecao()!= ""){
				bw.write(secao.getIdSecao()+secao.getNomeSecao());
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

