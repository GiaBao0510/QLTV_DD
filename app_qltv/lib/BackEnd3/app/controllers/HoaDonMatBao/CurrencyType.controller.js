const CurrencyTypeService = require('../../services/HoaDonMatBao/CurrencyType.service');

exports.createCurrencyType = async(req, res, next) =>{
    try{
        const result = await CurrencyTypeService.addCurrencyTypes(req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getCurrencyType_ID = async(req, res, next) =>{
    try{
        const {SoDVTT} = req.query;
        const result = await CurrencyTypeService.getCurrencyType_ID(SoDVTT);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.deleteCurrencyType_ID = async(req, res, next) =>{
    try{
        const {SoDVTT} = req.query;
        const result = await CurrencyTypeService.deleteCurrencyType_ID(SoDVTT);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.updateCurrencyType_ID = async(req, res, next) =>{
    try{
        const {SoDVTT} = req.query;
        const result = await CurrencyTypeService.updateCurrencyType_ID(SoDVTT, req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getAllCurrencyType = async(req, res, next) =>{
    try{
        const result = await CurrencyTypeService.getCurrencyTypes();
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}