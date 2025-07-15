package util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;

public class ConverteDate {

	/**
	 * Formata uma String no formato "dd/MM/yyyy".
	 * @param data data a ser formatada
	 * @return Data no formato dd/MM/yyyy
	 */
	public static String formatarData(String data) throws Exception {
		if (data == null || data.equals(""))
			return null;
		String retorno = null;
		try {
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			Date date = (java.util.Date) df.parse(data);
			retorno = df.format(date);
		} catch (ParseException pe) {
			throw pe;
		}
		return retorno;
	}

	/**
	 * Converte um objeto Date para um objeto para um objeto java.sql.Date.
	 * @param data data a ser formatada
	 * @return data no formato ANSI SQL
	 */
	public static java.sql.Date DateToDateSql(Date data) throws Exception {
		if (data == null)
			return null;
		java.sql.Date retorno;
		try {
			retorno = java.sql.Date.valueOf(dateToStr(data, "yyyy-MM-dd"));
		} catch (IllegalArgumentException iae) {
			throw iae;
		}
		return retorno;
	}

	/**
	 * Converte um objeto Date para um objeto java.sql.Timestamp.
	 * @param data data a ser formatada
	 * @return data e hora no formato ANSI SQL
	 */
	public static java.sql.Timestamp DateToTimestamp(Date data)
			throws Exception {
		if (data == null)
			return null;
		java.sql.Timestamp retorno = null;
		retorno = new java.sql.Timestamp(data.getTime());
		return retorno;
	}

	/**
	 * Converte uma String para um objeto Date no formato "dd/MM/yyyy".
	 * @param data data a ser formatada
	 * @return Data no formato dd/MM/yyyy
	 */
	public static Date stringToDate(String data) throws Exception {
		if (data == null)
			return null;
		Date retorno = null;
		try {
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			long timestamp = df.parse(data).getTime();
			retorno = new Date(timestamp);
		} catch (ParseException pe) {
			throw pe;
		}
		return retorno;
	}

	/**
	 * Converte um objeto Date para uma String no formato "dd/MM/yyyy".
	 * @param data data a ser convertida
	 * @return data no formato dd/MM/yyyy
	 */
	public static String dateToString(Date data) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(data);
		return calendarToString(cal);
	}

	/**
	 * Converte um objeto Calendar para uma String no formato "dd/MM/yyyy".
	 * @param data data a ser convertida
	 * @return data no format dd/MM/yyyy
	 */
	public static String calendarToString(Calendar data) {
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		return sdf.format(data.getTime());
	}

	/**
	 * Converte uma String no formato "aaaa-mm-dd" para "dd/MM/yyyy".
	 * @param data Data a ser convertida
	 * @return Data no formato yyyy-MM-dd
	 */
	public static String YMDToDMY(String data) {
		return data.substring(8, 10) + "/" + data.substring(5, 7) + "/"
				+ data.substring(0, 4);
	}

	/**
	 * Converte uma String no formato "dd/MM/yyyy" para "yyyy-MM-dd".
	 * @param data Data a ser convertida
	 * @return Data no formato yyyy/MM/dd
	 */
	public static String DMYToYMD(String data) {
		return data.substring(8, 10) + "/" + data.substring(5, 7) + "/"
		+ data.substring(0, 4);
	}
	public static String DMYToYMDI(String data) {
		return data.substring(6,10) + "-" + data.substring(3, 5) + "-"
				+ data.substring(0, 2);
	}

	/**
	 * Converte um objeto Date para uma String no formato qualquer.
	 * @param data data a ser convertida
	 * @param format formato de data a ser convertida
	 * @return data no formato especificado
	 */
	public static String dateToStr(Date date, String format) {
		String retorno = null;
		if ((null != date) && (null != format)) {
			SimpleDateFormat formater = new SimpleDateFormat(format);
			retorno = formater.format(date);
		}
		return retorno;
	}
	
	public static String formatarSomaData(String data){
		String dataFormatada= null;
		String dia = null;
		String mes = null;
		String ano = null;
		ano = data.substring(0,3);
		mes = data.substring(4, 5);
		dia = data.substring(6, 7);
		dataFormatada = dia+"/"+mes+"/"+ano;
		return dataFormatada;
		
	}

}
