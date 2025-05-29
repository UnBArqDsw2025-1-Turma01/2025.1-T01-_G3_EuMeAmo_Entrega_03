"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsuarioAluno = void 0;
const Usuario_1 = require("./Usuario");
class UsuarioAluno extends Usuario_1.Usuario {
    constructor(nomeCompleto, email, senha, idade, genero, preferencias) {
        super(nomeCompleto, email, senha);
        this.idade = idade;
        this.genero = genero;
        this.preferencias = preferencias;
    }
    exibeUsuario() {
        console.log(`Aluno: ${this.nomeCompleto}, ${this.idade} anos, preferências: ${this.preferencias}`);
    }
    preferenciasAluno() {
        return this.preferencias;
    }
}
exports.UsuarioAluno = UsuarioAluno;
