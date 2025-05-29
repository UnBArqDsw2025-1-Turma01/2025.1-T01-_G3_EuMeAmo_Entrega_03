"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const ConcreteCreatorEspecialista_1 = require("./factories/ConcreteCreatorEspecialista");
const ConcreteCreatorAluno_1 = require("./factories/ConcreteCreatorAluno");
// Código cliente
function cliente(factory) {
    const usuario = factory.criaUsuario();
    usuario.exibeUsuario();
}
// Teste
cliente(new ConcreteCreatorAluno_1.ConcreteCreatorAluno());
cliente(new ConcreteCreatorEspecialista_1.ConcreteCreatorEspecialista());
