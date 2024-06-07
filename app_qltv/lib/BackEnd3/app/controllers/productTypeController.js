const productTypeService = require('../services/productTypeServices');
exports.createProductType = async (req, res, next) => {
  try {
    const newUser = await productTypeService.createProductType(req.body);
    res.status(200).json(newUser);
  } catch (error) {
    next(error);
  }
};

exports.updateProductType = async (req, res, next)=>{
  try{
    const update = await productTypeService.updateProductType(req.params.id,req.body);
    if(!update){
      return res.status(404).json({message:'User not found'});
    }
    return res.status(200).json({message: 'User was update successfully'})
  }catch(error){
    next(error);
  }
}
exports.deleteProductType = async (req, res, next)=>{
  try{
    const deleted = await productTypeService.deleteProductType(req.params.id);
    if(!deleted){
      return res.status(404).json({message:'User not found'});
    }
    return res.status(200).json({message: 'User was delete successfully'})
  }catch(error){
    next(error);
  }
}
exports.getType = async (req, res, next) => {
  try {
    const users = await productTypeService.getAllProductType();
    res.status(200).json(users);
  } catch (error) {
    next(error);
  }
};

exports.getTypeById = async (req, res, next) => {
  try {
    const user = await productTypeService.getProductTypeById(req.params.id);
    res.status(200).json(user);
  } catch (error) {
    next(error);
  }
};
