const jwt = require('jsonwebtoken');
const jwksClient = require('jwks-rsa');
const { WORKOS_CLIENT_ID } = require('./appConfig');

const verifyToken = async (accessToken,workos)=>{
  const result ={
    status: false,
    token: null,
    message:''
  };
  try{
     const jwksUrl = workos.userManagement.getJwksUrl(WORKOS_CLIENT_ID);
    const client = jwksClient({
      jwksUri:jwksUrl
    });
    const jwtKey = await client.getSigningKey();
    const tokenInfo = jwt.verify(accessToken,jwtKey.getPublicKey());
    return {...result, status: true, token: tokenInfo};
  }catch(err){
    return {...result,message: err}
  }
};

const extractBearerToken =(tokenStr)=>{
  if(tokenStr){
    const terms = tokenStr.split(" ");
    return terms[1] || null;
  }
  return null;
};

module.exports={verifyToken,extractBearerToken};