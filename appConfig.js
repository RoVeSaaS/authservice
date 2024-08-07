
const PORT = process.env.PORT;
const WORKOS_CLIENT_ID = process.env.WORKOS_CLIENT_ID;
const WORKOS_SECRET=process.env.WORKOS_SECRET_KEY;
const WORKOS_REDIRECT_URI = process.env.WORKOS_REDIRECT_URI;

const CORS_OPTIONS ={
    credentials:true,
    origin:['http://localhost:3000']
};

module.exports={PORT,WORKOS_CLIENT_ID,WORKOS_SECRET, CORS_OPTIONS,WORKOS_REDIRECT_URI};