//database phn_nha_cung_cap


class NhaCungCap {
  final int? ncc_id;
  final String? ncc_ma;
  final String? ncc_ten;
  final String? ngay_bd;
  final String? ghi_chu;
  final int? su_dung;

  NhaCungCap({
    this.ncc_id,
    this.ncc_ma,
    this.ncc_ten,
    this.ngay_bd,
    this.ghi_chu,
    this.su_dung,
  });

  NhaCungCap copyWith({
    //int(10) for ncc_id
    int? ncc_id,
    String? ncc_ma,
    String? ncc_ten,
    String? ngay_bd,
    String? ghi_chu,
    int? su_dung,
  }) {
    return NhaCungCap(
      ncc_id: ncc_id ?? this.ncc_id,
      ncc_ma: ncc_ma ?? this.ncc_ma,
      ncc_ten: ncc_ten ?? this.ncc_ten,
      ngay_bd: ngay_bd ?? this.ngay_bd,
      ghi_chu: ghi_chu ?? this.ghi_chu,
      su_dung: su_dung ?? this.su_dung,
    );
  }

  // Phương thức để chuyển đổi từ Map sang đối tượng NhaCungCap
  factory NhaCungCap.fromMap(Map<String, dynamic> map) {
    return NhaCungCap(
      ncc_id: map['NCCID'],
      ncc_ma: map['NCCMA'],
      ncc_ten: map['NCC_TEN'],
      ngay_bd: map['NGAYBD'],
      ghi_chu: map['GHI_CHU'],
      su_dung: map['SU_DUNG'],
    );
  }
  

  // Phương thức để chuyển đổi đối tượng NhaCungCap sang Map
  Map<String, dynamic> toMap() {
    return {
      'NCCID': ncc_id,
      'NCCMA': ncc_ma,
      'NCC_TEN': ncc_ten,
      'NGAYBD': ngay_bd,
      'GHI_CHU': ghi_chu,
      'SU_DUNG': su_dung,
    };
  }
}
