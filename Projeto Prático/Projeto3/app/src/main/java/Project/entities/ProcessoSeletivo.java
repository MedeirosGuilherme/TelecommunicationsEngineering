package Project.entities;

public class ProcessoSeletivo {

    private int idProcesso;
    private int idGestor;
    private int idProva;
    
    public ProcessoSeletivo() {
    }
    public int getIdProcesso() {
        return idProcesso;
    }
    public void setIdProcesso(int idProcesso) {
        this.idProcesso = idProcesso;
    }
    public int getIdGestor() {
        return idGestor;
    }
    public void setIdGestor(int idGestor) {
        this.idGestor = idGestor;
    }
    public int getIdProva() {
        return idProva;
    }
    public void setIdProva(int idProva) {
        this.idProva = idProva;
    }
    @Override
    public String toString() {
        return "ProcessoSeletivo [idGestor=" + idGestor + ", idProcesso=" + idProcesso + ", idProva=" + idProva + "]";
    }

    
    
}
