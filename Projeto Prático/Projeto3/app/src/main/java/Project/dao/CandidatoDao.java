package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Project.ConnectionFactory;
import Project.entities.Candidato;

public class CandidatoDao {
    
    final static String DB_URI = "jdbc:mysql://app/src/main/resources/database.sql";
    //db_uri jdbc:mysql:// + host + port + lab + ?user= + &password=

    public static Candidato findById(int idCandidato) throws Exception{

        String query = "SELECT * FROM Candidato WHERE idCandidato = ?";
        Candidato candidato = new Candidato();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idCandidato);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    candidato.setIdCandidato(rs.getInt("idCandidato"));
                    candidato.setNome(rs.getString("nome"));
                    candidato.setSenha(rs.getString("senha"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return candidato;
    }

    public static void insert(String nome, String senha){

        String query = "INSERT INTO Candidato(senha, nome) VALUES( ?, ?)";

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setString(1, senha);
            stmt.setString(2, nome);

            int i = stmt.executeUpdate();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

    }

}
