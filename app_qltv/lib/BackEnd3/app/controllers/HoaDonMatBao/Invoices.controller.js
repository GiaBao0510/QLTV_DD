const InvoicesServices = require('../../services/HoaDonMatBao/Invoices.service');

exports.createInvoice = async(req, res, next) =>{
    try{
        const newInvoice = await InvoicesServices.addInvoice(req.body);
        res.status(200).json(newInvoice);
    }catch(err){
        next(err); 
    }
}

exports.GetInvoices = async(req, res, next)=>{
    try{
        const get = await InvoicesServices.getInvoices();
        res.status(200).json(get);
    }catch(err){
        next(err);
    }
}

exports.GetInvoiceID = async(req, res, next)=>{
    try{
        const {Fkey} = req.query;
        const get = await InvoicesServices.getInvoice_ID(Fkey);
        res.status(200).json(get);
    }catch(err){
        next(err);
    }
}

exports.DeleteInvoiceID = async(req, res, next) =>{
    try{
        const {Fkey} = req.query;
        const deleteCus = await InvoicesServices.deleteInvoice_ID(Fkey);
        res.status(200).json(deleteCus);
    }catch(err){
        next(err);
    }
}

exports.UpdateInvoiceID = async(req, res, next) => {
    try{
        const {Fkey} = req.query;
        const update = await InvoicesServices.updateInvoice_ID(Fkey, req.body);
        res.status(200).json(update);
    }catch(err){
        next(err);
    }
}