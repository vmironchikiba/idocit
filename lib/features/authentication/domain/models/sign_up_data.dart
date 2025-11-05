class SignUpData {
  final String? id;
  final String? username;
  final String? email;
  final String? role;
  final String? tenant;
  final bool? isOnedriveAuthorized;

  const SignUpData({this.id, this.username, this.email, this.role, this.tenant, this.isOnedriveAuthorized});

  SignUpData copyWith({
    SignUpData? signUpData,
    String? id,
    String? username,
    String? email,
    String? role,
    String? tenant,
    bool? isOnedriveAuthorized,
  }) {
    return SignUpData(
      id: signUpData?.id ?? id ?? this.id,
      username: signUpData?.username ?? username ?? this.username,
      email: signUpData?.email ?? email ?? this.email,
      role: signUpData?.role ?? role ?? this.role,
      tenant: signUpData?.tenant ?? tenant ?? this.tenant,
      isOnedriveAuthorized: signUpData?.isOnedriveAuthorized ?? isOnedriveAuthorized ?? this.isOnedriveAuthorized,
    );
  }
}
