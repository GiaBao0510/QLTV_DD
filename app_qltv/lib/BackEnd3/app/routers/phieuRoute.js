const express = require('express');

const phieucam = require('../controllers/baoCaoPhieu');
const router = express.Router();

router.route('/phieuxuat').get(phieucam.getPhieuXuat);
router.route('/phieuxuattheongay').get(phieucam.getPhieuXuatByDate);
router.route('/phieuxuat/:id').get(phieucam.getPhieuXuatById);
router.route('/tonkho').get(phieucam.getTonKho);
router.route('/tonkho/:id').get(phieucam.getTonKhoById);
router.route('/tonkhoproduct').get(phieucam.getTonKhoGroupProduct);
router.route('/phieumua').get(phieucam.getBCPhieuMuaVao);
router.route('/phieumuatheongay').get(phieucam.getBCPhieuMuaVaoByDate);
router.route('/phieumua/:id').get(phieucam.getBCPhieuMuaVaoById);
module.exports = router;
