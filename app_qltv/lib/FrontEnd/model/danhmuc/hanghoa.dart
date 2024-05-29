// database danh_muc_hang_hoa

class HangHoa {
  final int? hangHoaId;
  final String? hangHoaMa;
  final String? loaiId;
  final String? dvtId;
  final String? nhomHangId;
  final String? nccId;
  final int? giamGiaId;
  final String? hangHoaTen;
  final double? giaBan;
  final int? vat;
  final int? thue;
  final int? suDung;
  final int? danhDau;
  final int? slIn;
  final String? ghiChu;
  final int? taoMa;
  final double? giaBanSi;
  final double? canTong;
  final double? tlHot;
  final double? giaCong;
  final double? donGiaGoc;
  final double? congGoc;
  final double? tuoiBan;
  final double? tuoiMua;
  final String? xuatXu;
  final String? kyHieu;
  final String? ngay;
  final int? soLuong;

  HangHoa({
    this.hangHoaId,
    this.hangHoaMa,
    this.loaiId,
    this.dvtId,
    this.nhomHangId,
    this.nccId,
    this.giamGiaId,
    this.hangHoaTen,
    this.giaBan,
    this.vat,
    this.thue,
    this.suDung,
    this.danhDau,
    this.slIn,
    this.ghiChu,
    this.taoMa,
    this.giaBanSi,
    this.canTong,
    this.tlHot,
    this.giaCong,
    this.donGiaGoc,
    this.congGoc,
    this.tuoiBan,
    this.tuoiMua,
    this.xuatXu,
    this.kyHieu,
    this.ngay,
    this.soLuong,
  });

  HangHoa copyWith({
    int? hangHoaId,
    String? hangHoaMa,
    String? loaiId,
    String? dvtId,
    String? nhomHangId,
    String? nccId,
    int? giamGiaId,
    String? hangHoaTen,
    double? giaBan,
    int? vat,
    int? thue,
    int? suDung,
    int? danhDau,
    int? slIn,
    String? ghiChu,
    int? taoMa,
    double? giaBanSi,
    double? canTong,
    double? tlHot,
    double? giaCong,
    double? donGiaGoc,
    double? congGoc,
    double? tuoiBan,
    double? tuoiMua,
    String? xuatXu,
    String? kyHieu,
    String? ngay,
    int? soLuong,
  }) {
    return HangHoa(
      hangHoaId: hangHoaId ?? this.hangHoaId,
      hangHoaMa: hangHoaMa ?? this.hangHoaMa,
      loaiId: loaiId ?? this.loaiId,
      dvtId: dvtId ?? this.dvtId,
      nhomHangId: nhomHangId ?? this.nhomHangId,
      nccId: nccId ?? this.nccId,
      giamGiaId: giamGiaId ?? this.giamGiaId,
      hangHoaTen: hangHoaTen ?? this.hangHoaTen,
      giaBan: giaBan ?? this.giaBan,
      vat: vat ?? this.vat,
      thue: thue ?? this.thue,
      suDung: suDung ?? this.suDung,
      danhDau: danhDau ?? this.danhDau,
      slIn: slIn ?? this.slIn,
      ghiChu: ghiChu ?? this.ghiChu,
      taoMa: taoMa ?? this.taoMa,
      giaBanSi: giaBanSi ?? this.giaBanSi,
      canTong: canTong ?? this.canTong,
      tlHot: tlHot ?? this.tlHot,
      giaCong: giaCong ?? this.giaCong,
      donGiaGoc: donGiaGoc ?? this.donGiaGoc,
      congGoc: congGoc ?? this.congGoc,
      tuoiBan: tuoiBan ?? this.tuoiBan,
      tuoiMua: tuoiMua ?? this.tuoiMua,
      xuatXu: xuatXu ?? this.xuatXu,
      kyHieu: kyHieu ?? this.kyHieu,
      ngay: ngay ?? this.ngay,
      soLuong: soLuong ?? this.soLuong,
    );
  }

  // Phương thức để chuyển đổi từ Map sang đối tượng HangHoa
  factory HangHoa.fromMap(Map<String, dynamic> map) {
    return HangHoa(
      hangHoaId: map['HANGHOAID'] ?? 0,
      hangHoaMa: map['HANGHOAMA'] ?? '',
      loaiId: map['LOAIID'] ?? '',
      dvtId: map['DVTID'] ?? '',
      nhomHangId: map['NHOMHANGID'] ?? '',
      nccId: map['NCCID'] ?? '',
      giamGiaId: map['GIAM_GIA_ID'] ?? 0,
      hangHoaTen: map['HANG_HOA_TEN'] ?? '',
      giaBan: (map['GIA_BAN'] == null) ? null : (map['GIA_BAN'] as num).toDouble(),
      vat: map['VAT'] ?? 0,
      thue: map['THUE'] ?? 0,
      suDung: map['SU_DUNG'] ?? 0,
      danhDau: map['DANH_DAU'] ?? 0,
      slIn: map['SL_IN'] ?? 0,
      ghiChu: map['GHI_CHU'] ?? '',
      taoMa: map['TAO_MA'] ?? 0,
      giaBanSi: (map['GIA_BAN_SI'] == null) ? null : (map['GIA_BAN_SI'] as num).toDouble(),
      canTong: (map['CAN_TONG'] == null) ? null : (map['CAN_TONG'] as num).toDouble(),
      tlHot: (map['TL_HOT'] == null) ? null : (map['TL_HOT'] as num).toDouble(),
      giaCong: (map['GIA_CONG'] == null) ? null : (map['GIA_CONG'] as num).toDouble(),
      donGiaGoc: (map['DON_GIA_GOC'] == null) ? null : (map['DON_GIA_GOC'] as num).toDouble(),
      congGoc: (map['CONG_GOC'] == null) ? null : (map['CONG_GOC'] as num).toDouble(),
      tuoiBan: (map['TUOI_BAN'] == null) ? null : (map['TUOI_BAN'] as num).toDouble(),
      tuoiMua: (map['TUOI_MUA'] == null) ? null : (map['TUOI_MUA'] as num).toDouble(),
      xuatXu: map['XUAT_XU'] ?? '',
      kyHieu: map['KY_HIEU'] ?? '',
      ngay: map['NGAY'] ?? '',
      soLuong: map['SO_LUONG'] ?? 0,
    );
  }

  // Phương thức để chuyển đổi đối tượng HangHoa sang Map
  Map<String, dynamic> toMap() {
    return {
      'HANGHOAID': hangHoaId,
      'HANGHOAMA': hangHoaMa,
      'LOAIID': loaiId,
      'DVTID': dvtId,
      'NHOMHANGID': nhomHangId,
      'NCCID': nccId,
      'GIAM_GIA_ID': giamGiaId,
      'HANG_HOA_TEN': hangHoaTen,
      'GIA_BAN': giaBan,
      'VAT': vat,
      'THUE': thue,
      'SU_DUNG': suDung,
      'DANH_DAU': danhDau,
      'SL_IN': slIn,
      'GHI_CHU': ghiChu,
      'TAO_MA': taoMa,
      'GIA_BAN_SI': giaBanSi,
      'CAN_TONG': canTong,
      'TL_HOT': tlHot,
      'GIA_CONG': giaCong,
      'DON_GIA_GOC': donGiaGoc,
      'CONG_GOC': congGoc,
      'TUOI_BAN': tuoiBan,
      'TUOI_MUA': tuoiMua,
      'XUAT_XU': xuatXu,
      'KY_HIEU': kyHieu,
      'NGAY': ngay,
      'SO_LUONG': soLuong,
    };
  }
}
