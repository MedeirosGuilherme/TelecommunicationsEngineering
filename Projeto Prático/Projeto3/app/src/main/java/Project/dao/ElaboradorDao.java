package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Project.ConnectionFactory;
import Project.entities.Elaborador;

public class ElaboradorDao {

    public static Elaborador findById(int idElaborador) throws Exception{

        String query = "SELECT * FROM Elaborador WHERE idElaborador = ?";
        Elaborador elaborador = new Elaborador();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idElaborador);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    elaborador.setIdElaborador(rs.getInt("idElaborador"));
                    elaborador.setNome(rs.getString("nome"));
                    elaborador.setSenha(rs.getString("senha"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return elaborador;
    }

    public static void insert(String nome, String senha){

        String query = "INSERT INTO Elaborador(senha, nome) VALUES( ?, ?)";

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
