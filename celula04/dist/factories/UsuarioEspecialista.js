"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsuarioEspecialista = void 0;
const Usuario_1 = require("./Usuario");
const TreinoConcreteHandler_1 = require("../CoR/TreinoConcreteHandler");
class UsuarioEspecialista extends Usuario_1.Usuario {
    constructor(nomeCompleto, email, senha, areaAtuacao, crm, bioProfissional) {
        super(nomeCompleto, email, senha);
        this.areaAtuacao = areaAtuacao;
        this.crm = crm;
        this.bioProfissional = bioProfissional;
        this.handler = new TreinoConcreteHandler_1.TreinoConcreteHandler(); //Treino padrao
    }
    exibeUsuario() {
        console.log(`Especialista: ${this.nomeCompleto}, CRM: ${this.crm}`);
    }
    setHandler(handler) {
        this.handler = handler;
    }
    criarTreino(treino) {
        const res = this.handler.handle(treino);
        console.log(res);
    }
}
exports.UsuarioEspecialista = UsuarioEspecialista;
