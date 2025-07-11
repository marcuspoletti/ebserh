package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.CatTributaria;
import afero.util.ConverteDate;

public class CatTributariaDAO {

	private Connection conn;
	
    public CatTributariaDAO(Connection conn) {
		this.conn = conn;
    }
	
	public void incluir(CatTributaria catTributaria) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (catTributaria == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcattributaria(dsCatTributaria, cdCstIpi, pIpi, classeEnquadramento, codigoEnquadramento, cnpjProdutor, cdCstPis, pPis, cdCstCofins, pCofins, status, dtMod, usuario) " +
			             "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			if(catTributaria.getDsCatTributaria() != null){
				ps.setString(1, catTributaria.getDsCatTributaria());
			}else{
				ps.setString(1,null);
			}
			if(catTributaria.getCdCstIpi() > 0){
				ps.setInt(2, catTributaria.getCdCstIpi());
			}else{
				ps.setNull(2, 0);
			}
			if(catTributaria.getpIpi() > 0){
				ps.setFloat(3, catTributaria.getpIpi());
			}else{
				ps.setNull(3, 0);
			}
			if(catTributaria.getClasseEnquadramento() != null){
				ps.setString(4, catTributaria.getClasseEnquadramento());
			}else{
				ps.setNull(4, 0);
			}
			if(catTributaria.getCodigoEnquadramento() != null){
				ps.setString(5, catTributaria.getCodigoEnquadramento());
			}else{
				ps.setNull(5, 0);
			}
			if( catTributaria.getCnpjProdutor() != null){
				ps.setString(6, catTributaria.getCnpjProdutor());
			}else{
				ps.setNull(6, 0);
			}
			if(catTributaria.getCdCstPis() > 0){
				ps.setInt(7, catTributaria.getCdCstPis());
			}else{
				ps.setNull(7, 0);
			}
			if(catTributaria.getpPis() > 0){
				ps.setFloat(8, catTributaria.getpPis());
			}else{
				ps.setNull(8, 0);
			}
			if(catTributaria.getCdCstCofins() > 0){
				ps.setInt(9, catTributaria.getCdCstCofins());
			}else{
				ps.setNull(9, 0);
			}
			if(catTributaria.getpCofins() > 0){
				ps.setFloat(10, catTributaria.getpCofins());
			}else{
				ps.setNull(10,0);
			}			
			ps.setString(11, catTributaria.getStatus());
			ps.setString(12, catTributaria.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		}	
	}

	public void atualizar(CatTributaria catTributaria) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (catTributaria == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcattributaria set dsCatTributaria = ?, cdCstIpi = ?, pIpi = ?, classeEnquadramento = ?, codigoEnquadramento = ?, cnpjProdutor = ?, cdCstPis = ?, " +
					 "pPis = ?, cdCstCofins = ?, pCofins = ?, status = ?, dtMod = now(), usuario = ? "+
		             "WHERE idCatTributaria = ?";
		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, catTributaria.getDsCatTributaria());
			ps.setInt(2, catTributaria.getCdCstIpi());
			ps.setFloat(3, catTributaria.getpIpi());
			ps.setString(4, catTributaria.getClasseEnquadramento());
			ps.setString(5, catTributaria.getCodigoEnquadramento());
			ps.setString(6, catTributaria.getCnpjProdutor());
			ps.setInt(7, catTributaria.getCdCstPis());
			ps.setFloat(8, catTributaria.getpPis());
			ps.setInt(9, catTributaria.getCdCstCofins());
			ps.setFloat(10, catTributaria.getpCofins());
			ps.setString(11, catTributaria.getStatus());
			ps.setString(12, catTributaria.getUsuario());
			ps.setInt(13, catTributaria.getIdCatTributaria());
			ps.executeUpdate();
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(CatTributaria catTributaria) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (catTributaria == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;			
			ps = conn.prepareStatement("DELETE FROM tbcattributaria WHERE idCatTributaria=?");
			ps.setInt(1, catTributaria.getIdCatTributaria());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CatTributaria procurarCatTributaria(int idCatTributaria) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CatTributaria catTributaria = null;
		
		try {
			String sql = "SELECT dsCatTributaria, cdCstIpi, pIpi, classeEnquadramento, codigoEnquadramento, cnpjProdutor, cdCstPis, pPis, cdCstCofins, pCofins, status, dtMod, usuario "+
			             "from tbcattributaria " +
			             "WHERE idCatTributaria = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCatTributaria);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idCatTributaria);
			}
            
			String dsCatTributaria = rs.getString(1);
			int cdCstIpi = rs.getInt(2);
			float pIpi = rs.getFloat(3);
			String classeEnquadramento = rs.getString(4);
			String codigoEnquadramento = rs.getString(5);
			String cnpjProdutor = rs.getString(6);
			int cdCstPis = rs.getInt(7);
			float pPis = rs.getFloat(8);
			int cdCstCofins = rs.getInt(9);
			float pCofins = rs.getFloat(10);
			String status = rs.getString(11);
			Date dtMod = rs.getDate(12);
			String usuario = rs.getString(13);
			catTributaria = new CatTributaria(idCatTributaria, dsCatTributaria, cdCstIpi, pIpi, classeEnquadramento, codigoEnquadramento, cnpjProdutor, cdCstPis, pPis, cdCstCofins, pCofins, status, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return catTributaria;
	}

	public List listarCatTributaria(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CatTributaria> list = null;
		
		try {
			String sql = "SELECT idCatTributaria, dsCatTributaria, cdCstIpi, pIpi, classeEnquadramento, codigoEnquadramento, cnpjProdutor, cdCstPis, pPis, cdCstCofins, pCofins, status, dtMod, usuario " +
			             "from tbcattributaria ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CatTributaria>();
			
			while (rs.next()) {
				int idCatTributaria = rs.getInt(1);
				String dsCatTributaria = rs.getString(2);
				int cdCstIpi = rs.getInt(3);
				float pIpi = rs.getFloat(4);
				String classeEnquadramento = rs.getString(5);
				String codigoEnquadramento = rs.getString(6);
				String cnpjProdutor = rs.getString(7);
				int cdCstPis = rs.getInt(8);
				float pPis = rs.getFloat(9);
				int cdCstCofins = rs.getInt(10);
				float pCofins = rs.getFloat(11);
				String status = rs.getString(12);
				Date dtMod = rs.getDate(13);
				String usuario = rs.getString(14);
								
				list.add(new CatTributaria(idCatTributaria, dsCatTributaria, cdCstIpi, pIpi, classeEnquadramento, codigoEnquadramento, cnpjProdutor, cdCstPis, pPis, cdCstCofins, pCofins, status, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return list;
	}
	public boolean exclusaoIdCatTributaria(int idCatTributaria) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select ct.idCatTributaria from tbcattributaria ct "+
                         "JOIN tbtributacao t on ct.idCatTributaria = t.idCatTributaria "+
                         "JOIN tbproduto p on t.idCatTributaria = p.idCatTributaria "+
                         "Where ct.idCatTributaria = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCatTributaria);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return ok;
		
	}

		
}
