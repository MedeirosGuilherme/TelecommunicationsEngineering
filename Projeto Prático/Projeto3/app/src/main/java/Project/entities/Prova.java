package Project.entities;

public class Prova {

    private int idProva;
    private int idGestor;

    public Prova() {
    }

    public int getIdProva() {
        return idProva;
    }

    public int getIdGestor() {
        return idGestor;
    }

    public void setIdProva(int idProva) {
        this.idProva = idProva;
    }

    public void setIdGestor(int idGestor) {
        this.idGestor = idGestor;
    }

    @Override
    public String toString() {
        return "Prova [idGestor=" + idGestor + ", idProva=" + idProva + "]";
    }
    
    
    
}
