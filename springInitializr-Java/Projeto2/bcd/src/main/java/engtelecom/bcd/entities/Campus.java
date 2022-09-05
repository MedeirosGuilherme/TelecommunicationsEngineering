package engtelecom.bcd.entities;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

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
@ToString
public class Campus {

    @Id                                                     //  DataBase
    @GeneratedValue(strategy = GenerationType.IDENTITY)     //
    private Integer idCampus;

    @NonNull                //Lombok RequiredArgsConstructor
    private String nome;

    @NonNull                    //Lombok RequiredArgsConstructor
    private String sigla;

    @NonNull                    //Lombok RequiredArgsConstructor
    private String endereco;

    @NonNull                       //Lombok RequiredArgsConstructor  
    private String cidade;

    @OneToMany(mappedBy = "campus")
    private Set<Curso> cursos;
    
}


