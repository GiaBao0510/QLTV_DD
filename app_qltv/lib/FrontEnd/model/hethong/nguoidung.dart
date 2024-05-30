class NguoiDung {
  int? userId;
  int? groupId;
  String? userMa;
  String? userTen;
  String? matKhau;
  bool? biKhoa;
  String? lyDoKhoa;
  DateTime? ngayTao;
  bool? suDung;
  String? realm;
  String? email;
  String? emailVerified;
  String? verificationToken;
  String? mac;

  NguoiDung({
    this.userId,
    this.groupId,
    this.userMa,
    this.userTen,
    this.matKhau,
    this.biKhoa,
    this.lyDoKhoa,
    this.ngayTao,
    this.suDung,
    this.realm,
    this.email,
    this.emailVerified,
    this.verificationToken,
    this.mac,
  });

  NguoiDung copyWith({
    int? userId,
    int? groupId,
    String? userMa,
    String? userTen,
    String? matKhau,
    bool? biKhoa,
    String? lyDoKhoa,
    DateTime? ngayTao,
    bool? suDung,
    String? realm,
    String? email,
    String? emailVerified,
    String? verificationToken,
    String? mac,
  }) {
    return NguoiDung(
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      userMa: userMa ?? this.userMa,
      userTen: userTen ?? this.userTen,
      matKhau: matKhau ?? this.matKhau,
      biKhoa: biKhoa ?? this.biKhoa,
      lyDoKhoa: lyDoKhoa ?? this.lyDoKhoa,
      ngayTao: ngayTao ?? this.ngayTao,
      suDung: suDung ?? this.suDung,
      realm: realm ?? this.realm,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      verificationToken: verificationToken ?? this.verificationToken,
      mac: mac ?? this.mac,
    );
  }

  factory NguoiDung.fromJson(Map<String, dynamic> json) {
    return NguoiDung(
      userId: json['USER_ID'],
      groupId: json['GROUP_ID'],
      userMa: json['USER_MA'],
      userTen: json['USER_TEN'],
      matKhau: json['MAT_KHAU'],
      biKhoa: json['BIKHOA'] == 1,
      lyDoKhoa: json['LY_DO_KHOA'],
      ngayTao: json['NGAY_TAO'] != null ? DateTime.parse(json['NGAY_TAO']) : null,
      suDung: json['SU_DUNG'] == 1,
      realm: json['REALM'],
      email: json['EMAIL'],
      emailVerified: json['EMAILVERIFIED'],
      verificationToken: json['VERIFICATIONTOKEN'],
      mac: json['MAC'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'USER_ID': userId,
      'GROUP_ID': groupId,
      'USER_MA': userMa,
      'USER_TEN': userTen,
      'MAT_KHAU': matKhau,
      'BIKHOA': biKhoa == true ? 1 : 0,
      'LY_DO_KHOA': lyDoKhoa,
      'NGAY_TAO': ngayTao?.toIso8601String(),
      'SU_DUNG': suDung == true ? 1 : 0,
      'REALM': realm,
      'EMAIL': email,
      'EMAILVERIFIED': emailVerified,
      'VERIFICATIONTOKEN': verificationToken,
      'MAC': mac,
    };
  }

  
}
