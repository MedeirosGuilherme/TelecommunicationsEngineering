package Project.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Project.ConnectionFactory;
import Project.entities.Elaborador;
import Project.entities.Tema;

public class TemaElaboradorDao {

    // Retorna uma lista de elaboradores passando-se a id de um tema
    public static ArrayList<Elaborador> elaboradorPorTema(int idTema) throws Exception{

        String query = "SELECT * FROM Elaborador e WHERE e.idElaborador IN(SELECT Elaborador_idElaborador FROM TemaElaborador WHERE Tema_idTema = ?);";
        ArrayList<Elaborador> lista = new ArrayList<>();

        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idTema);
            ResultSet rs = stmt.executeQuery();

                if (rs.next()){
                    do{
                        Elaborador elaborador = new Elaborador();
                        elaborador.setIdElaborador(rs.getInt("idElaborador"));
                        elaborador.setNome(rs.getString("nome"));
                        elaborador.setSenha(rs.getString("senha"));

                        lista.add(elaborador);
                    } while(rs.next());
                }

                rs.close();
        }
        catch(Exception e){
            System.err.println(e.toString());
        }

        return lista;
    }

    // Retorna uma lista de temas passando-se a id de um Elaborador
    public static ArrayList<Tema> temaPorElaborador(int idElaborador) throws Exception{

        String query = "SELECT * FROM Tema t WHERE t.idTema IN(SELECT Tema_idTema FROM TemaElaborador WHERE Elaborador_idElaborador = ?)";
        ArrayList<Tema> lista = new ArrayList<>();
        try (PreparedStatement stmt = ConnectionFactory.getDBConnection().prepareStatement(query);){

            stmt.setInt(1, idElaborador);
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

        }catch(Exception e){
            System.err.println(e.toString());
        }

        return lista;

    }
    
}
