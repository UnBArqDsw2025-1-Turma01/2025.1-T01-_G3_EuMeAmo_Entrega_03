import { Treino } from "./Treino";
import { TreinoHandler } from "./TreinoHandler";

export abstract class TreinoBaseHandler implements TreinoHandler {
  private next: TreinoHandler | null = null;

  public setNext(handler: TreinoHandler): TreinoHandler {
    this.next = handler;
    return handler;
  }

  public handle(treino: Treino): string | null {
    if (this.next) {
      return this.next.handle(treino);
    }
    return null;
  }
}
