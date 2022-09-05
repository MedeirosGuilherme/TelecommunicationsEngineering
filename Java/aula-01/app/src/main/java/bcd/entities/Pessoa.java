package bcd.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@NoArgsConstructor
public class Pessoa {

    private int idPessoa;
    @NonNull private String nome;
    @NonNull private String email;
    @NonNull private String cidade;


}
