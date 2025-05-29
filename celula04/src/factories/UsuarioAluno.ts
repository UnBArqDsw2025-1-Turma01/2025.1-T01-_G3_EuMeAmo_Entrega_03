import { Usuario } from "./Usuario";
import { AlunoMonitoravel } from "../proxy/AlunoMonitoravel";

export class UsuarioAluno extends Usuario implements AlunoMonitoravel {
  idade: number;
  genero: "M" | "F";
  preferencias: string;

  constructor(
    nomeCompleto: string,
    email: string,
    senha: string,
    idade: number,
    genero: "M" | "F",
    preferencias: string
  ) {
    super(nomeCompleto, email, senha);
    this.idade = idade;
    this.genero = genero;
    this.preferencias = preferencias;
  }

  exibeUsuario(): void {
    console.log(
      `Aluno: ${this.nomeCompleto}, ${this.idade} anos, preferências: ${this.preferencias}`
    );
  }

  preferenciasAluno(): string {
    return this.preferencias;
  }
}
