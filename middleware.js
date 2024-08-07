const errorHandler = (err,req,res,next)=>{
    const errorMsg = err.stack.toString();
    res.sendStatus(500).json({status:'FAILED',message: errorMsg});
}

module.exports=errorHandler;