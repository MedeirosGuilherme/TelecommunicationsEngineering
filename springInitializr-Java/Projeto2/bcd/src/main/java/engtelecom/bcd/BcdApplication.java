package engtelecom.bcd;

import java.util.Optional;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.mapping.model.CamelCaseAbbreviatingFieldNamingStrategy;

import engtelecom.bcd.entities.Campus;
import engtelecom.bcd.entities.Curso;
import engtelecom.bcd.repository.CampusRepository;
import engtelecom.bcd.repository.CursoRepository;


@SpringBootApplication
public class BcdApplication {

	public static void main(String[] args) {
		SpringApplication.run(BcdApplication.class, args);


		System.out.println("Aplicação finalizada");
	}

	@Bean
	public CommandLineRunner executar(CampusRepository campusRepository, CursoRepository cursoRepository){

		return args ->{
			
			System.out.println("Aplicação iniciada");

			Campus sje = new Campus("São José", "SJE", "José Lino Kretzer, 608", "São José");
			Curso engTelecom = new Curso("Engenharia de Telecomunicações", 4600, sje);

			// Associando um curso ao campus
			//sje.getCursos().add(engTelecom);

//---------------- Salvando entidades

			//campusRepository.save(sje);			// Salvando uma entidade
			//cursoRepository.save(engTelecom);		//

//----------------- Selecting entidades

//			for (Campus c : campusRepository.findAll()) {
//				System.out.println(c);				
//			}


//			for (Curso c : cursoRepository.findAll()) {
//				System.out.println(c);
//			}

			Optional<Curso> curso = cursoRepository.findById(1);

			if (curso.isPresent()){
				Curso c = curso.get();
				System.out.println(c);
			}

		};
	}

}


