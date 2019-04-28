const expess = require('express');
const router = expess.Router( );
const Chart = require('../Objects/Charts');
const Joi = require('joi');


router.get('/', (req, res) => {
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
          res.status(404).send({massage : "404 Not Found Senpai"});
        }else{
          res.status(200).send(result);
        }
      });
    }
  }
  
});

router.put('/', (req, res) => {
  const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
  if(validateHeader.error){
    res.status(400).send({massage : "404 Bad Request header"});
  }else{
    let valid = Joi.validate(req.body,SchemaPUT,{escapeHtml: true});
    if(valid.error){
      res.status(400).send({massage : "404 Bad Request Body"});
    }else{
        Chart.edit_chart(valid.value,validateHeader.value,(result)=>{
          res.status(200).send(result);
        });
    }
  }
});

router.post('/', (req, res) => {
  let valid = Joi.validate(req.body,SchemaPost,{escapeHtml: true});
  if(valid.error){
    res.status(400).send({massage : "404 Bad Request Body"});
  }else{
    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send({massage : "404 Bad Request header"});
    }else{
        Chart.saveChart(valid.value,validateHeader.value,(result)=>{
            !result?
              res.status(403).send({massage : "Products Sudah Ada"}) : res.status(200).send(result);
    
        });
    }
  }


});

router.delete('/', (req, res) => {
  let valid = Joi.validate(req.body,SchemaDelete,{escapeHtml: true});
  if(valid.error){
    res.status(400).send({massage : "404 Bad Request Body"});
  }else{
    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send({massage : "404 Bad Request header"});
    }else{
        Chart.deleteChart(valid.value,validateHeader.value,(result)=>{
            !result?
              res.status(403).send({massage : "Products Tidak Ada"}) : res.status(200).send(result);
    
        });
    }
  }
});


router.delete('/all', (req, res) => {
  const validation = Joi.validate(req.query,Schema,{escapeHtml: true });
  if(validation.error){
    res.status(400).send(validation.error);
  
  }else{

    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send(validateHeader.error);
    }else{
      // console.log(validateHeader.value);

      Chart.delete_all(validation.value.id_ktp,validateHeader.value,(result)=>{
        if(!result){
          res.status(400).send({massage : "404 Bad Request"});
        }else{
          res.status(200).send(result);
        }
      });
    }
  }
  
});


const Schema ={
  id_ktp : Joi.string().min(16).max(16).required()

}
const SchemaHeaders = Joi.string().min(1).required();

const SchemaPost = {
  id_ktp : Joi.string().min(16).max(16).required(),
  id_kamera : Joi.string().min(5).max(5).required(),
  jumlah : Joi.string().min(1).max(3).required()
}
const SchemaDelete  ={
  id_ktp : Joi.string().min(16).max(16).required(),
  id_kamera : Joi.string().min(5).max(5).required()
}
const SchemaPUT = {
  id_ktp : Joi.string().min(16).max(16).required(),
  id_kamera : Joi.string().min(5).max(5).required(),
  jumlah  : Joi.string().max(2).required()
}
module.exports = router;


