//database Loai_Hang


class NhomVang {
  //int(10) for loaiId
  final int? loaiId;
  final String? loaiMa;
  final String? loaiTen;
  final String? ghiChu;
  final int? suDung;

  NhomVang({
    this.loaiId,
    this.loaiMa,
    this.loaiTen,
    this.ghiChu,
    this.suDung,
  });

  NhomVang copyWith({
    //int(10) for loaiId
    int? loaiId,
    String? loaiMa,
    String? loaiTen,
    String? ghiChu,
    int? suDung,
  }) {
    return NhomVang(
      loaiId: loaiId ?? this.loaiId,
      loaiMa: loaiMa ?? this.loaiMa,
      loaiTen: loaiTen ?? this.loaiTen,
      ghiChu: ghiChu ?? this.ghiChu,
      suDung: suDung ?? this.suDung,
    );
  }

  // Phương thức để chuyển đổi từ Map sang đối tượng NhomVang
  factory NhomVang.fromMap(Map<String, dynamic> map) {
    return NhomVang(
      loaiId: map['LOAIID'],
      loaiMa: map['LOAIMA'],
      loaiTen: map['LOAI_TEN'],
      ghiChu: map['GHI_CHU'],
      suDung: map['SU_DUNG'],
    );
  }
  

  // Phương thức để chuyển đổi đối tượng NhomVang sang Map
  Map<String, dynamic> toMap() {
    return {
      'LOAIID': loaiId,
      'LOAIMA': loaiMa,
      'LOAI_TEN': loaiTen,
      'GHI_CHU': ghiChu,
      'SU_DUNG': suDung,
    };
  }
}
