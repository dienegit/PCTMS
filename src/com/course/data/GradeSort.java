package com.course.data;

public class GradeSort {
	private String[][] gradetable;
	private String[][] colortable;
	private int col;

	public void setGradetable(String[][] table) {
		this.gradetable = table;
	}

	public void setColortable(String[][] colortable) {
		this.colortable = colortable;
	}

	public void setCol(int col) {
		this.col = col;
	}

	public int getCol() {
		return col;
	}

	public String[][] getColortable() {
		return colortable;
	}

	public String[][] getGradetable() {
		return gradetable;
	}

	public String[][] newGradetable() {
		int k;
		String[] temp = new String[gradetable.length];
		String[] temp2 = new String[gradetable.length];
		for (int i = 1; i < gradetable.length - 1; i++) {
			k = i;
			for (int j = k + 1; j < gradetable.length - 1; j++) {
				if (Float.parseFloat(gradetable[j][col]) > Float
						.parseFloat(gradetable[k][col]))
					k = j;
			}
			if (k != i) {
				temp = gradetable[i];
				gradetable[i] = gradetable[k];
				gradetable[k] = temp;
				temp2 = colortable[i];
				colortable[i] = colortable[k];
				colortable[k] = temp2;
			}
		}
		return gradetable;
	}

	public String[][] newColortable() {
		return colortable;
	}

}
