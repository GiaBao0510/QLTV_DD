const express = require('express');
const phieucam = require('../controllers/camvangCotroller');
const router = express.Router();

router.route('/dangcam').get(phieucam.getPhieuDangCam);
router.route('/dangcam/:id').get(phieucam.getPhieuDangCamById)
router.route('/chitietphieucam').get(phieucam.getChiTietPhieuCam);
router.route('/chitietphieucam/:id').get(phieucam.getChiTietPhieuCamById)

module.exports = router;