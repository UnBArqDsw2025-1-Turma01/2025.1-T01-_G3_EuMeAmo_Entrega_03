import { Router } from "express";

const router = Router();

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

export default router;
