const express = require('express');
const userController = require('../controllers/userController');

const router = express.Router();
const KiemTra = require('../services/KiemTra.services');

router.post('/', KiemTra.CheckLogin, userController.createUser);
router.put('/:id', KiemTra.CheckLogin, userController.updateUser);
router.delete('/:id', KiemTra.CheckLogin, userController.deleteUser);
router.get('/',  KiemTra.CheckLogin, userController.getUsers);
router.get('/:id', KiemTra.CheckLogin,  userController.getUserById);


module.exports = router; 