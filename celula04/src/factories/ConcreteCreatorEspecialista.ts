import { UsuarioFactory } from "./UsuarioFactory";
import { Usuario } from "./Usuario";
import { UsuarioEspecialista } from "./UsuarioEspecialista";

// Creator concreto: Especialista
export class ConcreteCreatorEspecialista extends UsuarioFactory {
  criaUsuario(): Usuario {
    return new UsuarioEspecialista(
      "Dra. Ana Souza",
      "ana@email.com",
      "senhaSegura",
      "Nutrição Esportiva",
      "123456/CRN",
      "Especialista em dietas para atletas."
    );
  }
}
