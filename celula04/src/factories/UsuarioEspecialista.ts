import { Usuario } from "./Usuario";

export class UsuarioEspecialista extends Usuario {
  constructor(
    nomeCompleto: string,
    email: string,
    senha: string,
    public areaAtuacao: string,
    public crnCrm: string,
    public bioProfissional: string
  ) {
    super(nomeCompleto, email, senha);
  }

  exibeUsuario(): void {
    console.log(
      `Especialista: ${this.nomeCompleto}, área: ${this.areaAtuacao}`
    );
  }
}
