package Project.entities;

public class ProvaQuestao {

    private int idQuestao;
    private int idProva;

    public ProvaQuestao() {
    }
    public int getIdQuestao() {
        return idQuestao;
    }
    public void setIdQuestao(int idQuestao) {
        this.idQuestao = idQuestao;
    }
    public int getIdProva() {
        return idProva;
    }
    public void setIdProva(int idProva) {
        this.idProva = idProva;
    }
        
    @Override
    public String toString() {
        return "ProvaQuestao [idProva=" + idProva + ", idQuestao=" + idQuestao + "]";
    }

    
    
}
