abstract class SignuUpEvents {}

class SignuUpEventsNameChange extends SignuUpEvents {
  String username;

  SignuUpEventsNameChange(this.username);
}

class SignuUpEventsSurnameChange extends SignuUpEvents {
  String suername;
  SignuUpEventsSurnameChange(this.suername);
}

class SignuUpEventsSecondNameChange extends SignuUpEvents {
  String secondname;
  SignuUpEventsSecondNameChange(this.secondname);
}

class SignuUpEventsPhoneNumberChange extends SignuUpEvents {
  String Phonenumber;
  SignuUpEventsPhoneNumberChange(this.Phonenumber);
}

class SignuUpEventsEmailChange extends SignuUpEvents {
  final String email;

  SignuUpEventsEmailChange(this.email);
}

class SignuUpEventsLocationChange extends SignuUpEvents {
  final String PhonenumberChange;

  SignuUpEventsLocationChange(this.PhonenumberChange);
}

class SignuUpEventsSignupSubmitted extends SignuUpEvents {}
