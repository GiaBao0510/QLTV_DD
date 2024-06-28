const InvoiceTypeService = require('../../services/HoaDonMatBao/InvoiceType.service');

exports.createInvoiceType = async(req, res, next) =>{
    try{
        const result = await InvoiceTypeService.addInvoiceTypes(req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getInvoiceType_ID = async(req, res, next) =>{
    try{
        const {InvType} = req.query;
        const result = await InvoiceTypeService.getInvoiceType_ID(InvType);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.deleteInvoiceType_ID = async(req, res, next) =>{
    try{
        const {InvType} = req.query;
        const result = await InvoiceTypeService.deleteInvoiceType_ID(InvType);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.updateInvoiceType_ID = async(req, res, next) =>{
    try{
        const {InvType} = req.query;
        const result = await InvoiceTypeService.updateInvoiceType_ID(InvType, req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getAllInvoiceType = async(req, res, next) =>{
    try{
        const result = await InvoiceTypeService.getInvoiceTypes();
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}