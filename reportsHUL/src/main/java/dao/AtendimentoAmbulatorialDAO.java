package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.AferoDAOException;
import util.ConverteDate;
import model.AtendimentoAmbulatorial;
public class AtendimentoAmbulatorialDAO {
	
	
	private Connection conn;

	public AtendimentoAmbulatorialDAO(Connection conn) {
		this.conn = conn;
	}
	
	
	public List getAtendimentoAmbulatorialDAO(String dataInicial, String dataFinal) throws Exception {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<AtendimentoAmbulatorial> list = null;

		try {
			String sql = "SELECT tbmed.siglaesp as siglaEsp, tbmed.profissional, tbmed.paciente as codPaciente,"
					+ "            to_char(pac.dt_nascimento, 'DD-MM-YYYY') as dtNascimento,"
					+ "            pac.sexo,"
					+ "            cid_pac_not.uf_sigla as uf,  cid_pac_not.nome, tbmed.num_consulta_med as numConsultaMed,"
					+ "            to_char(tbmed.marcacao_med, 'DD-MM-YYYY HH24:MI') as marcacaoMed,"
					+ "            to_char(tbmed.inicio_con_med, 'DD-MM-YYYY HH24:MI') as inicioConMed,"
					+ "            to_char(tbmed.fim_con_med, 'DD-MM-YYYY HH24:MI') as fimConMed,"
					+ "            pac.prontuario as pacProntuario, pac.codigo as pacCodigo, pac.nome as pacNome,"
					+ "            to_char(age(inicio_con_med, marcacao_med),'HH24:MI:SS') as tempoEspera,"
					+ "            to_char(age(fim_con_med, inicio_con_med),'HH24:MI:SS') as tempoAtendimento"
					+ "            from (select distinct esp.sigla as siglaesp, pessoa.nome as profissional, con.numero as num_consulta_med,"
					+ "            con.dt_consulta as marcacao_med,"
					+ "            con.dthr_inicio as inicio_con_med,"
					+ "            con.dthr_fim as fim_con_med,"
					+ "            con.pac_codigo as paciente, esp.sigla, '' as anamnese"
					+ "            from"
					+ "            agh.aac_consultas con"
					+ "            inner join agh.mam_controles ctl on con.numero = ctl.con_numero"
					+ "            inner join agh.mam_extrato_controles ext on ctl.seq = ext.ctl_seq"
					+ "            inner join agh.aac_grade_agendamen_consultas grade on ( con.grd_seq = grade.seq )"
					+ "            inner join agh.agh_especialidades esp on ( grade.esp_seq = esp.seq )"
					+ "            inner join agh.agh_equipes eqp on ( grade.eqp_seq = eqp.seq )"
					+ "            left outer join agh.rap_servidores serv on ext.ser_matricula = serv.matricula and ext.ser_vin_codigo = serv.vin_codigo"
					+ "            left outer join agh.rap_pessoas_fisicas pessoa on serv.pes_codigo = pessoa.codigo"
					+ "            where esp.sigla not in ('UPE', 'EFE')"
					+ "            and con.dthr_fim is not null"
					+ "            and ext.sat_seq = '7'"
					+ "            and grade.usl_unf_seq = 33"
					+ "            and ctl.ind_situacao = 'L'"
					+ "            and con.dt_consulta between ? and ?)  tbmed"
					+ "            left join agh.aip_pacientes pac on pac.codigo = tbmed.paciente"
					+ "            left join agh.aip_enderecos_pacientes endp on endp.pac_codigo = pac.codigo"
					+ "            left join agh.aip_enderecos_pacientes end_pac on pac.codigo = end_pac.pac_codigo"
					+ "            left join agh.aip_cidades end_cid_pac on end_pac.cdd_codigo = end_cid_pac.codigo"
					+ "            left join agh.aip_bairros bai_pac on end_pac.bcl_bai_codigo = bai_pac.codigo"
					+ "            left join agh.aip_logradouros logr_pac on end_pac.bcl_clo_lgr_codigo = logr_pac.codigo"
					+ "            left join agh.aip_cidades cid_pac on logr_pac.cdd_codigo = cid_pac.codigo"
					+ "            left join agh.aip_cidades cid_pac_not on end_pac.cdd_codigo = cid_pac_not.codigo"
					+ "            order by marcacao_med desc;";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setDate(1, ConverteDate.DateToDateSql(ConverteDate.stringToDate(dataInicial)));
			ps.setDate(2, ConverteDate.DateToDateSql(ConverteDate.stringToDate(dataFinal)));
			rs = ps.executeQuery();
			list = new ArrayList<AtendimentoAmbulatorial>();
			while (rs.next()) {
				
				String siglaEsp = rs.getString(1);
				String profissional = rs.getString(2);
				Integer codPaciente =rs.getInt(3);
				String dtNascimento= rs.getString(4);
				String sexo = rs.getString(5);
				String uf= rs.getString(6);
				String cidade= rs.getString(7);
				Integer numConsulta = rs.getInt(8);
				String marcacaoMedica = rs.getString(9);
				String iniConMed = rs.getString(10);
				String fimConMed = rs.getString(11);
				Integer pacProntuario  = rs.getInt(12);
				Integer pacCodigo  = rs.getInt(13);
				String paciente = rs.getString(14);
				String tempoEspera = rs.getString(15);
				String tempoAtendimento = rs.getString(16);
				
				list.add(new AtendimentoAmbulatorial(siglaEsp, profissional, codPaciente, dtNascimento,
						sexo, uf, cidade, numConsulta, marcacaoMedica, iniConMed,
						fimConMed, pacProntuario, pacCodigo, paciente, tempoEspera,
						tempoAtendimento));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return list;
	}
	

}
