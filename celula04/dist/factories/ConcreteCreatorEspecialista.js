"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ConcreteCreatorEspecialista = void 0;
const UsuarioFactory_1 = require("./UsuarioFactory");
const UsuarioEspecialista_1 = require("./UsuarioEspecialista");
// Creator concreto: Especialista
class ConcreteCreatorEspecialista extends UsuarioFactory_1.UsuarioFactory {
    criaUsuario() {
        return new UsuarioEspecialista_1.UsuarioEspecialista("Dra. Ana Souza", "ana@email.com", "senhaSegura", "Nutrição Esportiva", "123456/CRN", "Especialista em dietas para atletas.");
    }
}
exports.ConcreteCreatorEspecialista = ConcreteCreatorEspecialista;
