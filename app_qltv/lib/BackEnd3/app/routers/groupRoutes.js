const express = require('express');
const groupController = require('../controllers/groupController.js');
const KiemTra = require('../services/KiemTra.servie');
const router = express.Router();

router.post('/', KiemTra.CheckLogin,groupController.createGroupUser);
router.put('/:id', KiemTra.CheckLogin,groupController.updateGroupUser);
router.delete('/:id', KiemTra.CheckLogin,groupController.deleteGroupUser);
router.get('/', KiemTra.CheckLogin, groupController.getGroupUsers);
router.get('/:id', KiemTra.CheckLogin, groupController.getGroupUserById);

module.exports = router;