const userService = require('../services/userService');
exports.createUser = async (req, res, next) => {
  try {
    const newUser = await userService.createUser(req.body);
    res.status(200).json(newUser);
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
exports.countUsers = async (req, res, next) => {
  try {
    const userCount = await userService.getAllUsers();
    console.log("User Count:", userCount); // Thêm log để kiểm tra giá trị
    res.status(200).json({ totalUsers: userCount });
  } catch (error) {
    console.error('Error in countUsers controller:', error); // Log lỗi
    next(error);
  }
};
exports.getUsers = async (req, res, next) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    const offset = (page -1 ) *pageSize;
    const usersdata = await userService.getAllUsersWithPagination(pageSize, offset);
    const total = await userService.getAllUsers();
    const totalPages = Math.ceil(total/pageSize);
    res.status(200).json({
      page,
      pageSize,
      totalPages,
      totalRows:total,
      data: usersdata
    });
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