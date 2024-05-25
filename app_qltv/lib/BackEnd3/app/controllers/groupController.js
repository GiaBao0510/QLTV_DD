const groupService = require('../services/groupServices');

exports.createGroupUser = async (req, res, next) => {
  try {
    const newUser = await groupService.createGroupUser(req.body);
    res.status(200).json(newUser);
  } catch (error) {
    next(error);
  }
};

exports.updateGroupUser = async (req, res, next)=>{
  try{
    const update = await groupService.updateGroupUser(req.params.id,req.body);
    if(!update){
      return res.status(404).json({message:'User not found'});
    }
    return res.status(200).json({message: 'User was update successfully'})
  }catch(error){
    next(error);
  }
}
exports.deleteGroupUser = async (req, res, next)=>{
  try{
    const deleted = await groupService.deleteGroupUser(req.params.id);
    if(!deleted){
      return res.status(404).json({message:'User not found'});
    }
    return res.status(200).json({message: 'User was delete successfully'})
  }catch(error){
    next(error);
  }
}
exports.getGroupUsers = async (req, res, next) => {
  try {
    const users = await groupService.getAllGroupUsers();
    res.status(200).json(users);
  } catch (error) {
    next(error);
  }
};
exports.getGroupUserById = async (req, res, next) => {
  try {
    const user = await groupService.getGroupUserById(req.params.id);
    res.status(200).json(user);
  } catch (error) {
    next(error);
  }
};
