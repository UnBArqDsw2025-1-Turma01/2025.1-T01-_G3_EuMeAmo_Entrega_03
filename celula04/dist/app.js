"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const swagger_ui_express_1 = __importDefault(require("swagger-ui-express"));
const swagger_jsdoc_1 = __importDefault(require("swagger-jsdoc"));
const swagger_1 = require("./config/swagger/swagger");
const routes_1 = __importDefault(require("./routes"));
const app = (0, express_1.default)();
const spec = (0, swagger_jsdoc_1.default)(swagger_1.swagger);
app.use("/api-docs", swagger_ui_express_1.default.serve, swagger_ui_express_1.default.setup(spec));
app.use(routes_1.default);
exports.default = app;
