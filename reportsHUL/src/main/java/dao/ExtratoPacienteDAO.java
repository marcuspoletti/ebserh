package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.AferoDAOException;
import util.ConverteDate;
import model.ExtratoPaciente;
public class ExtratoPacienteDAO {
	
	
	private Connection conn;

	public ExtratoPacienteDAO(Connection conn) {
		this.conn = conn;
	}
	
	
	public List getExtratoPacienteDAO(String dataInicial, String dataFinal) throws Exception {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ExtratoPaciente> list = null;

		try {
			String sql = "select "
					+ "case "
					+ " when b.grau_instrucao = 1 then '1° Grau Completo'"
					+ " when b.grau_instrucao = 2 then '2° Grau Completo'"
					+ " when b.grau_instrucao = 3 then 'Superior'"
					+ " when b.grau_instrucao = 4 then 'Nenhum'"
					+ " when b.grau_instrucao = 5 then 'Ignorado'"
					+ " when b.grau_instrucao = 6 then '1° Grau Incompleto'"
					+ " when b.grau_instrucao = 7 then '2° Grau Incompleto'"
					+ " when b.grau_instrucao = 8 then 'Superior Incompleto'"
					+ "            else ''"
					+ " end as grauInstrucao, "
					+ "             case "
					+ " when b.cor = 'B' then 'Branca'"
					+ " when b.cor = 'P' then 'Preta'"
					+ " when b.cor = 'M' then 'Parda'"
					+ " when b.cor = 'A' then 'Amarela'"
					+ " when b.cor = 'I' then 'Indígena'"
					+ " when b.cor = 'O' then 'Sem Declaração'"
					+ "             else ''"
					+ " end as cor, "
					+ "             case"
					+ " when b.estado_civil = 'C' then 'Casado'"
					+ " when b.estado_civil = 'S' then 'Solteiro'"
					+ " when b.estado_civil = 'P' then 'Separado'"
					+ " when b.estado_civil = 'D' then 'Desquitado ou separado judicialmente'"
					+ " when b.estado_civil = 'U' then 'União Estável'"
					+ " when b.estado_civil = 'V' then 'Viúvo' "
					+ " when b.estado_civil = 'O' then 'Outros' "
					+ "  			else ''"
					+ " end as estado_civil,"
					+ " cid.codigo AS cidPrimario,"
					+ " cid.descricao AS cid,"
					+ " f.nome_especialidade as nomeEspecialidade,"
					+ " e.descricao as unidadeFuncional,"
					+ " (select auf.descricao from agh.ain_movimentos_internacao ami "
					+ " left join agh.agh_unidades_funcionais auf on ami.unf_seq = auf.seq "
					+ " where ami.int_seq = g.int_seq and ami.criado_em < g.criado_em "
					+ " order by ami.criado_em desc "
					+ " limit 1) as unidadeAnterior, "
					+ " h.descricao as tpMovimentoInternacao, "
					+ "  b.prontuario , "
					+ "  b.nome, "
					+ "  b.sexo, "
					+ "  CAST (dt_nascimento AS VARCHAR (10)) as dtNascimento, "
					+ "  CAST (dthr_lancamento AS VARCHAR (10)) as dtLancamento, "
					+ " CAST (dthr_internacao AS VARCHAR (10)) as dtInternacao,"
					+ " CAST (dthr_alta_medica AS VARCHAR (10)) as dtAltaMedica,"
					+ " c.descricao as motAlta,"
					+ " to_char(g.dthr_lancamento,'YYYY-MM-DD HH24:MI') as dtHrLancamento,"
					+ " g.lto_lto_id as ltoLtoId,"
					+ " g.int_seq as intSeq,"
					+ " g.seq,"
					+ " to_char(dthr_internacao,'YYYY-MM-DD HH24:MI') as dtHrInternacao,"
					+ " to_char(dthr_alta_medica,'YYYY-MM-DD HH24:MI') as dtHrAltaMedica,"
					+ " to_char(dt_saida_paciente,'YYYY-MM-DD HH24:MI') as dtSaidaPaciente,"
					+ " proced.cod_tabela as codProcedimento ,"
					+ " proced.descricao as procedimento,"
					+ " to_char(EXTRACT(YEAR FROM age(dthr_internacao, dt_nascimento)), '999') as idade,"
					+ " cidade.nome as cidade,"
					+ " cidade.uf_sigla as estado "
					+ " from agh.ain_internacoes a join agh.aip_pacientes b on a.pac_codigo = b.codigo"
					+ " left join agh.fat_itens_proced_hospitalar proced on a.iph_seq = proced.seq"
					+ " left join agh.ain_tipos_alta_medica c on a.tam_codigo = c.codigo"
					+ " left join agh.ain_leitos d on a.lto_lto_id = d.lto_id"
					+ " join agh.ain_movimentos_internacao g on a.seq = g.int_seq"
					+ " join agh.ain_tipos_mvto_internacao h on g.tmi_seq = h.seq"
					+ " join agh.agh_especialidades f on g.esp_seq = f.seq"
					+ " join agh.agh_unidades_funcionais e on g.unf_seq = e.seq"
					+ " LEFT JOIN agh.ain_cids_internacao int_cid ON a.seq = int_cid.int_seq"
					+ "  AND int_cid.ind_prioridade_cid = 'P'"
					+ " LEFT JOIN agh.ain_cids_internacao int_cids ON a.seq = int_cids.int_seq"
					+ " AND int_cids.ind_prioridade_cid = 'S'"
					+ " JOIN agh.agh_cids cid ON int_cid.cid_seq = cid.seq LEFT"
					+ " JOIN agh.agh_cids cids ON int_cids.cid_seq = cids.seq"
					+ " JOIN agh.aip_enderecos_pacientes ende ON b.codigo = ende.pac_codigo AND ende.tipo_endereco = 'R'"
					+ " LEFT JOIN agh.aip_cidades cidade ON cidade.codigo = ende.cdd_codigo"
					+ " where (dthr_alta_medica is null or dthr_alta_medica >= ? "
					+ " and dthr_internacao <= ? )"
					+ " order by g.dthr_lancamento, b.nome "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setDate(1, ConverteDate.DateToDateSql(ConverteDate.stringToDate(dataInicial)));
			ps.setDate(2, ConverteDate.DateToDateSql(ConverteDate.stringToDate(dataFinal)));
			rs = ps.executeQuery();
			list = new ArrayList<ExtratoPaciente>();
			while (rs.next()) {
				
				String grauInstrucao = rs.getString(1);
				String cor = rs.getString(2);
				String estado_civil = rs.getString(3);
				String cidPrimario = rs.getString(4);
				String cid = rs.getString(5);
				String nomeEspecialidade = rs.getString(6);
				String unidadeFuncional = rs.getString(7);
				String unidadeAnterior = rs.getString(8);
				String tpMovimentoInternacao = rs.getString(9);
				Integer prontuario = rs.getInt(10);
				String nome = rs.getString(11);
				String sexo = rs.getString(12);
				String dtNascimento = rs.getString(13);
				String dtLancamento = rs.getString(14);
				String dtInternacao = rs.getString(15);
				String dtAltaMedica = rs.getString(16);
				String motAlta = rs.getString(17);
				String dtHrLancamento = rs.getString(18);
				String ltoLtoId = rs.getString(19);
				Integer intSeq = rs.getInt(20);
				Integer seq = rs.getInt(21);
				String dtHrInternacao = rs.getString(22);
				String dthaltamedica = rs.getString(23);
				String dtSaidaPaciente = rs.getString(24);
				Integer codProcedimento = rs.getInt(25);
				String procedimento = rs.getString(26);
				String idade = rs.getString(27);
				String cidade = rs.getString(28);
				String estado = rs.getString(29);
				
				list.add(new ExtratoPaciente(grauInstrucao, cor, estado_civil, cidPrimario, cid,
						nomeEspecialidade, unidadeFuncional, unidadeAnterior, tpMovimentoInternacao,
						prontuario, nome, sexo, dtNascimento, dtLancamento, dtInternacao,
						dtAltaMedica, motAlta, dtHrLancamento, ltoLtoId, intSeq, seq,
						dtHrInternacao, dthaltamedica, dtSaidaPaciente, codProcedimento,
						procedimento, idade, cidade, estado));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return list;
	}
	

}
