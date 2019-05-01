module.exports = class ResponError {
  constructor(statusCode, massage) {
    this.statusCode = statusCode;
    this.massage = massage;
  }

  getstatusCode() {
    return this.statusCode ; 
  }
  getMassage(){
    return this.massage;
  }

  get401(){
    return{
      statusCode : 401,
      massage   : "401 Unauthorized Senpai"
    }
  }
  get400(){
    return{
      statusCode : 400,
      massage   : "400 Bad Request Senpai"
    }
  }
  get404(){
    return{
      statusCode  : 404,
      massage : "404 Not Found Senpai"
    }
  }

  get403Product(){
    return{
      statusCode  : 403,
      massage : "Product in Chart Senpai"
    }
  }

}
