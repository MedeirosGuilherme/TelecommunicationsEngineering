package Project.entities;

public class Tema {

    private int idTema;
    private String nome;

    public Tema() {
    }

    public int getIdTema() {
        return idTema;
    }

    public void setIdTema(int idTema) {
        this.idTema = idTema;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    @Override
    public String toString() {
        return "Código: " + idTema + " - " + "Nome: " + nome + "\n";
    }
    
}
