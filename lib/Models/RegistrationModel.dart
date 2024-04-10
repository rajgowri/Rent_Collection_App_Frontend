class RegistrationData {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String mobileNumber;
  final String password;

  RegistrationData({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.mobileNumber,
    required this.password,
  });

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
      'password': password,
    };
  }

  // Method to create an object from JSON
  factory RegistrationData.fromJson(Map<String, dynamic> json) {
    return RegistrationData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      emailAddress: json['emailAddress'],
      mobileNumber: json['mobileNumber'],
      password: json['password'],
    );
  }
}
