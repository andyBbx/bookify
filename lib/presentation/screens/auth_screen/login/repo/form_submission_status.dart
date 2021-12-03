abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  final bool isManager;
  const SubmissionSuccess({required this.isManager});
  @override
  List<Object> get props => [isManager];
}

class SubmissionFailed extends FormSubmissionStatus {
  final dynamic exception;
  final String errorMessage;

  SubmissionFailed(this.exception, this.errorMessage);
}
