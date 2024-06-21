const ProductPropertiesService = require('../../services/HoaDonMatBao/ProductProperties.service');

exports.createProductProperties = async(req, res, next) =>{
    try{
        const result = await ProductPropertiesService.addProductProperties(req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getProductProperties_ID = async(req, res, next) =>{
    try{
        const {ProdAttr} = req.query;
        const result = await ProductPropertiesService.getProductProperties_ID(ProdAttr);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.deleteProductProperties_ID = async(req, res, next) =>{
    try{
        const {ProdAttr} = req.query;
        const result = await ProductPropertiesService.deleteProductProperties_ID(ProdAttr);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.updateProductProperties_ID = async(req, res, next) =>{
    try{
        const {ProdAttr} = req.query;
        const result = await ProductPropertiesService.updateProductProperties_ID(ProdAttr, req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getAllProductProperties = async(req, res, next) =>{
    try{
        const result = await ProductPropertiesService.getProductProperties();
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}