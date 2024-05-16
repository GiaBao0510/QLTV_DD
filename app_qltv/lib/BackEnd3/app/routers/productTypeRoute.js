const express = require('express');
const productTypeController = require('../controllers/productTypeController');

const router = express.Router();

router.post('/', productTypeController.createProductType);
router.put('/:id',productTypeController.updateProductType);
router.delete('/:id',productTypeController.deleteProductType);
router.get('/', productTypeController.getType);
router.get('/:id', productTypeController.getTypeById);

module.exports = router;