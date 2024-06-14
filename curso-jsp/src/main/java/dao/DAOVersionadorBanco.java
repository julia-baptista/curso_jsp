package dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import connection.SingleConnectionBanco;

public class DAOVersionadorBanco implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Connection connection;

	public DAOVersionadorBanco() {
		this.connection = SingleConnectionBanco.getConnection();
	}
	
	public void gravaArquivoSqlRodado (String nome_do_arquivo) throws Exception {
		
		String sql = "insert into versionadorbanco(arquivo_sql) values (?)";
		
		PreparedStatement preparedSql = connection.prepareStatement(sql);
		
		preparedSql.setString(1, nome_do_arquivo);
		
		preparedSql.execute();
	}
	
	
	public boolean arquivoSqlRodado (String nome_do_arquivo) throws Exception {
		
		String sql = "select count(1) > 0 as rodado from versionadorbanco where arquivo_sql = ?";
		
		PreparedStatement preparedSql = connection.prepareStatement(sql);
		
		preparedSql.setString(1, nome_do_arquivo);
		
		ResultSet resultSet = preparedSql.executeQuery();
		
		resultSet.next();
		
		return resultSet.getBoolean("rodado");
	}

}
