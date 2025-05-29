import { Usuario } from "./Usuario";

export class UsuarioEspecialista extends Usuario {
  areaAtuacao: string;
  crm: string;
  bioProfissional: string;

  constructor(
    nomeCompleto: string,
    email: string,
    senha: string,
    areaAtuacao: string,
    crm: string,
    bioProfissional: string
  ) {
    super(nomeCompleto, email, senha);
    this.areaAtuacao = areaAtuacao;
    this.crm = crm;
    this.bioProfissional = bioProfissional;
  }

  exibeUsuario(): void {
    console.log(`Especialista: ${this.nomeCompleto}, CRM: ${this.crm}`);
  }
}
