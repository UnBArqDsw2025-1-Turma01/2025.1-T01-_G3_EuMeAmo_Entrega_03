"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TreinoBaseHandler = void 0;
class TreinoBaseHandler {
    constructor() {
        this.next = null;
    }
    setNext(handler) {
        this.next = handler;
        return handler;
    }
    handle(treino) {
        if (this.next) {
            return this.next.handle(treino);
        }
        return null;
    }
}
exports.TreinoBaseHandler = TreinoBaseHandler;
