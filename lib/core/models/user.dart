// class User {
//   final int id;
//   final String name;
//   final String email;
//   final String? phone;
//   final String? role;
//   final bool? isActive;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.phone,
//     this.role,
//     this.isActive,
//   });

//   /* ===================== FROM JSON ===================== */

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       phone: json['phone'],
//       role: json['role'],
//       isActive: json['is_active'],
//     );
//   }

//   /* ===================== TO JSON ===================== */

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'role': role,
//       'is_active': isActive,
//     };
//   }

//   /* ===================== COPY WITH ===================== */

//   User copyWith({
//     int? id,
//     String? name,
//     String? email,
//     String? phone,
//     String? role,
//     bool? isActive,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       phone: phone ?? this.phone,
//       role: role ?? this.role,
//       isActive: isActive ?? this.isActive,
//     );
//   }

//   @override
//   String toString() {
//     return 'User(id: $id, name: $name, email: $email)';
//   }
// }
