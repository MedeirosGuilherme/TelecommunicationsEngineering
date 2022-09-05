package Project.entities;

public class Candidato {

    private int idCandidato;
    private String senha;
    private String nome;

    public Candidato() {
    }

    public Candidato(String senha, String nome) {
        this.senha = senha;
        this.nome = nome;
    }

    public int getIdCandidato() {
        return idCandidato;
    }
    public void setIdCandidato(int idCandidato) {
        this.idCandidato = idCandidato;
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

    @Override
    public String toString() {
        return "Candidato [idCandidato=" + idCandidato + ", nome=" + nome + ", senha=" + senha + "]";
    }

    
    
}
