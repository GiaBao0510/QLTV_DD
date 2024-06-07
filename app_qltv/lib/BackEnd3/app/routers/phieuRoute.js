const express = require('express');
const phieucam = require('../controllers/baoCaoPhieu');
const router = express.Router();
const KiemTra = require('../services/KiemTra.services');

router.route('/phieuxuat').get( KiemTra.CheckLogin,phieucam.getPhieuXuat);
router.route('/phieuxuattheongay').get(KiemTra.CheckLogin,  phieucam.getPhieuXuatByDate);
router.route('/phieuxuat/:id').get( KiemTra.CheckLogin, phieucam.getPhieuXuatById)
router.route('/tonkho').get( KiemTra.CheckLogin, phieucam.getTonKho);
router.route('/tonkho/:id').get( KiemTra.CheckLogin, phieucam.getTonKhoById)
router.route('/tonkhoproduct').get( KiemTra.CheckLogin, phieucam.getTonKhoGroupProduct);
router.route('/tonkhoproduct/:id').get( KiemTra.CheckLogin,phieucam.getTonKhoGroupProductById);
router.route('/khovangmuavao').get( KiemTra.CheckLogin,phieucam.getKhoVangMuaVaoController);
router.route('/phieumua').get( KiemTra.CheckLogin,phieucam.getBCPhieuMuaVao);
router.route('/phieumuatheongay').get(KiemTra.CheckLogin,phieucam.getBCPhieuMuaVaoByDate);
router.route('/phieumua/:id').get( KiemTra.CheckLogin,phieucam.getBCPhieuMuaVaoById);
module.exports = router;
