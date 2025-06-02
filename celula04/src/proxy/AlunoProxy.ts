import { UsuarioEspecialista } from "../factories/UsuarioEspecialista";
import { UsuarioAluno } from "../factories/UsuarioAluno";
import { AlunoMonitoravel } from "./AlunoMonitoravel";

export class AlunoProxy implements AlunoMonitoravel {
  private serv: UsuarioAluno;
  private especialista: UsuarioEspecialista;

  constructor(serv: UsuarioAluno, especialista: UsuarioEspecialista) {
    this.serv = serv;
    this.especialista = especialista;
  }

  private verificaAcesso(): boolean {
    return !!this.especialista?.crm;
  }

  preferenciasAluno(): string {
    if (this.verificaAcesso()) {
      return this.serv.preferencias;
    } else {
      throw new Error("Acesso negado: Especialista sem credenciais válidas.");
    }
  }
}
