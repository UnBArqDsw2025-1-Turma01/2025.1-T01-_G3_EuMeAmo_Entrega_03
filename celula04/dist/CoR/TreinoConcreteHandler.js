"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TreinoConcreteHandler = void 0;
const TreinoBaseHandler_1 = require("./TreinoBaseHandler");
class TreinoConcreteHandler extends TreinoBaseHandler_1.TreinoBaseHandler {
    handle(treino) {
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
exports.TreinoConcreteHandler = TreinoConcreteHandler;
