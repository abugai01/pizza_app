class Profile {
  static const NAME = 'name';
  static const SURNAME = 'surname';
  static const AVATAR = 'avatar';
  static const PHONE = 'phone';
  static const EMAIL = 'email';
  static const BIRTHDAY = 'birthday';

  String? name;
  String? surname;
  String? avatar;
  String? phone;
  String? email;
  DateTime? birthday;

  Profile(
      {this.name,
        this.surname,
        this.birthday,
        this.phone,
        this.email,
        this.avatar});

  //TODO: safe date extraction
  static fromMap(Map<String, dynamic>? data) {
    DateTime? birthday = (data?[BIRTHDAY] == null)
        ? null
        : data![BIRTHDAY].toDate();

    return Profile(
        birthday: birthday,
        name: data?[NAME],
        surname: data?[SURNAME],
        phone: data?[PHONE],
        email: data?[EMAIL],
        avatar: data?[AVATAR]);
  }

  Map<String, dynamic> toMap() {
    return {
      NAME: this.name,
      SURNAME: this.surname,
      PHONE: this.phone,
      EMAIL: this.email,
      BIRTHDAY: this.birthday
    };
  }
}