class UserPhone {
  final String phone;
  final String cell;

  UserPhone({
    required this.phone,
    required this.cell,
  });

  factory UserPhone.fromMap(Map<String, dynamic> json) {
    return UserPhone(
      phone: json['phone'] ?? '', // Default to empty string if null
      cell: json['cell'] ?? '',  // Default to empty string if null
    );
  }
}
