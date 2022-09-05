package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Project.ConnectionFactory;
import Project.entities.Prova;
import Project.entities.Questao;

public class ProvaQuestaoDao {

    public static ArrayList<Questao> questaoPorProva(int idProva) throws Exception{
        
        String query = "SELECT * FROM Questao q WHERE q.idQUestao in(SELECT Questao_idQUestao FROM Prova_has_Questao WHERE Prova_idProva = ?)";
        ArrayList<Questao> lista = new ArrayList<>();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idProva);
            ResultSet rs = stmt.executeQuery();

            if(rs.next()){
                do{
                    Questao questao = new Questao();
                    questao.setIdQuestao(rs.getInt("idQUestao"));
                    questao.setIdTema(rs.getInt("Tema_idTema"));
                    questao.setIdElaborador(rs.getInt("Elaborador_idElaborador"));
                    questao.setDescricao(rs.getString("descricao"));
                    questao.setAltA(rs.getString("altA"));
                    questao.setAltB(rs.getString("altB"));
                    questao.setAltC(rs.getString("altC"));
                    questao.setAltD(rs.getString("altD"));
                    questao.setDificuldade(rs.getInt("dificuldade"));
                    questao.setAltCerta(rs.getString("altCerta"));

                    lista.add(questao);

                } while (rs.next());
            }

            rs.close();

        }catch(Exception e){
            System.err.println(e.toString());
        }

        return lista;

    }

    public static void insert(int idProva, int idQUestao){

        String query = "INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQuestao) VALUES(?, ?)";

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idProva);
            stmt.setInt(2, idQUestao);

            int i = stmt.executeUpdate();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

    }
    
}
