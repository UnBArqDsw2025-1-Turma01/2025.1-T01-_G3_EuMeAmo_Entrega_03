"use strict";
// import { UsuarioFactory } from "./factories/UsuarioFactory";
// import { ConcreteCreatorEspecialista } from "./factories/ConcreteCreatorEspecialista";
// import { ConcreteCreatorAluno } from "./factories/ConcreteCreatorAluno";
Object.defineProperty(exports, "__esModule", { value: true });
// // Código cliente
// function cliente(factory: UsuarioFactory) {
//   const usuario = factory.criaUsuario();
//   usuario.exibeUsuario();
// }
// // Teste
// cliente(new ConcreteCreatorAluno());
// cliente(new ConcreteCreatorEspecialista());
const UsuarioAluno_1 = require("./factories/UsuarioAluno");
const UsuarioEspecialista_1 = require("./factories/UsuarioEspecialista");
const AlunoProxy_1 = require("./proxy/AlunoProxy");
const aluno = new UsuarioAluno_1.UsuarioAluno("João da Silva", "joao@email.com", "senha123", 25, "M", "Emagrecimento e hipertrofia");
const especialistaValido = new UsuarioEspecialista_1.UsuarioEspecialista("Dra. Ana Paula", "ana@especialista.com", "senha456", "Nutrição", "123456", "Especialista em nutrição esportiva");
const especialistaInvalido = new UsuarioEspecialista_1.UsuarioEspecialista("Carlos Técnico", "carlos@tecnico.com", "semcrm", "Educação Física", "", "Técnico sem registro");
const proxyValido = new AlunoProxy_1.AlunoProxy(aluno, especialistaValido);
const proxyInvalido = new AlunoProxy_1.AlunoProxy(aluno, especialistaInvalido);
console.log("Com especialista válido:");
console.log(proxyValido.preferenciasAluno());
console.log("\nCom especialista inválido:");
console.log(proxyInvalido.preferenciasAluno());
console.log("\nCom especialista inválido:");
try {
    console.log(proxyInvalido.preferenciasAluno());
}
catch (_a) {
    console.log("ERRO!!!");
}
