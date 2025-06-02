"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AlunoProxy = void 0;
class AlunoProxy {
    constructor(serv, especialista) {
        this.serv = serv;
        this.especialista = especialista;
    }
    verificaAcesso() {
        var _a;
        return !!((_a = this.especialista) === null || _a === void 0 ? void 0 : _a.crm);
    }
    preferenciasAluno() {
        if (this.verificaAcesso()) {
            return this.serv.preferencias;
        }
        else {
            throw new Error("Acesso negado: Especialista sem credenciais válidas.");
        }
    }
}
exports.AlunoProxy = AlunoProxy;
