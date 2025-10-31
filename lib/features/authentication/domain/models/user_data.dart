// import 'package:idocit/common/utils/date_time.dart';
// import 'package:idocit/features/profile/domain/models/home_info_model.dart';

class UserData {
  static const idKey = "id";
  static const emailKey = "email";
  static const usernameKey = "name";
  static const addressKey = "address";
  static const firstNameKey = "firstname";
  static const lastNameKey = "lastname";
  static const phoneNumberKey = "phone_number";
  static const creationDateKey = "creation_date";
  static const isEmailVerifiedKey = "email_verified";
  static const isPhoneNumberVerifiedKey = "phone_number_verified";

  final String id;
  final String email;
  final String? username;
  final String? address;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final DateTime? creationDate;
  final bool isEmailVerified;
  final bool isPhoneNumberVerified;

  const UserData({
    required this.id,
    required this.email,
    required this.username,
    required this.address,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.creationDate,
    required this.isEmailVerified,
    required this.isPhoneNumberVerified,
  });

  bool get isConfirmed =>
      firstName != null &&
      firstName!.isNotEmpty &&
      lastName != null &&
      lastName!.isNotEmpty &&
      phoneNumber != null &&
      phoneNumber!.isNotEmpty;

  UserData copyWith({String? zipcode, String? firstName, String? lastName, String? phoneNumber}) {
    return UserData(
      id: id,
      email: email,
      username: username,
      address: address,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      creationDate: creationDate,
      isEmailVerified: isEmailVerified,
      isPhoneNumberVerified: isPhoneNumberVerified,
    );
  }

  static UserData fromJson(Map<String, dynamic> json) {
    final parsedDate =
        DateTime.tryParse(json[creationDateKey]) ??
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour);

    return UserData(
      id: json[idKey],
      email: json[emailKey],
      username: json[usernameKey],
      address: json[addressKey],
      firstName: json[firstNameKey],
      lastName: json[lastNameKey],
      phoneNumber: json[phoneNumberKey],
      creationDate: parsedDate,
      isEmailVerified: json[isEmailVerifiedKey] == true,
      isPhoneNumberVerified: json[isPhoneNumberVerifiedKey] == true,
    );
  }

  Map<String, dynamic> toJson() {
    //final homesJson = homes.map((home) => home.toJson()).toList();
    return {
      "id": id,
      "email": email,
      "username": username,
      "address": address,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "creationDate": creationDate,
      "isEmailVerified": isEmailVerified,
      "isPhoneNumberVerified": isPhoneNumberVerified,
    };
  }

  String getFullName() {
    if (firstName == null || firstName == '') {
      return lastName ?? '';
    }

    if (lastName == null || lastName == '') {
      return firstName ?? '';
    }

    return '$firstName $lastName';
  }
}
