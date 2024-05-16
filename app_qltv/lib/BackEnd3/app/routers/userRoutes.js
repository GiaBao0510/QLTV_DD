const express = require('express');
const userController = require('../controllers/userController');

const router = express.Router();

router.post('/', userController.createUser);
router.put('/:id',userController.updateUser);
router.delete('/:id',userController.deleteUser);
router.get('/', userController.getUsers);
router.get('/:id', userController.getUserById);


module.exports = router;