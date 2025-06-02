import { UsuarioFactory } from "./UsuarioFactory";
import { Usuario } from "./Usuario";
import { UsuarioAluno } from "./UsuarioAluno";

// Creator concreto: Aluno
export class ConcreteCreatorAluno extends UsuarioFactory {
  criaUsuario(): Usuario {
    return new UsuarioAluno(
      "João da Silva",
      "joao@email.com",
      "senha123",
      25,
      "M",
      "hipertrofia"
    );
  }
}
