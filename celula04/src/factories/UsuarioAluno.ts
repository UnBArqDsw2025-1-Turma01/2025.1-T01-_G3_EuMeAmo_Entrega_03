import { Usuario } from "./Usuario";

export class UsuarioAluno extends Usuario {
  constructor(
    nomeCompleto: string,
    email: string,
    senha: string,
    public idade: number,
    public genero: "M" | "F",
    public preferencias: string
  ) {
    super(nomeCompleto, email, senha);
  }

  exibeUsuario(): void {
    console.log(`Aluno: ${this.nomeCompleto}, ${this.idade} anos`);
  }
}
