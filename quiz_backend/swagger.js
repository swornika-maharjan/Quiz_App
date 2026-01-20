// import swaggerJSDoc from 'swagger-jsdoc';
// import swaggerUi from 'swagger-ui-express';

// const options = {
//   definition: {
//     openapi: '3.0.0',
//     info: {
//       title: 'Quiz App API',
//       version: '1.0.0',
//       description: 'API documentation for the Quiz App backend'
//     },
//   },
//   apis: ['./routes/*.js'], // <-- Swagger scans your route files
// };

// const swaggerSpec = swaggerJSDoc(options);

// export { swaggerUi, swaggerSpec };


import swaggerJSDoc from 'swagger-jsdoc';
import swaggerUi from 'swagger-ui-express';

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Quiz App API',
      version: '1.0.0',
      description: 'API documentation for the Quiz App backend'
    },
    components: {
      securitySchemes: {
        bearerAuth: {
          type: "http",
          scheme: "bearer",
          bearerFormat: "JWT",
        },
      },
    },
    security: [
      {
        bearerAuth: [],
      },
    ],
  },
  apis: ['./routes/*.js'], // <-- Swagger scans your route files
};

const swaggerSpec = swaggerJSDoc(options);

export { swaggerUi, swaggerSpec };
