package com.course.data;

import java.io.*;
import java.text.*;
import java.util.*;

public class WriteLog {
	private String log = null;
	private String path = null;
	
	public void setLog(String log) {
		this.log = log;
	}

	public String getLog() {
		return log;
	}
	
	public void setPath(String path) {
		this.path = path;
	}

	public String getPath() {
		return path;
	}
	
	public void writeFile() {
		File writefile;
		try {
			Calendar a = Calendar.getInstance();
			Date now = a.getTime();
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			writefile = new File(path + "\\" + date.format(now) + ".txt");

			// 如果文本文件不存在则创建它
			if (writefile.exists() == false) {
				writefile.createNewFile();
				writefile = new File(path + "\\" + date.format(now) + ".txt"); // 重新实例化
			}

			FileOutputStream fw = new FileOutputStream(writefile, true);
			log = time.format(now) + log + "\r\n";
			fw.write(log.getBytes());
			fw.flush();
			fw.close();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}

	}

}
