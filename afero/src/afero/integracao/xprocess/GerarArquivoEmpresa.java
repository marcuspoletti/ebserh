package afero.integracao.xprocess;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import afero.util.ConnectionFactory;
import afero.util.Utilitaria;
import afero.model.Crt;
import afero.model.Estado;
import afero.persistence.AferoDAOException;
import afero.model.Cidade;
import afero.persistence.CidadeDAO;
import afero.persistence.EstadoDAO;
import afero.persistence.CrtDAO;
//Arquivo

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


public class GerarArquivoEmpresa {

	
	public String procurarLoja(int idLoja, Connection conn) throws AferoDAOException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Empresa empresa = new Empresa();
		StringBuilder sb = new StringBuilder();

		try {
			String sql = "SELECT apelido, razaoSocial, cnpj, inscEstadual, inscMunicipal, endereco, cmpEndereco, cep, bairro, idCidade, estado, nroTelefone, nroFax, pessoaResponsavel, " +
					     "dtMod, dtCad, status, usuario, idCrt, idCnae, nro FROM tbloja ";
		    
		    sql = sql + "WHERE idLoja = ? ";
		    
					     
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idLoja);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("NÃ£o foi encontrado nenhum "
						+ "registro com o cï¿½d.setor: " + idLoja);
			}
			//empresa.setTipo(5);
			sb.append("5");
//			String lojaId = Utilitaria.completarZeros("".valueOf(idLoja), 5);
			sb.append(Utilitaria.completarZeros("".valueOf(idLoja), 5));
//          empresa.setIdEmpresa(lojaId);
//			empresa.setNomeFantasia(Utilitaria.completarBrancos(rs.getString(1), 80));
			sb.append(Utilitaria.completarBrancos(rs.getString(2), 80));
			sb.append(Utilitaria.completarBrancos(rs.getString(1), 80));
//			empresa.setNomeEmpresa(Utilitaria.completarBrancos(rs.getString(2), 80));
//			empresa.setCNPJ(Utilitaria.completarBrancos(Utilitaria.formatarCNPJ(rs.getString(3)), 20));
			sb.append(Utilitaria.completarBrancos(Utilitaria.formatarCNPJ(rs.getString(3)), 20));
//			empresa.setInscricaoEstadual(Utilitaria.completarBrancos(rs.getString(4), 20));
			sb.append(Utilitaria.completarBrancos(rs.getString(4), 20));
//          empresa.setEndereço(Utilitaria.completarBrancos(rs.getString(6), 80));
			sb.append(Utilitaria.completarBrancos(rs.getString(6), 80));
//          empresa.setComplemento(Utilitaria.completarBrancos(rs.getString(7), 80));
			sb.append(Utilitaria.completarBrancos(rs.getString(7), 80));
			sb.append(Utilitaria.completarBrancos(rs.getString(9), 80));
			CidadeDAO daoCidade = new CidadeDAO(conn);
			Cidade cidade = daoCidade.procurarCidade(rs.getInt(10));
			sb.append(Utilitaria.completarBrancos(cidade.getNmCidade(), 80));
			EstadoDAO daoEstado = new EstadoDAO(conn);
			Estado estado = daoEstado.procurarEstado(cidade.getCdEstado());
			sb.append(Utilitaria.completarBrancos(estado.getSiglaEstado(), 2));
//			empresa.setCodIBGE(Utilitaria.completarBrancos(cidade.getCdMunicipio(), 7));
			sb.append(Utilitaria.completarBrancos(rs.getString(8), 9));
			sb.append(Utilitaria.completarBrancos(rs.getString(12), 20));
			sb.append(Utilitaria.completarBrancos(rs.getString(13), 20));
			sb.append(Utilitaria.completarBrancos("", 60));
			sb.append(Utilitaria.completarBrancos("", 100));
//			empresa.setuF(Utilitaria.completarBrancos(estado.getSiglaEstado(), 2));
//			empresa.setMunicipio(Utilitaria.completarBrancos(cidade.getNmCidade(), 80));
//          empresa.setCep(Utilitaria.completarBrancos(rs.getString(8), 9));
//			empresa.setBairro(Utilitaria.completarBrancos(rs.getString(9), 80));
//			empresa.setCodIBGE(Utilitaria.completarBrancos(cidade.getCdMunicipio(), 7));
//			empresa.setuF(Utilitaria.completarBrancos(estado.getSiglaEstado(), 2));
//			empresa.setMunicipio(Utilitaria.completarBrancos(cidade.getNmCidade(), 80));
//			empresa.setTelefone(Utilitaria.completarBrancos(rs.getString(12), 20));
//			empresa.setFax(Utilitaria.completarBrancos(rs.getString(13), 20));
			CrtDAO daoCrt = new CrtDAO(conn);
			Crt crt = daoCrt.procurarCrt(rs.getInt(19));
//			empresa.setCodCrt(crt.getCodigo().toString());
			sb.append(crt.getCodigo().toString());
//			empresa.setNaoUsado(Utilitaria.completarBrancos((""), 100));
//			empresa.setNaoUsado2(Utilitaria.completarBrancos((""), 5));
			sb.append(Utilitaria.completarBrancos((""), 5));
//			empresa.setNaoUsado3(Utilitaria.completarBrancos((""), 1));
			sb.append(Utilitaria.completarBrancos((""), 1));
			sb.append(Utilitaria.completarBrancos(cidade.getCdMunicipio(), 7));
//			empresa.setDescCFOP(Utilitaria.completarBrancos("Venda ao Consumidor", 30));
			sb.append(Utilitaria.completarBrancos("Venda ao Consumidor", 30));
			sb.append("\n");
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return sb.toString();
	}
	
	public File GerarArquivoTxt(Empresa empresa){
		File arquivo = new File("/EMPRESA.txt");
		 
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
		 
		bw.write(empresa.getTipo()+empresa.getIdEmpresa()+empresa.getNomeEmpresa()+empresa.getNomeFantasia()+empresa.getCNPJ()+empresa.getInscricaoEstadual()+empresa.getEndereço()+empresa.getComplemento()+
				empresa.getBairro()+empresa.getMunicipio()+empresa.getuF()+empresa.getCep()+empresa.getTelefone()+empresa.getFax()+empresa.getCodCrt()+
				empresa.getCodIBGE()+empresa.getDescCFOP());
		 
		bw.newLine();
		 
		bw.close();
		fw.close();
		
		
		 
		}catch (IOException ex) {
			ex.printStackTrace();
	}
		return arquivo.getAbsoluteFile();

}
}
