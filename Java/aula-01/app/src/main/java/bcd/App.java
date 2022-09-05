package bcd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

import bcd.dao.PessoaDao;
import bcd.entities.Cidade;
import bcd.entities.Pessoa;

public class App {

    final String DB_URI = "jdbc:sqlite:app/src/main/resources/agenda.sqlite";

    public void consultarPessoaPelaCidade(String cidade)
    {
         // suscetível ao SQL Injection
         String query = "SELECT * FROM Pessoa WHERE cidade = ?";
         System.out.println("Query: " + query);
 
         try ( Connection conexao = DriverManager.getConnection( DB_URI );  
               PreparedStatement statement = conexao.prepareStatement(query)) 
         {
             statement.setString(1, cidade);
             ResultSet rs = statement.executeQuery();
 
             while ( rs.next() )
             {
                 System.out.println( "IdPessoa: " + rs.getInt("idPessoa") + ", Nome: " + rs.getString("nome") );
             }
 
             rs.close();
             
         } catch ( Exception e ) 
         {
             System.err.println(e.toString());
         }
    }

    public static void main( String[] args ) 
    {
        System.out.print("Entre com o nome da cidade: ");
        Scanner ioIn = new Scanner( System.in );
        String cidade = ioIn.nextLine();

        // Consultando Pessoa pela Cidade
        App app = new App();
        app.consultarPessoaPelaCidade(cidade);

        ioIn.close();

        // Adicionando uma Pessoa
        Pessoa p = new Pessoa("Julia", "j@e.com", "Palhoça");
        
        try {
            PessoaDao.adicionarPessoa(p);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.err.println("Algo deu errado: " + e.toString());
        }
    }
}
