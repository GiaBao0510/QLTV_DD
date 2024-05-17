// database : nhom_hang

class LoaiVang {
  final int? nhomHangId;
  final String? nhomHangMa;
  final int? nhomChaId;
  final String? nhomTen;
  final double? donGiaBan;
  final double? donGiaMua;
  final bool? muaBan;
  final double? donGiaVon;
  final double? donGiaCam;
  final bool? suDung;
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

  LoaiVang copyWith({
    int? nhomHangId,
    String? nhomHangMa,
    int? nhomChaId,
    String? nhomTen,
    double? donGiaBan,
    double? donGiaMua,
    bool? muaBan,
    double? donGiaVon,
    double? donGiaCam,
    bool? suDung,
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
      nhomHangId: map['NHOMHANGID'],
      nhomHangMa: map['NHOMHANGMA'],
      nhomChaId: map['NHOMCHAID'],
      nhomTen: map['NHOM_TEN'],
      donGiaBan: map['DON_GIA_BAN'],
      donGiaMua: map['DON_GIA_MUA'],
      muaBan: map['MUA_BAN'] == 1,
      donGiaVon: map['DON_GIA_VON'],
      donGiaCam: map['DON_GIA_CAM'],
      suDung: map['SU_DUNG'] == 1,
      ghiChu: map['GHI_CHU'],
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
      'MUA_BAN': muaBan == true ? 1 : 0,
      'DON_GIA_VON': donGiaVon,
      'DON_GIA_CAM': donGiaCam,
      'SU_DUNG': suDung == true ? 1 : 0,
      'GHI_CHU': ghiChu,
    };
  }
}
