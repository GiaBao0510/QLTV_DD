const express = require('express');
const productTypeController = require('../controllers/productTypeController');

const router = express.Router();
const KiemTra = require('../services/KiemTra.servie');

router.post('/', KiemTra.CheckLogin, productTypeController.createProductType);
router.put('/:id', KiemTra.CheckLogin,productTypeController.updateProductType);
router.delete('/:id', KiemTra.CheckLogin,productTypeController.deleteProductType);
router.get('/', KiemTra.CheckLogin, productTypeController.getType);
router.get('/:id', KiemTra.CheckLogin, productTypeController.getTypeById);

module.exports = router;