export class Treino {
  constructor(
    public nome: string,
    public tipoExercicio: string,
    public tempoDeExecucao: number,
    public frequenciaSemanal: number,
    public metas: string,
    public anotacoes: string
  ) {}
}
