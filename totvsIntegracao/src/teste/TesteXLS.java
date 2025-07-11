package teste;


import  java.io.*;
import  org.apache.poi.hssf.usermodel.HSSFSheet;
import  org.apache.poi.hssf.usermodel.HSSFWorkbook;
import  org.apache.poi.hssf.usermodel.HSSFRow;
import  org.apache.poi.hssf.usermodel.HSSFCell;

public class TesteXLS{ // classe que gera o arquivo
 public static void main(String[]args){
     try{
        // local do arquivo
        String filename="C:/teste/NewExcelFile.xls" ;
        HSSFWorkbook workbook=new HSSFWorkbook();
        HSSFSheet sheet =  workbook.createSheet("FirstSheet");  
        // criando as linhas
        HSSFRow rowhead=   sheet.createRow((short)0);
        rowhead.createCell(0).setCellValue("protocolo");
        rowhead.createCell(1).setCellValue("codigonumerico");
        // definindo seus valores
        // por exemplo protocolo.getProtocolo();
        HSSFRow row=   sheet.createRow((short)1);
        row.createCell(0).setCellValue("TESTE 2");
        row.createCell(1).setCellValue("TESTE 3");

        FileOutputStream fileOut =  new FileOutputStream(filename);
        workbook.write(fileOut);
        fileOut.close();
        System.out.println("Seu arquivo excel foi gerado!");

} catch ( Exception ex ) {
    System.out.println(ex);

}
   }
}

