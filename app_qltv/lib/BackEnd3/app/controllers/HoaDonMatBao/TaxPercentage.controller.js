const TaxPercentageService = require('../../services/HoaDonMatBao/TaxPercentage.service');

exports.createTaxPercentage = async(req, res, next) =>{
    try{
        const result = await TaxPercentageService.addTaxPercentage(req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getTaxPercentage_ID = async(req, res, next) =>{
    try{
        const {VATRate} = req.query;
        const result = await TaxPercentageService.getTaxPercentage_ID(VATRate);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.deleteTaxPercentage_ID = async(req, res, next) =>{
    try{
        const {VATRate} = req.query;
        const result = await TaxPercentageService.deleteTaxPercentage_ID(VATRate);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.updateTaxPercentage_ID = async(req, res, next) =>{
    try{
        const {VATRate} = req.query;
        const result = await TaxPercentageService.updateTaxPercentage_ID(VATRate, req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getAllTaxPercentage = async(req, res, next) =>{
    try{
        const result = await TaxPercentageService.getTaxPercentages();
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}