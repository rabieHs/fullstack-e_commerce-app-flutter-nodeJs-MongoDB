const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth_md');
const Product = require('../models/product');
module.exports = productRouter;

//get category
//api/products?category=mobiles
//{api/products:category=mobiles
//console.log(req.params.category)} 
productRouter.get('/api/products',auth,async(req,res)=>{
try{
    console.log(req.query.category);
    const product = await Product.find({category: req.query.category});
    res.json(product);
}catch(e){
    res.status(500).json({error: e.message});
}
});
productRouter.get('/api/products/search/:name',auth,async(req,res)=>{
    try{
        const searchedproducts = await Product.find({name:{$regex:req.params.name,$options:"i"}});
        res.json(searchedproducts);
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

