package teste;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;




public class CriaExcel {
	
	private static final String fileName = "C:/teste/novo.xls";
	
	public static void main(String[] args) throws IOException {

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheetAlunos = workbook.createSheet("Alunos");

        List<Aluno> listaAlunos = new ArrayList<Aluno>();
        listaAlunos.add(new Aluno("Eduardo", "9876525", 7, 8, 0, false));
        listaAlunos.add(new Aluno("Luiz", "1234466", 5, 8, 0, false));
        listaAlunos.add(new Aluno("Bruna", "6545657", 7, 6, 0, false));
        listaAlunos.add(new Aluno("Carlos", "3456558", 10, 3, 0, false));
        listaAlunos.add(new Aluno("Sonia", "6544546", 7, 8, 0, false));
        listaAlunos.add(new Aluno("Brianda", "3234535", 6, 5, 0, false));
        listaAlunos.add(new Aluno("Pedro", "4234524", 7, 5, 0, false));
        listaAlunos.add(new Aluno("Julio", "5434513", 7, 2, 0, false));
        listaAlunos.add(new Aluno("Henrique", "6543452", 7, 8, 0, false));
        listaAlunos.add(new Aluno("Fernando", "4345651", 5, 8, 0, false));
        listaAlunos.add(new Aluno("Vitor", "4332341", 7, 9, 0, false));

        int rownum = 0;
        for (Aluno aluno : listaAlunos) {
            Row row = sheetAlunos.createRow(rownum++);
            int cellnum = 0;
            Cell cellNome = row.createCell(cellnum++);
            cellNome.setCellValue(aluno.getNome());
            Cell cellRa = row.createCell(cellnum++);
            cellRa.setCellValue(aluno.getRa());
            Cell cellNota1 = row.createCell(cellnum++);
            cellNota1.setCellValue(aluno.getNota1());
            Cell cellNota2 = row.createCell(cellnum++);
            cellNota2.setCellValue(aluno.getNota2());
            Cell cellMedia = row.createCell(cellnum++);
            cellMedia.setCellValue((aluno.getNota1() + aluno.getNota2()) / 2);
            Cell cellAprovado =row.createCell(cellnum++);
            cellAprovado.setCellValue(cellMedia.getNumericCellValue() >= 6);
        }

        try {
            FileOutputStream out =
                    new FileOutputStream(new File(CriaExcel.fileName));
            workbook.write(out);
            out.close();
            System.out.println("Arquivo Excel criado com sucesso!");

        } catch (FileNotFoundException e) {
            e.printStackTrace();
               System.out.println("Arquivo não encontrado!");
        } catch (IOException e) {
            e.printStackTrace();
               System.out.println("Erro na edição do arquivo!");
        }

  }


}
