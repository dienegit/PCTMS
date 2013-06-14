package com.course.db;

import java.sql.*;

public class DataBaseConnection // 连接数据库、关闭数据库
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

	public Connection getConnection() // 取得数据库连接
	{
		return this.conn;
	}

	public void close() // 关闭数据库连接
	{
		try {
			this.conn.close();
		} catch (Exception e) {
		}
	}
};