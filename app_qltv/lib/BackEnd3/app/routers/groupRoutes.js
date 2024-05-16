const express = require('express');
const groupController = require('../controllers/groupController.js');

const router = express.Router();

router.post('/', groupController.createGroupUser);
router.put('/:id',groupController.updateGroupUser);
router.delete('/:id',groupController.deleteGroupUser);
router.get('/', groupController.getGroupUsers);
router.get('/:id', groupController.getGroupUserById);

module.exports = router;