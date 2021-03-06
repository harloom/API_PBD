
const express = require('express');
const app = express();
// const server = app.listen(3000);
const ResponErrors = require('./utils/errorUtils');
const helmet = require('helmet')
const morgan = require('morgan');
const logins = require('./core/authentication');
const registers = require('./core/regsiter');
const mainAPI  = require('./core/request_list') ;
const keyAPI = require('./security/KeyApi');
const ChartAPI = require('./core/chartRouters');
const KwintasiAPI = require('./core/kwintasiRouters');
const FileDownload = require('./file/fileDownload');
app.use(express.json())
app.use(helmet());
app.use(morgan('tiny'));
app.use(express.urlencoded({extended : true}));
const Joi = require('joi');

const port =3000;
const server =  app.listen(port , () => {
  console.log(`Example app listening on ${port} port!`);
});


  app.use((req,res,next)=> {
    console.log("Logging.......");
    next();
});
app.use((req,res,next)=> {
 
  console.log("authentication......");
  next();
});




//cek KEY
app.post('/api/v1/patrik',(req, res) => {
  const resultValidate = Joi.validate(req.body, keyAPI.Schema, {
    escapeHtml: true
  });
  if(resultValidate.error){
      res.status(400).send(new ResponErrors().get400());
  }else{
    keyAPI(resultValidate.value.key,result =>{
        result ? res.status(200).send({massage : true}) : res.status(200).send({massage : false});
    })
  }
});

//authen/
app.use('/api/v1/authentication',logins);

//register
app.use('/api/v1/register',registers);

//all request
app.use('/api/v1/data' ,mainAPI);

//chart
app.use('/api/v1/charts' ,ChartAPI);

//kwintasi
app.use('/api/v1/kwintasi',KwintasiAPI);


app.use('/api/v1/file' , FileDownload);




const io = require('socket.io').listen(server);
app.get('/', function(req, res){
  req.io = io;
  res.sendFile(__dirname + '/public/index.html');
  
});
io.on('connection', function(socket){
  console.log('a user connected');
});

// error handle
app.use(function (req, res, next) {
  res.status(404).send("Sorry can't find that Senpai!")
});
