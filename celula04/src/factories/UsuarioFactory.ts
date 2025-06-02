import { Usuario } from "./Usuario";

export abstract class UsuarioFactory {
  abstract criaUsuario(): Usuario;
}
