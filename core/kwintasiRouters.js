const expess = require('express');
const router = expess.Router( );
const Kwintasi = require('../Objects/Kwintasi');
const Joi = require('joi');
const SchemaKey = require('../utils/nyaw');


router.use((req,res,next)=> {
  console.log("Request  Kwintasi Fun...");
  next();
});


router.get('/:id', (req, res) => {
  try {
    
    const validHeaders = Joi.validate(req.headers.key_api,SchemaKey,{escapeHtml:true});
    const validParams = Joi.validate(req.params.id,ShemaIdKTP,{escapeHtml:true});
    if(validHeaders.error || validParams.error){
      console.dir("headers : "+validHeaders);
      console.dir("params : "+validParams);
      res.status(500).json(validParams)
      // res.status(500).send({massage : "500 Internal Server Error"});
    }else{
        Kwintasi.getViewKwitansi(validHeaders.value,validParams.value,(result)=>{
          if(result){
            res.status(200).send(result);
          }else{
            res.status(404).send({massage : 'Error 404'});
          }
          
        })
      }
    } catch (error) {
      // res.status(500).send({massage : "500 Internal Server Error"});
      console.log(error);
    }

  });

router.post('/', (req, res) => {
    const validHeaders = Joi.validate(req.headers.key_api,SchemaKey,{escapeHtml:true});
    if(validHeaders.error){
      res.status(401).send({massage : "401 Unauthorized"});
    }else{
        const valid = Joi.validate(req.body,ScemaKwintasi,{escapeHtml:true});
        if(valid.error){
          console.log(valid.error)
          res.status(400).send({massage: "400 Bad Request Senpai"})
        }else{
          Kwintasi.PostKwin(validHeaders.value,valid.value,(resuult)=>{
            res.status(200).send(resuult);  
          });
        }
    
    }

});
router.put('/', (req, res) => {
  
});

router.delete('/', (req, res) => {
  
});


router.get('/detail/:id', (req, res) => {
  try {
    
    const validHeaders = Joi.validate(req.headers.key_api,SchemaKey,{escapeHtml:true});
    const validParams = Joi.validate(req.params.id,ShemaNoKwitansi,{escapeHtml:true});
    if(validHeaders.error || validParams.error){
    
      res.status(500).json(validParams)
      // res.status(500).send({massage : "500 Internal Server Error"});
    }else{
        Kwintasi.getDetail(validHeaders.value,validParams.value,(result)=>{
          if(result){
            res.status(200).send(result);
          }else{
            res.status(404).send({massage : 'Error 404'});
          }
          
        })
      }
    } catch (error) {
      // res.status(500).send({massage : "500 Internal Server Error"});
      console.log(error);
    }

  });

const ScemaKwintasi = {
  no_kwitansi : Joi.string().min(10).max(10).required(),
  id_ktp : Joi.string().min(16).max(16).required(),
  lama : Joi.number().min(1).max(10).required(),
  id_service : Joi.string().valid(["S0001","S0002"]).required() ,
  alamat_antar : Joi.string().min(0).max(200)


}

const ShemaIdKTP = Joi.string().min(16).max(16).required();
const ShemaNoKwitansi = Joi.string().min(10).max(10).required();
module.exports = router;

