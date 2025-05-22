import express from "express";
import swaggerUi from "swagger-ui-express";
import swaggerJSDoc from "swagger-jsdoc";
import { swagger } from "./config/swagger/swagger";
import router from "./routes";

const app = express();

const spec = swaggerJSDoc(swagger);

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(spec));
app.use(router);

export default app;
