const expess = require('express');
const router = expess.Router( );
const Chart = require('../Objects/Charts');
const Joi = require('joi');
const ResponErrors = require('../utils/errorUtils');

function getError(code  , massage){
  return new ResponErrors(code,massage);
  
}

router.get('/', (req, res) => {
  const validation = Joi.validate(req.query,Schema,{escapeHtml: true });
  if(validation.error){
    res.status(400).send(getError(401,validation.error));
  
  }else{

    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send(getError(400,validateHeader.error));
    }else{
      // console.log(validateHeader.value);

      Chart.getChart(validation.value.id_ktp,validateHeader.value,(result)=>{
        if(!result){
          res.status(404).send(new ResponErrors().get404());
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
    res.status(400).send(new ResponErrors().get400());
  }else{
    let valid = Joi.validate(req.body,SchemaPUT,{escapeHtml: true});
    if(valid.error){
      res.status(400).send(new ResponErrors().get400());
    }else{
        Chart.edit_chart(valid.value,validateHeader.value,(result)=>{
          console.log(result);
          if(result){
            res.status(200).send(result);
          }else{
            res.status(404).send(new ResponErrors(400,"Data Tidak Ada"));
          }
         
        });
    }
  }
});

router.post('/', (req, res) => {
  let valid = Joi.validate(req.body,SchemaPost,{escapeHtml: true});
  if(valid.error){
    res.status(400).send(new ResponErrors().get400());
  }else{
    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send(new ResponErrors().get400());
    }else{
        Chart.saveChart(valid.value,validateHeader.value,(result)=>{
            !result?
              res.status(403).send(new ResponErrors().get403Product()) : res.status(200).send(result);
    
        });
    }
  }


});

router.delete('/', (req, res) => {
  let valid = Joi.validate(req.body,SchemaDelete,{escapeHtml: true});
  if(valid.error){
    res.status(400).send(new ResponErrors().get400());
  }else{
    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send(new ResponErrors().get400());
    }else{
        Chart.deleteChart(valid.value,validateHeader.value,(result)=>{
            !result?
              res.status(403).send(getError(403 , "Products Tidak Ada")) : res.status(200).send(result);
    
        });
    }
  }
});


router.delete('/all', (req, res) => {
  const validation = Joi.validate(req.query,Schema,{escapeHtml: true });
  if(validation.error){
    res.status(400).send(new ResponErrors().get400());
  
  }else{

    const validateHeader = Joi.validate(req.headers.key_api,SchemaHeaders,{escapeHtml: true});
    if(validateHeader.error){
      res.status(400).send(new ResponErrors().get400());
    }else{
      // console.log(validateHeader.value);

      Chart.delete_all(validation.value.id_ktp,validateHeader.value,(result)=>{
        if(!result){
          res.status(400).send(new ResponErrors().get400());
        }else{
          res.status(200).send(new ResponErrors(200,"Data Berhasil Terhapus"));
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
  jumlah : Joi.string().min(1).max(3).required(),
  service : Joi.string().min(5).max(5).required()
}
const SchemaDelete  ={
  id_ktp : Joi.string().min(16).max(16).required(),
  id_kamera : Joi.string().min(5).max(5).required()
}
const SchemaPUT = {
  id_ktp : Joi.string().min(16).max(16).required(),
  id_kamera : Joi.string().min(5).max(5).required(),
  jumlah  : Joi.string().max(2).required(),
  service : Joi.string().min(5).max(5).required()
}
module.exports = router;



