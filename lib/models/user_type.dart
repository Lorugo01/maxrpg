enum UserType {
  simple('simple', 'Usuário Simples'),
  admin('admin', 'Administrador');

  const UserType(this.value, this.displayName);

  final String value;
  final String displayName;

  static UserType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'admin':
        return UserType.admin;
      case 'simple':
      default:
        return UserType.simple;
    }
  }

  bool get isAdmin => this == UserType.admin;
  bool get isSimple => this == UserType.simple;
}
