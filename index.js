
const express = require('express');
const app = express();
const Joi = require('joi');
const helmet = require('helmet')
const morgan = require('morgan');
const logins = require('./authentication');
const registers = require('./regsiter');
const requests  = require('./main_api/request_list') ;
app.use(express.json())
app.use(helmet());
app.use(morgan('tiny'));

//config  
const config = {
  user: '...',
  password: '...',
  server: 'localhost',
  database: '...',
  pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000
  }
}

app.use((req,res,next)=> {
  console.log("Logging.......");
  next();
});
app.use((req,res,next)=> {
  console.log("authentication......");
  next();
});



//authen
app.use('/api/v1/authentication',logins);

//register
app.use('/api/v1/register',registers);

//all request
app.use('/api/v1/data' ,requests );


// error handle
app.use(function (req, res, next) {
  res.status(404).send("Sorry can't find that Senpai!")
});

const port =3000;
app.listen(port , () => {
  console.log(`Example app listening on ${port} port!`);
});

