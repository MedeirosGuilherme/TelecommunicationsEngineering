package bcd.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@RequiredArgsConstructor
public class Cidade {

    private int idCidade;
    @NonNull
    private String nome;
    @NonNull
    private String estado;
    @NonNull
    private String pais;
}
