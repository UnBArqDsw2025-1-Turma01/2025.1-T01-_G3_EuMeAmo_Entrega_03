"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.swagger = void 0;
exports.swagger = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "Minha API com Express + TypeScript",
            version: "1.0.0",
            description: "Documentação básica com Swagger",
        },
        servers: [
            {
                url: "http://localhost:3000",
            },
        ],
    },
    apis: [".src/routes/*.ts"],
};
