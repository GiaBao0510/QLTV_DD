const userService = require('../services/userService');
exports.createUser = async (req, res, next) => {
  try {
    const newUser = await userService.createUser(req.body);
    res.status(201).json(newUser);
  } catch (error) {
    next(error);
  }
};

exports.updateUser = async (req, res, next)=>{
  try{
    const update = await userService.updateUser(req.params.id,req.body);
    if(!update){
      return res.status(404).json({message:'User not found'});
    }
    return res.status(200).json({message: 'User was update successfully'})
  }catch(error){
    next(error);
  }
}

exports.deleteUser = async (req, res, next)=>{
  try{
    const deleted = await userService.deleteUser(req.params.id);
    if(!deleted){
      return res.status(404).json({message:'User not found'});
    }
    return res.status(200).json({message: 'User was delete successfully'})
  }catch(error){
    next(error);
  }
}
exports.getUsers = async (req, res, next) => {
  try {
    const users = await userService.getAllUsers();
    res.status(200).json(users);
  } catch (error) {
    next(error);
  }
};

exports.getUserById = async (req, res, next) => {
  try {
    const user = await userService.getUserById(req.params.id);
    res.status(200).json(user);
  } catch (error) {
    next(error);
  }
};