package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import afero.model.OrcamentoEmpresaItem;
import afero.model.RelatorioOrcamentoEmpresaItem;
import afero.model.RelatorioMesAnual;
import afero.model.RelatorioMeses;
import afero.util.ConverteDate;
import afero.persistence.AferoDAOException;

public class OrcamentoEmpresaItemDAO implements IOrcamentoEmpresaItemDAO{
	
private Connection conn;
	
	public OrcamentoEmpresaItemDAO(Connection conn) { 
		this.conn = conn;		
	}
	
	public void incluir(OrcamentoEmpresaItem orcamentoEmpresaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoEmpresaItem == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tborcamentoempresaitem(idOrcamentoEmpresa, idPlanoConta, dtComp, valor, dtMov, usuario) values (?, ?, ?, ?, now(), ?) ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoEmpresaItem.getIdOrcamentoEmpresa());
			ps.setInt(2, orcamentoEmpresaItem.getIdPlanoConta());
			ps.setDate(3, ConverteDate.DateToDateSql(orcamentoEmpresaItem.getDtComp()));
			ps.setDouble(4, orcamentoEmpresaItem.getValor());
			ps.setString(5, orcamentoEmpresaItem.getUsuario());
			
			ps.executeUpdate();
		} catch (SQLException qle) {
			throw new AferoDAOException("Erro ao inserir dados: " + qle);
		} catch (Exception sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(OrcamentoEmpresaItem orcamentoEmpresaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoEmpresaItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamentoempresaitem set idOrcamentoEmpresa = ?, idPlanoConta = ?, dtComp = ?, valor = ?, dtMov = now(), usuario = ? " +
					     " Where idOrcamentoEmpresaItem = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoEmpresaItem.getIdOrcamentoEmpresa());
			ps.setInt(2, orcamentoEmpresaItem.getIdPlanoConta());
			ps.setDate(3, ConverteDate.DateToDateSql(orcamentoEmpresaItem.getDtComp()));
			ps.setDouble(4, orcamentoEmpresaItem.getValor());
			ps.setString(5, orcamentoEmpresaItem.getUsuario());
			ps.setInt(6, orcamentoEmpresaItem.getIdOrcamentoEmpresaItem());
			ps.executeUpdate();

		} catch (SQLException qle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + qle);
		} catch (Exception sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(OrcamentoEmpresaItem orcamentoEmpresaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoEmpresaItem == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tborcamentoempresaitem WHERE idOrcamentoEmpresaItem=?");
			ps.setInt(1, orcamentoEmpresaItem.getIdOrcamentoEmpresaItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public List procurarOrcamentoEmpresaItem(int idOrcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoEmpresaItem> list = null;
		
		try {
			String sql = "SELECT idOrcamentoEmpresaItem, idOrcamentoEmpresa, idPlanoConta, dtComp, valor, dtMov, usuario from tborcamentoempresaitem Where idOrcamentoEmpresa = ? ";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoEmpresaItem>();
			while (rs.next()) {
				int idOrcamentoEmpresaItem = rs.getInt(1);
				int idPlanoConta       = rs.getInt(3);
				Date dtComp            = rs.getDate(4);
				double valor           = rs.getDouble(5);
				Date dtMov             = rs.getDate(6);
				String usuario         = rs.getString(7);
				
				
				list.add(new OrcamentoEmpresaItem(idOrcamentoEmpresaItem,
						idOrcamentoEmpresa, idPlanoConta, valor, dtMov,
						dtComp, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public OrcamentoEmpresaItem pesquisarOrcamentoEmpresaItem(int idOrcamentoEmpresaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoEmpresaItem orcEmpresaItem = null;
		
		try {       
			String sql = "SELECT idOrcamentoEmpresaItem, idOrcamentoEmpresa, idPlanoConta, dtComp, valor, dtMov, usuario from tborcamentoempresaitem Where idOrcamentoEmpresaItem = ? ";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresaItem);
			rs = ps.executeQuery();
			while (rs.next()) {
				int idOrcamentoEmpresa = rs.getInt(2);
				int idPlanoConta       = rs.getInt(3);
				Date dtComp            = rs.getDate(4);
				double valor           = rs.getDouble(5);
				Date dtMov             = rs.getDate(6);
				String usuario         = rs.getString(7);
				
				
				orcEmpresaItem = new OrcamentoEmpresaItem(idOrcamentoEmpresaItem,
						idOrcamentoEmpresa, idPlanoConta, valor, dtMov,
						dtComp, usuario);

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcEmpresaItem;
	}

	
	public List listarOrcamentoEmpresaItem(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoEmpresaItem> list = null;
		
		try {
			String sql = "SELECT oei.idOrcamentoEmpresaItem, oei.idOrcamentoEmpresa, oei.idPlanoConta, oei.dtComp, oei.valor, oei.dtMov, oei.usuario from tborcamentoempresaitem oei";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoEmpresaItem>();
			while (rs.next()) {
				int idOrcamentoEmpresaItem = rs.getInt(1);
				int idOrcamentoEmpresa     = rs.getInt(2);
				int idPlanoConta       = rs.getInt(3);
				Date dtComp            = rs.getDate(4);
				double valor           = rs.getDouble(5);
				Date dtMov             = rs.getDate(6);
				String usuario         = rs.getString(7);

				list.add(new OrcamentoEmpresaItem(idOrcamentoEmpresaItem,
						idOrcamentoEmpresa, idPlanoConta, valor, dtMov,
						dtComp, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public List listarOrcamentoEmpresaItem(int idOrcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoEmpresaItem> list = null;
		
		try {
			String sql = " Select idOrcamentoEmpresaItem, idOrcamentoEmpresa, idPlanoConta, dtComp, YEAR(dtComp) as ano, sum(valor), dtMov, usuario "+ 
                         " from tborcamentoempresaitem "+
                         " where idOrcamentoEmpresa = ? " +
                         " group by idOrcamentoEmpresaItem, idOrcamentoEmpresa, idPlanoConta, YEAR(dtComp)";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoEmpresaItem>();
			while (rs.next()) {
				int idOrcamentoEmpresaItem = rs.getInt(1);
				int idPlanoConta       = rs.getInt(3);
				Date dtComp            = rs.getDate(4);
				double valor           = rs.getDouble(5);
				Date dtMov             = rs.getDate(6);
				String usuario         = rs.getString(7);

				list.add(new OrcamentoEmpresaItem(idOrcamentoEmpresaItem,
						idOrcamentoEmpresa, idPlanoConta, valor, dtMov,
						dtComp, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	
	public String dataAtual() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String dataAtual = "";
		
		try {
			String sql = "select now();";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				dataAtual = ConverteDate.dateToString(rs.getDate(1));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return dataAtual;
	}
	
	
	public List listarCabecalhoFrame(int idOrcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoEmpresaItem> list = null;
		
		try {
			String sql = " Select idOrcamentoEmpresaItem, idOrcamentoEmpresa, idPlanoConta, dtComp, YEAR(dtComp) as ano, sum(valor), dtMov, usuario "+ 
                         " from tborcamentoempresaitem "+
                         " where idOrcamentoEmpresa = ? " +
                         " group by idOrcamentoEmpresaItem, idOrcamentoEmpresa, idPlanoConta, YEAR(dtComp)";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoEmpresaItem>();
			while (rs.next()) {
				int idOrcamentoEmpresaItem = rs.getInt(1);
				int idPlanoConta       = rs.getInt(3);
				Date dtComp            = rs.getDate(4);
				double valor           = rs.getDouble(5);
				Date dtMov             = rs.getDate(6);
				String usuario         = rs.getString(7);

				list.add(new OrcamentoEmpresaItem(idOrcamentoEmpresaItem,
						idOrcamentoEmpresa, idPlanoConta, valor, dtMov,
						dtComp, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public List listarRelatorioOrcamentoEmpresaItem(int idOrcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RelatorioOrcamentoEmpresaItem> list = null;
		
		try {
			String sql = "Select p.dc, sum(valor), YEAR(oei.dtComp) as ano "+ 
					        " from tborcamentoempresaitem oei "+ 
                            " join tbplanoconta p on oei.idPlanoConta = p.idPlanoConta "+ 
                            " where oei.idOrcamentoEmpresa = ? "+
                            " group by p.dc, ano "+ 
                            " order by ano " ;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
			rs = ps.executeQuery();
			list = new ArrayList<RelatorioOrcamentoEmpresaItem>();
			while (rs.next()) {
				String dc = rs.getString(1);
				double valor = rs.getDouble(2);
				int ano = rs.getInt(3);

				list.add(new RelatorioOrcamentoEmpresaItem(dc, valor, ano));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public List listarRelatorioMesAnual(int idOrcamentoEmpresa, int ano) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RelatorioMesAnual> list = null;
		
		try {
			String sql = " Select p.dc, sum(valor), Month(oei.dtComp ) as mes "+
					       " from tborcamentoempresaitem oei "+ 
                           " join tbplanoconta p on oei.idPlanoConta = p.idPlanoConta "+ 
                           " where oei.idOrcamentoEmpresa = ? and YEAR(oei.dtComp) = ? "+
                           " group by p.dc, mes "+
                           " order by mes ";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
			ps.setInt(2, ano);
			rs = ps.executeQuery();
			list = new ArrayList<RelatorioMesAnual>();
			while (rs.next()) {
				String dc = rs.getString(1);
				float valor = rs.getFloat(2);
				int mes = rs.getInt(3);

				list.add(new RelatorioMesAnual(dc, valor, mes));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	
	public List listarRelatorioMes(int idOrcamentoEmpresa, int meses, int ano) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RelatorioMeses> list = null;
		
		try {
			String sql = " Select p.dc, valor, p.idPlanoConta, Month(oei.dtComp ) as mes "+ 
					          " from tborcamentoempresaitem oei "+ 
                              " join tbplanoconta p on oei.idPlanoConta = p.idPlanoConta "+ 
                              " where oei.idOrcamentoEmpresa = ? and YEAR(oei.dtComp) = ? and Month(oei.dtComp) = ? "+
				              " order by mes ";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
			ps.setInt(2, ano);
			ps.setInt(3, meses);
			rs = ps.executeQuery();
			list = new ArrayList<RelatorioMeses>();
			while (rs.next()) {
				String dc = rs.getString(1);
				float valor = rs.getFloat(2);
				int idPlanoConta = rs.getInt(3);
				int mes = rs.getInt(4);

				list.add(new RelatorioMeses(dc, valor, mes, idPlanoConta));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}

