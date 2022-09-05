package Project.entities;

public class Questao {

    private int idQuestao;
    private String descricao;
    private String altA;
    private String altB;
    private String altC;
    private String altD;
    private String altCerta;
    private int dificuldade;
    
    private int idElaborador;
    private int idTema;


    public Questao() {
    }
    public int getIdQuestao() {
        return idQuestao;
    }
    public void setIdQuestao(int idQuestao) {
        this.idQuestao = idQuestao;
    }
    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    public String getAltA() {
        return altA;
    }
    public void setAltA(String altA) {
        this.altA = altA;
    }
    public String getAltB() {
        return altB;
    }
    public void setAltB(String altB) {
        this.altB = altB;
    }
    public String getAltC() {
        return altC;
    }
    public void setAltC(String altC) {
        this.altC = altC;
    }
    public String getAltD() {
        return altD;
    }
    public void setAltD(String altD) {
        this.altD = altD;
    }
    public String getAltCerta() {
        return altCerta;
    }
    public void setAltCerta(String altCerta) {
        this.altCerta = altCerta;
    }
    public int getDificuldade() {
        return dificuldade;
    }
    public void setDificuldade(int dificuldade) {
        this.dificuldade = dificuldade;
    }
    public int getIdElaborador() {
        return idElaborador;
    }
    public void setIdElaborador(int idElaborador) {
        this.idElaborador = idElaborador;
    }
    public int getIdTema() {
        return idTema;
    }
    public void setIdTema(int idTema) {
        this.idTema = idTema;
    }

    @Override
    public String toString() {
        StringBuilder st = new StringBuilder();
        st.append(descricao);
        st.append("\n a)");
        st.append(altA);
        st.append("\n b)");
        st.append(altB);
        st.append("\n c)");
        st.append(altC);
        st.append("\n d)");
        st.append(altD);
        st.append("\n\n");


        return st.toString();
    }    
}
