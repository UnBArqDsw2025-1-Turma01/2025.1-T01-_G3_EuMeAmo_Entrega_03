import express from "express";
import swaggerUi from "swagger-ui-express";
import swaggerJSDoc from "swagger-jsdoc";
import { swagger } from "./config/swagger/swagger";

import router from "./routes";

const app = express();
const port = 3000;

const spec = swaggerJSDoc(swagger);

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(spec));

app.use(router);

app.get("/", (req, res) => {
  res.send("Oi! Servidor online!");
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
  console.log(`Documentação Swagger em http://localhost:${port}/api-docs`);
});
