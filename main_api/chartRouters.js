const expess = require('express');
const router = expess.Router( );
const Chart = require('../Objects/Charts');
const Joi = require('joi');


router.get('/wkwk', (req, res) => {
  const validation = Joi.validate(req.query,Schema,{escapeHtml: true });
  if(validation.error){
    res.status(400).send(validation.error);
  
  }else{

    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send(validateHeader.error);
    }else{
      // console.log(validateHeader.value);

      Chart.getChart(validation.value.id_ktp,validateHeader.value,(result)=>{
        if(!result){
          res.status(400).send({massage : "404 Bad Request"});
        }else{
          res.status(200).send(result);
        }
      });
    }
  }
  
});

router.put('/', (req, res) => {
  
});

router.post('/', (req, res) => {
  
});

router.delete('/', (req, res) => {
  
});


const Schema ={
  id_ktp : Joi.string().min(16).max(16).required()

}
const SchemaHeaders = Joi.string().min(1).required();

module.exports = router;