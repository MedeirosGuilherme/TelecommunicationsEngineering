package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Project.ConnectionFactory;
import Project.entities.Gabarito;

public class GabaritoDao {

    public static Gabarito findByProcessoId(int id, int idCandidato) throws Exception{

        String query = "SELECT * FROM Gabarito WHERE ProcessoSeletivo_idProcessoSeletivo = ? AND Candidato_idCandidato = ?";
        Gabarito gabarito = new Gabarito();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, id);
            stmt.setInt(2, idCandidato);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    gabarito.setIdGabarito(rs.getInt("idGabarito"));
                    gabarito.setGabarito(rs.getString("gabarito"));
                    gabarito.setIdCandidato(rs.getInt("Candidato_idCandidato"));
                    gabarito.setProcessoId(rs.getInt("ProcessoSeletivo_idProcessoSeletivo"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return gabarito;
    }

    public static ArrayList<Gabarito> findGabaritoByIdCandidato(int idCandidato){
        ArrayList<Gabarito> lista = new ArrayList<>();
        
        String query = "SELECT * FROM Gabarito WHERE Candidato_idCandidato = ?";
        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idCandidato);
            ResultSet rs = stmt.executeQuery();

            if(rs.next()){
                do{
                    Gabarito gabarito = new Gabarito();
                    gabarito.setIdGabarito(rs.getInt("idGabarito"));
                    gabarito.setGabarito(rs.getString("gabarito"));
                    gabarito.setIdCandidato(rs.getInt("Candidato_idCandidato"));
                    gabarito.setProcessoId(rs.getInt("ProcessoSeletivo_idProcessoSeletivo"));
                    lista.add(gabarito);
                } while (rs.next());
            }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

        return lista;
    }

    public static void insert(String gabarito, int Candidato_idCandidato, int ProcessoSeletivo_idProcessoSeletivo){

        String query = "INSERT INTO Gabarito(gabarito, Candidato_idCandidato, ProcessoSeletivo_idProcessoSeletivo) VALUES( ?, ?, ?)";

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setString(1, gabarito);
            stmt.setInt(2, Candidato_idCandidato);
            stmt.setInt(3, ProcessoSeletivo_idProcessoSeletivo);


            int i = stmt.executeUpdate();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

    }
    
}
