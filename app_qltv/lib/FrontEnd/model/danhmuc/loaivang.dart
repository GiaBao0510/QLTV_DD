// database : nhom_hang

class LoaiVang {
  final String? nhomHangId;
  final String? nhomHangMa;
  final int? nhomChaId;
  final String? nhomTen;
  final double? donGiaBan;
  final double? donGiaMua;
  final int? muaBan;
  final double? donGiaVon;
  final double? donGiaCam;
  final int? suDung;
  final String? ghiChu;

  LoaiVang({
    this.nhomHangId,
    this.nhomHangMa,
    this.nhomChaId,
    this.nhomTen,
    this.donGiaBan,
    this.donGiaMua,
    this.muaBan,
    this.donGiaVon,
    this.donGiaCam,
    this.suDung,
    this.ghiChu,
  });

  get loaiTen => null;

  LoaiVang copyWith({
    String? nhomHangId,
    String? nhomHangMa,
    int? nhomChaId,
    String? nhomTen,
    double? donGiaBan,
    double? donGiaMua,
    int? muaBan,
    double? donGiaVon,
    double? donGiaCam,
    int? suDung,
    String? ghiChu,
  }) {
    return LoaiVang(
      nhomHangId: nhomHangId ?? this.nhomHangId,
      nhomHangMa: nhomHangMa ?? this.nhomHangMa,
      nhomChaId: nhomChaId ?? this.nhomChaId,
      nhomTen: nhomTen ?? this.nhomTen,
      donGiaBan: donGiaBan ?? this.donGiaBan,
      donGiaMua: donGiaMua ?? this.donGiaMua,
      muaBan: muaBan ?? this.muaBan,
      donGiaVon: donGiaVon ?? this.donGiaVon,
      donGiaCam: donGiaCam ?? this.donGiaCam,
      suDung: suDung ?? this.suDung,
      ghiChu: ghiChu ?? this.ghiChu,
    );
  }

  // Phương thức để chuyển đổi từ Map sang đối tượng LoaiVang
  factory LoaiVang.fromMap(Map<String, dynamic> map) {
    return LoaiVang(
      nhomHangId: map['NHOMHANGID'] ?? '',
      nhomHangMa: map['NHOMHANGMA'] ?? '',
      nhomChaId: map['NHOMCHAID'] ?? -1,
      nhomTen: map['NHOM_TEN'] ?? '',
      donGiaBan: (map['DON_GIA_BAN'] as num).toDouble() ?? 0.0,
      donGiaMua: (map['DON_GIA_MUA'] as num).toDouble() ?? 0.0,
      muaBan: map['MUA_BAN'] ?? 0, 
      donGiaVon: (map['DON_GIA_VON'] as num).toDouble() ?? 0.0,
      donGiaCam: (map['DON_GIA_CAM'] as num).toDouble() ?? 0.0,
      suDung: map['SU_DUNG'] ?? 1,
      ghiChu: map['GHI_CHU'] ?? '',
    );
  }

  // Phương thức để chuyển đổi đối tượng LoaiVang sang Map
  Map<String, dynamic> toMap() {
    return {
      'NHOMHANGID': nhomHangId,
      'NHOMHANGMA': nhomHangMa,
      'NHOMCHAID': nhomChaId,
      'NHOM_TEN': nhomTen,
      'DON_GIA_BAN': donGiaBan,
      'DON_GIA_MUA': donGiaMua,
      'MUA_BAN': muaBan,
      'DON_GIA_VON': donGiaVon,
      'DON_GIA_CAM': donGiaCam,
      'SU_DUNG': suDung,
      'GHI_CHU': ghiChu,
    };
  }
}
