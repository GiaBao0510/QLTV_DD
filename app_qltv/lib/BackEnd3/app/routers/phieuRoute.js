const express = require('express');
const phieucam = require('../controllers/baoCaoPhieu');
const router = express.Router();

router.route('/phieuxuat').get(phieucam.getPhieuXuat);
router.route('/phieuxuat/:id').get(phieucam.getPhieuXuatById)
router.route('/tonkho').get(phieucam.getTonKho);
router.route('/tonkho/:id').get(phieucam.getTonKhoById)

module.exports = router;