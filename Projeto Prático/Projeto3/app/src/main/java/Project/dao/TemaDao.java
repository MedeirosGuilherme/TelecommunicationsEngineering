package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Project.ConnectionFactory;
import Project.entities.Tema;

public class TemaDao {

    public static Tema findById(int idTema) throws Exception{

        String query = "SELECT * FROM Tema WHERE idTema = ?";
        Tema tema = new Tema();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idTema);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    tema.setIdTema(rs.getInt("idTema"));
                    tema.setNome(rs.getString("nome"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return tema;
    }

    public static ArrayList<Tema> findByAll() throws Exception{

        String query = "SELECT * FROM Tema";
        ArrayList<Tema> lista = new ArrayList<>();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            ResultSet rs = stmt.executeQuery();

            if(rs.next()){
                do{
                    Tema tema = new Tema();
                    tema.setIdTema(rs.getInt("idTema"));
                    tema.setNome(rs.getString("nome"));
                    lista.add(tema);
                } while (rs.next());
            }

            rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return lista;
    }

    public static void insert(String nome){

        String query = "INSERT INTO Tema(nome) VALUES(?)";

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setString(1, nome);

            int i = stmt.executeUpdate();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

    }
    
}
