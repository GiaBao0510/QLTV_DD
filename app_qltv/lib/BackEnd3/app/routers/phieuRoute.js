const express = require('express');
const phieucam = require('../controllers/baoCaoPhieu');
const router = express.Router();
const KiemTra = require('../services/KiemTra.servie');

router.route('/phieuxuat').get( KiemTra.CheckLogin,phieucam.getPhieuXuat);
router.route('/phieuxuattheongay').get(KiemTra.CheckLogin, phieucam.getPhieuXuatByDate);
router.route('/phieuxuat/:id').get( KiemTra.CheckLogin,phieucam.getPhieuXuatById)
router.route('/tonkho').get( KiemTra.CheckLogin,phieucam.getTonKho);
router.route('/tonkho/:id').get( KiemTra.CheckLogin,phieucam.getTonKhoById)
router.route('/tonkhoproduct').get( KiemTra.CheckLogin,phieucam.getTonKhoGroupProduct);
// router.route('/tonkhoproduct/:id').get(phieucam.getTonKhoGroupProductById);

module.exports = router;