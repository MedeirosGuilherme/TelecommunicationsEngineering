package bcd.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bcd.entities.Pessoa;

public abstract class PessoaDao {

    final static String DB_URI = "jdbc:sqlite:app/src/main/resources/agenda.sqlite";

    public static ArrayList<Pessoa> findAll() throws Exception{
         // suscetível ao SQL Injection
         String query = "SELECT * FROM Pessoa";
         ArrayList<Pessoa> listaQuery = new ArrayList<Pessoa>();
 
         try ( Connection conexao = DriverManager.getConnection( DB_URI );  
               PreparedStatement statement = conexao.prepareStatement(query)) 
         {
             ResultSet rs = statement.executeQuery();
 
             while ( rs.next() )
             {
                Pessoa p = new Pessoa();
                p.setIdPessoa(rs.getInt("idPessoa"));
                p.setNome(rs.getString("nome"));
                p.setEmail(rs.getString("email"));
                p.setCidade(rs.getString("cidade"));

                listaQuery.add(p);
             }
 
             rs.close();
             
         } catch ( Exception e ) 
         {
             System.err.println(e.toString());
         }

         return listaQuery;
    }

    public static Pessoa findById(int idPessoa) throws Exception{

        String query = "SELECT * FROM Pessoa WHERE idPessoa = ?";
        System.out.println("Query: " + query);
        Pessoa p = new Pessoa();
 
        try ( Connection conexao = DriverManager.getConnection( DB_URI );  
               PreparedStatement statement = conexao.prepareStatement(query)) 
        {
            statement.setInt(1, idPessoa);
            ResultSet rs = statement.executeQuery();
  
            while ( rs.next() )
            {  
               p.setIdPessoa(rs.getInt("idPessoa"));
               p.setNome(rs.getString("nome"));
               p.setEmail(rs.getString("email"));
               p.setCidade(rs.getString("cidade"));
            }
 
            rs.close();
             
        } catch ( Exception e ) 
        {
            System.err.println(e.toString());
        }

        return p;
    }

    public static int update(Pessoa p) throws Exception{

        String query = "INSERT INTO Pessoa (nome, email, cidade) VALUES (?,?,?) WHERE idPessoa = ?";
        int totalDeLinhasModificadas = 0;
        
        try ( Connection conexao = DriverManager.getConnection( DB_URI );  
        PreparedStatement statement = conexao.prepareStatement(query)) 
            {
                statement.setString(1, p.getNome());
                statement.setString(2, p.getEmail());
                statement.setString(3, p.getCidade());
        
                totalDeLinhasModificadas = statement.executeUpdate();
                            
            } catch ( Exception e ) 
            {
                throw e;
            }

        return totalDeLinhasModificadas;
    }

    public static int delete(int idPessoa) throws Exception{

        String query = "INSERT INTO Pessoa (nome, email, cidade) VALUES (?,?,?)";
        int totalDeLinhasModificadas = 0;
        
        try ( Connection conexao = DriverManager.getConnection( DB_URI );  
        PreparedStatement statement = conexao.prepareStatement(query)) 
            {
                statement.setString(1, p.getNome());
                statement.setString(2, p.getEmail());
                statement.setString(3, p.getCidade());
        
                totalDeLinhasModificadas = statement.executeUpdate();
                            
            } catch ( Exception e ) 
            {
                throw e;
            }

        return totalDeLinhasModificadas;
    }

    public static boolean adicionarPessoa(Pessoa p) throws Exception{

        String query = "INSERT INTO Pessoa (nome, email, cidade) VALUES (?,?,?)";
        int totalDeLinhasModificadas = 0;
        
        try ( Connection conexao = DriverManager.getConnection( DB_URI );  
        PreparedStatement statement = conexao.prepareStatement(query)) 
            {
                statement.setString(1, p.getNome());
                statement.setString(2, p.getEmail());
                statement.setString(3, p.getCidade());
        
                totalDeLinhasModificadas = statement.executeUpdate();
                            
            } catch ( Exception e ) 
            {
                throw e;
            }

        return (totalDeLinhasModificadas > 0) ? true : false;
    }    
}
