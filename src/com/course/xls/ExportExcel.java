package com.course.xls;

import java.io.*;
import jxl.*;
import jxl.write.*;

public class ExportExcel {

	private static String[][] table;
	private static int row;
	private static int col;

	public void setTable(String[][] table) {
		ExportExcel.table = table;
	}

	public void setRow(int row) {
		ExportExcel.row = row;
	}

	public void setCol(int col) {
		ExportExcel.col = col;
	}

	public static void writeExcel(OutputStream os) throws Exception {
		WritableWorkbook wwb = Workbook.createWorkbook(os);
		WritableSheet ws = wwb.createSheet("成绩单", 0);
		Label labelC;
		for (int i = 0; i < row; i++) {
			for (int j = 0; j < col; j++) {
				labelC = new jxl.write.Label(j, i, table[i][j]);
				ws.addCell(labelC);
			}
		}
		wwb.write(); // 写入Excel工作表
		wwb.close(); // 关闭Excel工作薄对象
	}
}
