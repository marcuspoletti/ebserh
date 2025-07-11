package afero.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class Extenso {

	/**
	 * Criada por: Sérgio José Fontes Sobral
	 * 
	 * 
	 * Data: 11/05/2011
	 */

	private static String ext_aux(int v) {
		int centena = 0;
		int dezena = 0;
		int unidade = 0;
		String retorno = "";
		String sTmp = "";
		String tab_unidades[] = { "um", "dois", "três", "quatro", "cinco",
				"seis", "sete", "oito", "nove", "dez", "onze", "doze", "treze",
				"quatorze", "quinze", "dezesseis", "dezessete", "dezoito",
				"dezenove" };
		String tab_dezenas[] = { "vinte", "trinta", "quarenta", "cinquenta",
				"sessenta", "setenta", "oitenta", "noventa" };
		String tab_centenas[] = { "duzentos", "trezentos", "quatrocentos",
				"quinhentos", "seiscentos", "setecentos", "oitocentos",
				"novecentos" };
		String df = new DecimalFormat("000").format(v);
		if (v >= 100) {
			centena = Integer.parseInt(df.substring(0, 1));
		}
		if (Integer.parseInt(df.substring(1, 3)) >= 20) {
			dezena = Integer.parseInt(df.substring(1, 2));
			unidade = Integer.parseInt(df.substring(2, 3));
		} else {
			unidade = Integer.parseInt(df.substring(1, 3));
		}

		if (unidade > 0) {
			retorno = tab_unidades[unidade - 1];
		}
		if (dezena > 0) {
			sTmp = tab_dezenas[dezena - 2];
			if (!retorno.equals(""))
				retorno = sTmp + " e " + retorno;
			else
				retorno = sTmp + retorno;
		}
		if (centena > 0) {
			if (centena == 1)
				if (unidade != 0 || dezena != 0)
					sTmp = "cento";
				else
					sTmp = "cem";
			else
				sTmp = tab_centenas[centena - 2];
			if (!retorno.equals(""))
				retorno = sTmp + " e " + retorno;
			else
				retorno = sTmp;
		}
		return (retorno);
	}

	public static String toString(BigDecimal dec) {
		String singular = "real";
		String plural = "reais";
		String sValor = new DecimalFormat("000000000000000.00").format(dec);
		int Centavos = Integer.parseInt(sValor.substring(16, 18));
		int Centenas = Integer.parseInt(sValor.substring(12, 15));
		int Milhares = Integer.parseInt(sValor.substring(9, 12));
		int Milhoes = Integer.parseInt(sValor.substring(6, 9));
		int Bilhoes = Integer.parseInt(sValor.substring(3, 6));
		int Trilhoes = Integer.parseInt(sValor.substring(0, 3));
		int key = 0;
		String sExtenso = "";
		String sTmp = "";

		if (Trilhoes > 0) {
			key = 1;
			if (Trilhoes == 1)
				sExtenso += "hum trilhão";
			else {
				if (!sExtenso.equals(""))
					sExtenso += ", ";
				sExtenso += ext_aux(Trilhoes) + " trilhões";
			}
		}

		if (Bilhoes > 0) {
			key = 1;
			if (Bilhoes == 1)
				sExtenso += "hum bilhão";
			else {
				if (!sExtenso.equals(""))
					sExtenso += ", ";
				sExtenso += ext_aux(Bilhoes) + " bilhões";
			}
		}

		if (Milhoes > 0) {
			key = 1;
			if (Milhoes == 1)
				sExtenso += "hum milhão";
			else {
				if (!sExtenso.equals(""))
					sExtenso += ", ";
				sExtenso += ext_aux(Milhoes) + " milhões";
			}
		}

		if (Milhares > 0) {
			key = 0;
			if (Milhares == 1)
				sExtenso += "hum mil";
			else {
				if (!sExtenso.equals(""))
					sExtenso += ", ";
				sExtenso += ext_aux(Milhares) + " mil";
			}
		}

		if (Centenas > 0) {
			key = 0;
			sTmp = ext_aux(Centenas);
			if (!sExtenso.equals("")) {
				if (Centenas <= 100)
					sExtenso += " e ";
				else
					sExtenso += ", ";
				sExtenso += sTmp;
			} else
				sExtenso += sTmp;
		}
		if (!sExtenso.equals("")) {
			if (key != 0)
				sExtenso += " de";
			if (sExtenso.equals("um") && sExtenso.length() == 2)
				sExtenso += " " + singular;
			else
				sExtenso += " " + plural;
		}
		if (Centavos > 0) {
			if (Centavos == 1)
				sTmp = "um centavo";
			else {
				sTmp = ext_aux(Centavos) + " centavos";
			}
			if (!sExtenso.equals(""))
				sExtenso += " e ";
			sExtenso += sTmp;

		}

		return (sExtenso);

	}

	public static String toString(double dec) {
		return (toString(new BigDecimal(dec)));
	}
}
