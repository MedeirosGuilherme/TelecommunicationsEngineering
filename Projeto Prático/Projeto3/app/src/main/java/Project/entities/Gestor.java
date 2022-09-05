package Project.entities;

public class Gestor {

    private int idGestor;
    private String senha;
    private String nome;

    public Gestor() {
    }

    public Gestor(String senha, String nome) {
        this.senha = senha;
        this.nome = nome;
    }

    public int getIdGestor() {
        return idGestor;
    }

    public String getSenha() {
        return senha;
    }
    public void setSenha(String senha) {
        this.senha = senha;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setIdGestor(int idGestor) {
        this.idGestor = idGestor;
    }    

    
}
