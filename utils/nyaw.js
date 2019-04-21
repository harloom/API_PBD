const Joi = require('joi');
const SchemaHeaders = Joi.string().min(1).required();

module.exports = SchemaHeaders;