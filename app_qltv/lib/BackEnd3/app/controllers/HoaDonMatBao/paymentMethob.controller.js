const PaymentMethodService = require('../../services/HoaDonMatBao/PaymentMethob.service');

exports.createPaymentMethob = async(req, res, next) =>{
    try{
        const result = await PaymentMethodService.addPaymentMethobs(req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getPaymentMethob_ID = async(req, res, next) =>{
    try{
        const {ID_PM} = req.query;
        const result = await PaymentMethodService.getPaymentMethob_ID(ID_PM);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.deletePaymentMethob_ID = async(req, res, next) =>{
    try{
        const {ID_PM} = req.query;
        const result = await PaymentMethodService.deletePaymentMethob_ID(ID_PM);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.updatePaymentMethob_ID = async(req, res, next) =>{
    try{
        const {ID_PM} = req.query;
        const result = await PaymentMethodService.updatePaymentMethob_ID(ID_PM, req.body);
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}

exports.getAllPaymentMethob = async(req, res, next) =>{
    try{
        const result = await PaymentMethodService.getPaymentMethobs();
        res.status(200).json(result);
    }catch(err){
        next(err);
    }
}