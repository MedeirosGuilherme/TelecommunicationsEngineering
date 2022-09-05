package Project.entities;

public class Elaborador {

    private int idElaborador;
    private String senha;
    private String nome;

    public Elaborador() {
    }

    public Elaborador(String senha, String nome) {
        this.senha = senha;
        this.nome = nome;
    }

    public int getIdElaborador() {
        return idElaborador;
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

    public void setIdElaborador(int idElaborador) {
        this.idElaborador = idElaborador;
    }

    @Override
    public String toString() {
        return "Elaborador [idElaborador=" + idElaborador + ", nome=" + nome + ", senha=" + senha + "]";
    }
    
    
}
