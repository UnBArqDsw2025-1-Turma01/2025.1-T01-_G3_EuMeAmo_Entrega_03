"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const router = (0, express_1.Router)();
/**
 *  @swagger
 *  /:
 *    get:
 *      summary: Retorna uma mensagem de boas-vindas
 *      responses:
 *        200:
 *          description: Mensagem de sucesso
 */
router.get("/", (req, res) => {
    res.send("Oi!!!!!");
});
exports.default = router;
