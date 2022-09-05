package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Project.ConnectionFactory;
import Project.entities.ProcessoSeletivo;
import Project.entities.Prova;
import Project.entities.Questao;
import Project.entities.Tema;

public class ProcessoSeletivoDao {

    public static ProcessoSeletivo findById(int id) throws Exception{

        String query = "SELECT * FROM ProcessoSeletivo WHERE idProcessoSeletivo = ?";
        ProcessoSeletivo processo = new ProcessoSeletivo();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    processo.setIdProcesso(rs.getInt("idProcessoSeletivo"));
                    processo.setIdGestor(rs.getInt("Gestor_idGestor"));
                    processo.setIdProva(rs.getInt("Prova_idProva"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return processo;
    }
    
    public static ArrayList<ProcessoSeletivo> findAll() throws Exception{

        String query = "SELECT * FROM ProcessoSeletivo";
        ArrayList<ProcessoSeletivo> lista = new ArrayList<>();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            ResultSet rs = stmt.executeQuery();

            if(rs.next()){
                do {
                    ProcessoSeletivo processo = new ProcessoSeletivo();
                    processo.setIdProcesso(rs.getInt("idProcessoSeletivo"));
                    processo.setIdGestor(rs.getInt("Gestor_idGestor"));
                    processo.setIdProva(rs.getInt("Prova_idProva"));
                    lista.add(processo);
                }while (rs.next());
            }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        return lista;
    }

    public static void insert(int idGestor, int idProva) throws Exception{

        String query = "INSERT INTO ProcessoSeletivo(Gestor_idGestor, Prova_idProva) VALUES(?, ?)";

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idGestor);
            stmt.setInt(2, idProva);

            int i = stmt.executeUpdate();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
    }

    public static String geraGabarito(int id) throws Exception{

        String queryProcesso = "SELECT * FROM ProcessoSeletivo WHERE idProcessoSeletivo = ?";
        String gabarito = new String();
        ProcessoSeletivo processo = new ProcessoSeletivo();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(queryProcesso);){

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

                while (rs.next()){
                    processo.setIdProcesso(rs.getInt("idProcessoSeletivo"));
                    processo.setIdGestor(rs.getInt("Gestor_idGestor"));
                    processo.setIdProva(rs.getInt("Prova_idProva"));
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }
        
        String queryProva = "SELECT * FROM Prova WHERE idProva = ?";
        Prova prova = new Prova();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(queryProva);){

            stmt.setInt(1, processo.getIdProva());
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

        String queryQuestaoProva = "SELECT * FROM Questao q WHERE q.idQUestao in(SELECT Questao_idQUestao FROM Prova_has_Questao WHERE Prova_idProva = ?)";
        ArrayList<Questao> lista = new ArrayList<>();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(queryQuestaoProva);){

            stmt.setInt(1, prova.getIdProva());
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

        StringBuilder str = new StringBuilder();
        for (Questao questao : lista) {
            str.append((questao.getAltCerta() + ","));
        }
        str.append("\n");
        gabarito = str.toString();
        return gabarito;
    }
}
