const express = require('express');
const phieucam = require('../controllers/camvangCotroller');
const router = express.Router();
const KiemTra = require('../services/KiemTra.services');

router.route('/dangcam').get( KiemTra.CheckLogin, phieucam.getPhieuDangCam);
router.route('/dangcam/:id').get(KiemTra.CheckLogin, phieucam.getPhieuDangCamById)
router.route('/chitietphieucam').get(KiemTra.CheckLogin, phieucam.getChiTietPhieuCam);
router.route('/chitietphieucam/:id').get(KiemTra.CheckLogin, phieucam.getChiTietPhieuCamById)

module.exports = router;