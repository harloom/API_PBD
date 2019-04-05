const expess = require('express');
const router = expess.Router( {strict:true});
const User = require('../Objects/User');
const Joi = require('joi');
router.get('/', (req, res) => {
    res.send("API LIST");
});

router.get('/search/:a',(req,res) => {
    res.send(req.params.a);
});

router.get('/profile',(req,res)=>{
    const resValidation = Joi.validate(req.query,ScemeaUserProfile,{ escapeHtml: true })
    if(resValidation.error){
        res.status(400).send(resValidation.error)
    }else{
        User.getUser(resValidation.value.id_ktp,(result)=>{
                if(result.rowsAffected == 0){
                    res.status(404).send({massage : "404 Senpai"});
                }
                res.status(200).send(result.recordset);
        });
    }

});



const ScemeaUserProfile ={
    id_ktp : Joi.string().min(14).max(16).required()

}
module.exports = router;