export abstract class Usuario {
  constructor(
    public nomeCompleto: string,
    public email: string,
    public senha: string
  ) {}

  abstract exibeUsuario(): void;
}
