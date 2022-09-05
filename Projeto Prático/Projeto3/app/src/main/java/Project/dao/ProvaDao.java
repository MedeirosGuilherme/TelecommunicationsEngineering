package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Project.ConnectionFactory;
import Project.entities.Prova;

public class ProvaDao {

    public static Prova findById(int idProva) throws Exception{

        String query = "SELECT * FROM Prova WHERE idProva = ?";
        Prova prova = new Prova();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idProva);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    prova.setIdProva(rs.getInt("idProva"));
                    prova.setIdGestor(rs.getInt("Gestor_idGestor"));

                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return prova;
    }

    public static void insert(int idGestor){

        String query = "INSERT INTO Prova(Gestor_idGestor) VALUES(?);";

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idGestor);

            int i = stmt.executeUpdate();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

    }

    public static Prova selectMaxProva(){
        Prova prova = new Prova();
        String query = "SELECT * FROM Prova p WHERE p.idProva IN(SELECT MAX(idProva) FROM Prova)";
        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    prova.setIdProva(rs.getInt("idProva"));
                    prova.setIdGestor(rs.getInt("Gestor_idGestor"));

                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

        return prova;
    }
    
}
