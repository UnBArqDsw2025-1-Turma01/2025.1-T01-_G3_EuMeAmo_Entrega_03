"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ConcreteCreatorAluno = void 0;
const UsuarioFactory_1 = require("./UsuarioFactory");
const UsuarioAluno_1 = require("./UsuarioAluno");
// Creator concreto: Aluno
class ConcreteCreatorAluno extends UsuarioFactory_1.UsuarioFactory {
    criaUsuario() {
        return new UsuarioAluno_1.UsuarioAluno("João da Silva", "joao@email.com", "senha123", 25, "M", "hipertrofia");
    }
}
exports.ConcreteCreatorAluno = ConcreteCreatorAluno;
