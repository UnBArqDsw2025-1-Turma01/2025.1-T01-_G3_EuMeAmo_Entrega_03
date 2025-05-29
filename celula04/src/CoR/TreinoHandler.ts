import { Treino } from "./Treino";

export interface TreinoHandler {
  setNext(handler: TreinoHandler): TreinoHandler;
  handle(treino: Treino): string | null;
}
