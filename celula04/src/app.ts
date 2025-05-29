import { UsuarioFactory } from "./factories/UsuarioFactory";
import { ConcreteCreatorEspecialista } from "./factories/ConcreteCreatorEspecialista";
import { ConcreteCreatorAluno } from "./factories/ConcreteCreatorAluno";

// Código cliente
function cliente(factory: UsuarioFactory) {
  const usuario = factory.criaUsuario();
  usuario.exibeUsuario();
}

// Teste
cliente(new ConcreteCreatorAluno());
cliente(new ConcreteCreatorEspecialista());
