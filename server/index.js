// improt from packages

const express = require('express'); 
const mongoose = require('mongoose');

// import from other files
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');

//init
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://rabi3hs:97152897@cluster0.awmmuet.mongodb.net/?retryWrites=true&w=majority"

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);


//connections
mongoose.connect(DB).then(()=>{
    console.log('Connection Successful')
}).catch(e=>{
    console.log(e);
});

app.listen(PORT,"0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);

});