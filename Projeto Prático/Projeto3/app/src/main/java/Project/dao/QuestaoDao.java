package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Project.ConnectionFactory;
import Project.entities.Questao;

public class QuestaoDao {

    public static Questao findById(int idQuestao) throws Exception{

        String query = "SELECT * FROM Questao WHERE idQuestao = ?";
        Questao questao = new Questao();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idQuestao);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){

                    questao.setIdQuestao(rs.getInt("idQUestao"));
                    questao.setDescricao(rs.getString("descricao"));
                    questao.setAltA(rs.getString("altA"));
                    questao.setAltB(rs.getString("altB"));
                    questao.setAltC(rs.getString("altC"));
                    questao.setAltD(rs.getString("altD"));
                    questao.setAltCerta(rs.getString("altCerta"));
                    questao.setDificuldade(rs.getInt("dificuldade"));
                    questao.setIdElaborador(rs.getInt("Elaborador_idElaborador"));
                    questao.setIdTema(rs.getInt("Tema_idTema"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return questao;
    }

    public static ArrayList<Questao> findByTema(int idTema) throws Exception{
        ArrayList<Questao> lista = new ArrayList<>();
        String query = "SELECT * FROM Questao WHERE Tema_idTema = ?";
        
        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idTema);
            ResultSet rs = stmt.executeQuery();

                if(rs.next()){
                    do{
                    Questao questao = new Questao();
                    questao.setIdQuestao(rs.getInt("idQUestao"));
                    questao.setDescricao(rs.getString("descricao"));
                    questao.setAltA(rs.getString("altA"));
                    questao.setAltB(rs.getString("altB"));
                    questao.setAltC(rs.getString("altC"));
                    questao.setAltD(rs.getString("altD"));
                    questao.setAltCerta(rs.getString("altCerta"));
                    questao.setDificuldade(rs.getInt("dificuldade"));
                    questao.setIdElaborador(rs.getInt("Elaborador_idElaborador"));
                    questao.setIdTema(rs.getInt("Tema_idTema"));
                    lista.add(questao);

                } while(rs.next());
            }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }


        return lista;
    }

    public static void insert(String descricao, String altA, String altB, String altC, String altD, String altCerta, int dificuldade, int Elaborador_idElaborador, int Tema_idTema){

        String query = "INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setString(1, descricao);
            stmt.setString(2, altA);
            stmt.setString(3, altB);
            stmt.setString(4, altC);
            stmt.setString(5, altD);
            stmt.setString(6, altCerta);
            stmt.setInt(7, dificuldade);
            stmt.setInt(8, Elaborador_idElaborador);
            stmt.setInt(9, Tema_idTema);

            int i = stmt.executeUpdate();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

    }
    
}
