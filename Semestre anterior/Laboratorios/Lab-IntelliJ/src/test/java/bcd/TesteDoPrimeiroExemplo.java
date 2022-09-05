package bcd;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TesteDoPrimeiroExemplo {

    @Test
    public void incluirPessoa(){

        PrimeiroExemplo app = new PrimeiroExemplo();

        int resultado =  app.cadastrarPessoa("Joao", 60, 160, "jo@email.com");

        assertEquals(1, resultado);

    }


}
