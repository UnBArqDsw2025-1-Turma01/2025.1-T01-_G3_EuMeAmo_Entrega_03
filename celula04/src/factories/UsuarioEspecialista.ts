import { Usuario } from "./Usuario";
import { Treino } from "../CoR/Treino";
import { TreinoHandler } from "../CoR/TreinoHandler";
import { TreinoConcreteHandler } from "../CoR/TreinoConcreteHandler";

export class UsuarioEspecialista extends Usuario {
  areaAtuacao: string;
  crm: string;
  bioProfissional: string;
  private handler: TreinoHandler;

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
    this.handler = new TreinoConcreteHandler(); //Treino padrao
  }

  exibeUsuario(): void {
    console.log(`Especialista: ${this.nomeCompleto}, CRM: ${this.crm}`);
  }

  setHandler(handler: TreinoHandler): void {
    this.handler = handler;
  }

  criarTreino(treino: Treino): void {
    const res = this.handler.handle(treino);
    console.log(res);
  }
}
