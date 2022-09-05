package engtelecom.bcd.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.ManyToAny;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@RequiredArgsConstructor
@EqualsAndHashCode
@Entity
public class Curso {

    @Id                                                     //  DataBase
    @GeneratedValue(strategy = GenerationType.IDENTITY)     //
    private Integer idCurso;

    @NonNull                                    // Lombok RequiredARgsConstructor
    private String nome;

    @NonNull                                    // Lombok RequiredARgsConstructor
    private Integer cargaHoraria;

    @NonNull
    @ManyToOne                                              //  Database, cardinalidade
    @JoinColumn(name = "id_campus", nullable = false)       //
    private Campus campus;   
    
    public String toString(){
        return "id: " + idCurso + "\n nome: " + nome + "\n cargaHoraria: " + cargaHoraria;
    }
}
