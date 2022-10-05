const express = require('express');
const userRouter = express.Router();
const auth = require('../middlewares/auth_md');
const { Product } = require('../models/product');
const User = require('../models/user');

//add to cart
userRouter.post('/api/add-to-cart',auth,async(req,res)=>{
    try{
       const{id}=req.body;
       const product = await Product.findById(id);
       let user =await  User.findById(req.user);
       if(user.cart.length ==0){
        user.cart.push({product,quantity:1});
       }else{
        let isProductFound = false;
        for(let i=0;i<user.cart.length;i++){
            if(user.cart[i].product._id.equals(product._id)){
                isProductFound = true;
                
            }
        }
        if(isProductFound){
            let producttt = user.cart.find((productt)=>productt.product._id.equals(product._id));
            producttt.quantity +=1;
        
        }else{
            user.cart.push({product,quantity:1});
        }
       }
       user = await user.save();
       res.json(user);
    }catch(e){
        res.status(500).json({error: e.message})
    }
});

//remove from cart
userRouter.delete('/api/remove-from-cart/:id',auth,async(req,res)=>{
    try{
       const{id}=req.params;
       const product = await Product.findById(id);
       let user =await  User.findById(req.user);
      
        for(let i=0;i<user.cart.length;i++){
            if(user.cart[i].product._id.equals(product._id)){
                if(user.cart[i].quantity ==1){
                    user.cart.splice(i,1);
                }else{
                    user.cart[i].quantity -=1;
                }
                
                
            }
        }
       
       
       user = await user.save();
       res.json(user);
    }catch(e){
        res.status(500).json({error: e.message})
    }
});
module.exports = userRouter;