const ProductsService = require('../../services/HoaDonMatBao/Products.service');

exports.createProducts = async(req, res, next) =>{
    try{
        const result = await ProductsService.addProducts(req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getProducts_ID = async(req, res, next) =>{
    try{
        const {Code} = req.query;
        const result = await ProductsService.getProducts_ID(Code);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.deleteProducts_ID = async(req, res, next) =>{
    try{
        const {Code} = req.query;
        const result = await ProductsService.deleteProducts_ID(Code);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.updateProducts_ID = async(req, res, next) =>{
    try{
        const {Code} = req.query;
        const result = await ProductsService.updateProducts_ID(Code, req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getAllProducts = async(req, res, next) =>{
    try{
        const result = await ProductsService.getProducts();
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.CheckProductAlreadyExists = async(req, res, next) =>{
    try{
        const {Code} = req.query;
        const result = await ProductsService.CheckProductAlreadyExists(Code);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}
