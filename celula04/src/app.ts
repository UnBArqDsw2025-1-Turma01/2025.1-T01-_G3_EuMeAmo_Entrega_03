// import { UsuarioFactory } from "./factories/UsuarioFactory";
// import { ConcreteCreatorEspecialista } from "./factories/ConcreteCreatorEspecialista";
// import { ConcreteCreatorAluno } from "./factories/ConcreteCreatorAluno";

// // Código cliente
// function cliente(factory: UsuarioFactory) {
//   const usuario = factory.criaUsuario();
//   usuario.exibeUsuario();
// }

// // Teste
// cliente(new ConcreteCreatorAluno());
// cliente(new ConcreteCreatorEspecialista());

// import { UsuarioAluno } from "./factories/UsuarioAluno";
// import { UsuarioEspecialista } from "./factories/UsuarioEspecialista";
// import { AlunoProxy } from "./proxy/AlunoProxy";

// const aluno = new UsuarioAluno(
//   "João da Silva",
//   "joao@email.com",
//   "senha123",
//   25,
//   "M",
//   "Emagrecimento e hipertrofia"
// );

// const especialistaValido = new UsuarioEspecialista(
//   "Dra. Ana Paula",
//   "ana@especialista.com",
//   "senha456",
//   "Nutrição",
//   "123456",
//   "Especialista em nutrição esportiva"
// );

// const especialistaInvalido = new UsuarioEspecialista(
//   "Carlos Técnico",
//   "carlos@tecnico.com",
//   "semcrm",
//   "Educação Física",
//   "",
//   "Técnico sem registro"
// );

// const proxyValido = new AlunoProxy(aluno, especialistaValido);
// const proxyInvalido = new AlunoProxy(aluno, especialistaInvalido);

// console.log("Com especialista válido:");
// console.log(proxyValido.preferenciasAluno());

// console.log("\nCom especialista inválido:");
// console.log(proxyInvalido.preferenciasAluno());
// console.log("\nCom especialista inválido:");
// try {
//   console.log(proxyInvalido.preferenciasAluno());
// } catch {}

import { Treino } from "./CoR/Treino";
import { TreinoConcreteHandler } from "./CoR/TreinoConcreteHandler";
import { UsuarioEspecialista } from "./factories/UsuarioEspecialista";

const handler = new TreinoConcreteHandler();
const especialista = new UsuarioEspecialista(
  "Dra. Ana Souza",
  "ana@email.com",
  "senhaSegura",
  "Nutrição Esportiva",
  "123456/CRN",
  "Especialista em dietas para atletas."
);

const treinoValido = new Treino(
  "Treino A",
  "Cardio",
  40,
  5,
  "Melhorar resistência",
  "Sem observações"
);
const treinoInvalido = new Treino("", "Força", 0, 10, "", "Notas adicionais");

console.log("Teste com treino válido:");
especialista.criarTreino(treinoValido);

console.log("\nTeste com treino inválido:");
especialista.criarTreino(treinoInvalido);
