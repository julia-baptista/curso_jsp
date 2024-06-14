package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelTelefone;

public class DAOTelefoneRepository {
	private Connection connection;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

	public DAOTelefoneRepository() {
		this.connection = SingleConnectionBanco.getConnection();
				
	}
	
	
	public List<ModelTelefone> listFone(Long idUserPai) throws Exception  {
		
		List<ModelTelefone> retorno = new ArrayList<ModelTelefone>();
		
		String sql = "select * from telefone where usuario_pai_id =?";
		
		PreparedStatement preparedSql = connection.prepareStatement(sql);
		
		preparedSql.setLong(1, idUserPai);
		
		ResultSet rs =  preparedSql.executeQuery();
		
		while(rs.next()) {
			
			ModelTelefone modelTelefone = new ModelTelefone();
			
			modelTelefone.setId(rs.getLong("id"));
			modelTelefone.setNumero(rs.getString("numero"));
			modelTelefone.setUsuario_pai_id(daoUsuarioRepository.consultaUsuarioID(rs.getLong("usuario_pai_id")));
			modelTelefone.setUsuario_cad_id(daoUsuarioRepository.consultaUsuarioID(rs.getLong("usuario_cad_id")));
			
			retorno.add(modelTelefone);
		}
		
		
		return retorno;
	}
	
	
	 public void gravaTelefone(ModelTelefone modelTelefone) throws Exception {
		 
		 String sql = "insert into telefone (numero, usuario_pai_id, usuario_cad_id) values (?, ?, ?)";
		 
		 PreparedStatement preparedSql = connection.prepareStatement(sql);
		 
		 preparedSql.setString(1, modelTelefone.getNumero());
		 preparedSql.setLong(2, modelTelefone.getUsuario_pai_id().getId());
		 preparedSql.setLong(3, modelTelefone.getUsuario_cad_id().getId());
		 
		 preparedSql.execute();
		 
		 connection.commit();
	 }
	 
	 public void deleteFone(Long id) throws Exception {
		 
		 String sql = "delete from telefone where id =?";
		 
		 PreparedStatement preparedSql = connection.prepareStatement(sql);
		 
		 preparedSql.setLong(1, id);
		 
		 preparedSql.executeUpdate();
		 
		 connection.commit();	 
		 
	 }
	 
	 public boolean existeFone(String fone, Long idUser) throws Exception {
		 String sql = "select count(1) > 0 as existe from telefone where usuario_pai_id =? and numero =?";
		 
		 PreparedStatement preparedSql = connection.prepareStatement(sql);
		 
		 preparedSql.setLong(1, idUser);
		 preparedSql.setString(2, fone);
		 
		 
		 ResultSet resultSet = preparedSql.executeQuery();
		 
		 resultSet.next();
		 
		 return resultSet.getBoolean("existe");
		 
		 
	 }
	
}
