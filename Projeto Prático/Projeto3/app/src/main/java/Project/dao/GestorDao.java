package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Project.ConnectionFactory;
import Project.entities.Gestor;

public class GestorDao {

    public static Gestor findById(int idGestor) throws Exception{

        String query = "SELECT * FROM Gestor WHERE idGestor = ?";
        Gestor gestor = new Gestor();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idGestor);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    gestor.setIdGestor(rs.getInt("idGestor"));
                    gestor.setNome(rs.getString("nome"));
                    gestor.setSenha(rs.getString("senha"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return gestor;
    }
    
}
