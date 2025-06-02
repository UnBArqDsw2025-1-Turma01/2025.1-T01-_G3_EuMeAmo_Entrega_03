import { Treino } from "./Treino";
import { TreinoBaseHandler } from "./TreinoBaseHandler";

export class TreinoConcreteHandler extends TreinoBaseHandler {
  public handle(treino: Treino): string | null {
    // Aqui, as validacoes serao feitas
    if (!treino.nome || treino.nome.trim().length === 0) {
      return "Erro: Nome do treino inválido.";
    }

    if (treino.frequenciaSemanal < 1 || treino.frequenciaSemanal > 7) {
      return "Erro: Frequência semanal deve estar entre 1 e 7.";
    }

    if (treino.tempoDeExecucao <= 0) {
      return "Erro: Tempo de execução deve ser maior que 0.";
    }

    if (!treino.metas || treino.metas.trim().length < 3) {
      return "Erro: Metas precisam ser especificadas com pelo menos 3 caracteres.";
    }

    return super.handle(treino) || "Treino criado com sucesso!";
  }
}
