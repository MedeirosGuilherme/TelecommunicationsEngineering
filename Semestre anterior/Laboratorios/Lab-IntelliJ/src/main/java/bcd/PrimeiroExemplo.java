package bcd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class PrimeiroExemplo {

    private final String DB_URI = "jdbc:sqlite:scr/main/resources/lab01.sqlite";

    public int cadastrarPessoa(String nome, double peso, int altura, String email){

        int resultado = -1;

        String query = "INSERT INTO Pessoa (nome, peso, altura, email) VALUES "
                + "('" + nome + " ',"+ peso + "," + altura + ", '" + email + "')";

        try(Connection conexao = DriverManager.getConnection(DB_URI);
            Statement stmt = conexao.createStatement()){

            resultado = stmt.executeUpdate(query);

        }catch (SQLException e){
            e.printStackTrace();
        }


        return resultado;
    }


}
