"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsuarioEspecialista = void 0;
const Usuario_1 = require("./Usuario");
class UsuarioEspecialista extends Usuario_1.Usuario {
    constructor(nomeCompleto, email, senha, areaAtuacao, crm, bioProfissional) {
        super(nomeCompleto, email, senha);
        this.areaAtuacao = areaAtuacao;
        this.crm = crm;
        this.bioProfissional = bioProfissional;
    }
    exibeUsuario() {
        console.log(`Especialista: ${this.nomeCompleto}, CRM: ${this.crm}`);
    }
}
exports.UsuarioEspecialista = UsuarioEspecialista;
