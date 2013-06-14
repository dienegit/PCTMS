package com.course.db;

import java.sql.*;

public class DataBaseConnection // �������ݿ⡢�ر����ݿ�
{
	private final String DBDRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private final String DBURL = "jdbc:sqlserver://localhost:1433;DatabaseName=course";
	private final String DBUSER = "sa";
	private final String DBPASSWORD = "123";
	private Connection conn = null;

	public DataBaseConnection() {
		try {
			Class.forName(DBDRIVER);
			this.conn = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
		} catch (Exception e) {
		}
	}

	public Connection getConnection() // ȡ�����ݿ�����
	{
		return this.conn;
	}

	public void close() // �ر����ݿ�����
	{
		try {
			this.conn.close();
		} catch (Exception e) {
		}
	}
};