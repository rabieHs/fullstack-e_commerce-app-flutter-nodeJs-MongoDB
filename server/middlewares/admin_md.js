const JWT = require('jsonwebtoken');
const User = require('../models/user');
const admin = async(req,res,next)=>{
try{
    const token = req.header("x-auth-token");
if (!token) {
  return res.status(401).json({ msg: "no auth token, access denied" });
}
const verfied = JWT.verify(token, "passwordKey");
if (!verfied) {
  return res.status(401).json({msg:'token verification failed, authorization denied'});
  
}
const user = await User.findById(verfied.id);
if(user.type =='user'||user.type=='seller'){
    return res.status(401).json({msg:'You are not an admin!'})
}
req.user = verfied.id;
req.token = token;
next();}catch(err){
    res.status(500).json({ error: err.message });
}
}
module.exports = admin;