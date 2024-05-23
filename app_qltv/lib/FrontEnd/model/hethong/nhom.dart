class Nhom {
  final String? groupId;
  final String? groupMa;
  final String? groupTen;
  final bool? biKhoa;
  final String? lyDoKhoa;
  final bool? suDung;
  final DateTime? ngayTao;

  Nhom({
    this.groupId,
    this.groupMa,
    this.groupTen,
    this.biKhoa,
    this.lyDoKhoa,
    this.suDung,
    this.ngayTao,
  });

  Nhom copyWith({
    String? groupId,
    String? groupMa,
    String? groupTen,
    bool? biKhoa,
    String? lyDoKhoa,
    bool? suDung,
    DateTime? ngayTao,
  }) {
    return Nhom(
      groupId: groupId ?? this.groupId,
      groupMa: groupMa ?? this.groupMa,
      groupTen: groupTen ?? this.groupTen,
      biKhoa: biKhoa ?? this.biKhoa,
      lyDoKhoa: lyDoKhoa ?? this.lyDoKhoa,
      suDung: suDung ?? this.suDung,
      ngayTao: ngayTao ?? this.ngayTao,
    );
  }

  // Phương thức để chuyển đổi từ Map sang đối tượng Nhom
  // factory Nhom.fromMap(Map<String, dynamic> map) {
  //   return Nhom(
  //     groupId: map['GROUP_ID'],
  //     groupMa: map['GROUP_MA'],
  //     groupTen: map['GROUP_TEN'],
  //     biKhoa: map['BIKHOA'] == 1,
  //     lyDoKhoa: map['LY_DO_KHOA'],
  //     suDung: map['SU_DUNG'] == 1,
  //     ngayTao: DateTime.tryParse(map['NGAY_TAO']),
  //   );
  // }

  factory Nhom.fromMap(Map<String, dynamic> map) {
    return Nhom(
      groupId: map['GROUP_ID'] ?? '',
      groupMa: map['GROUP_MA'] ?? '',
      groupTen: map['GROUP_TEN'] ?? '',
      biKhoa: map['BIKHOA'] == 1,
      lyDoKhoa: map['LY_DO_KHOA'] ?? '',
      suDung: map['SU_DUNG'] == 1,
      ngayTao: DateTime.tryParse(map['NGAY_TAO'] ?? '') ?? DateTime.now(),
    );
  }

  // Phương thức để chuyển đổi đối tượng Nhom sang Map
  Map<String, dynamic> toMap() {
    return {
      'GROUP_ID': groupId,
      'GROUP_MA': groupMa,
      'GROUP_TEN': groupTen,
      'BIKHOA': biKhoa == true ? 1 : 0,
      'LY_DO_KHOA': lyDoKhoa,
      'SU_DUNG': suDung == true ? 1 : 0,
      'NGAY_TAO': ngayTao?.toIso8601String(),
    };
  }
}
