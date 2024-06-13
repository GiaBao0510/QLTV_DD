class KetNoi {
  final String host;
  final String database;
  final String user;
  final String password;
  final String port;

  KetNoi({
    required this.host,
    required this.database,
    required this.user,
    required this.password,
    required this.port,
  });

  factory KetNoi.fromMap(Map<String, dynamic> map) {
    return KetNoi(
      host: map['host'] ?? '',
      database: map['database'] ?? '',
      user: map['user'] ?? '',
      password: map['password'] ?? '',
      port: map['port'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'host': host,
      'database': database,
      'user': user,
      'password': password,
      'port': port,
    };
  }

  KetNoi copyWith({
    String? host,
    String? database,
    String? user,
    String? password,
    String? port,
  }) {
    return KetNoi(
      host: host ?? this.host,
      database: database ?? this.database,
      user: user ?? this.user,
      password: password ?? this.password,
      port: port ?? this.port,
    );
  }

  // @override
  // String toString() {
  //   return 'KetNoi(host: $host, database: $database, user: $user, password: $password, port: $port)';
  // }
}
