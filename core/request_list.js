const expess = require('express');
const router = expess.Router();
const User = require('../Objects/User');
const Product = require('../Objects/Products');
const Service = require('../Objects/Services');
const Joi = require('joi');
const ResponErrors = require('../utils/errorUtils');

function getError(code  , massage){
  return new ResponErrors(code,massage);
}
router.get('/', (req, res) => {
    res.send("API LIST");
});

router.get('/search/:a',(req,res) => {
    res.send(req.params.a);
});

router.get('/profile',(req,res)=>{
    const resValidation = Joi.validate(req.query,ScemeaUserProfile,{ escapeHtml: true })
    if(resValidation.error){
        res.status(400).send(getError(404,resValidation.error.message));
    }else{
        User.getUser(resValidation.value.id_ktp,(result)=>{
                if(result.rowsAffected == 0){
                    res.status(404).send(new ResponErrors().get404());
                }else{
                    res.status(200).send(result.recordset);
            }
            
        });
    }

});

router.get('/products', (req, res) => {
    Product.getProducts(result=>{
        res.status(200).send(result.recordset);
    });
});

router.get('/products/:id', (req,res )=>{
    const valid  = Joi.validate(req.params,SchemaProduct , {escapeHtml : true})
    if(valid.error){
        res.status(400).send(getError(400,valid.error.message))
    }else{
        Product.product(valid.value.id, (result) =>{
            if(result.rowsAffected == 0 ){
                res.status(404).send(new ResponErrors().get404());
            }else{
                res.status(200).send(result.recordset)
            }
            
        })
    }
});

router.get('/services',(req,res) =>{
    Service.getServices(result =>{
        res.status(200).send(result.recordset);
    })
});

router.get('/services/:id',(req,res) =>{
    const valid = Joi.validate(req.params,SchemaService,{escapeHtml:true});
    if(valid.error){
        res.status(400).send(getError(400,valid.error.message));
    }else{
    
        Service.service(valid.value.id, (result) =>{
            if(result.rowsAffected == 0 ){
                res.status(404).send(new ResponErrors().get404());
            }
            res.status(200).send(result.recordset);
        });
    }
});


const ScemeaUserProfile ={
    id_ktp : Joi.string().min(16).max(16).required()

}
const SchemaProduct = {
    id : Joi.string().min(5).max(5).required()
}

const SchemaService = {
    id : Joi.string().min(5).max(5).required()
}
module.exports = router;