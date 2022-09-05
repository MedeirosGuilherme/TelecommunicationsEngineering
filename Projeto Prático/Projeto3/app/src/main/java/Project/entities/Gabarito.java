package Project.entities;

public class Gabarito {

    private int idGabarito;
    private String gabarito;
    private int idCandidato;
    private int processoId;
    public Gabarito() {
    }
    public int getIdGabarito() {
        return idGabarito;
    }
    public void setIdGabarito(int idGabarito) {
        this.idGabarito = idGabarito;
    }
    public String getGabarito() {
        return gabarito;
    }
    public void setGabarito(String gabarito) {
        this.gabarito = gabarito;
    }
    public int getIdCandidato() {
        return idCandidato;
    }
    public void setIdCandidato(int idCandidato) {
        this.idCandidato = idCandidato;
    }
    public int getProcessoId() {
        return processoId;
    }
    public void setProcessoId(int processoId) {
        this.processoId = processoId;
    }
    
    @Override
    public String toString() {
        return "Gabarito [gabarito=" + gabarito + ", idCandidato=" + idCandidato + ", idGabarito=" + idGabarito
                + ", processoId=" + processoId + "]";
    }

    
    
}
