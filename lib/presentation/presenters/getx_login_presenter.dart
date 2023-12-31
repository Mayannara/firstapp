import 'package:firstapp/domain/usecases/save_current_account.dart';
import 'package:get/get.dart';

import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import './protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;

  // Observers
  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _navigateTo = RxString();
  var _isLoading = false.obs;
  var _isFormValid = false.obs;

  Stream<String> get emailErrorStream => _emailError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;
  Stream<String> get mainErrorStream => _mainError.stream;
  Stream<String> get navigateToStream => _navigateTo.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  GetxLoginPresenter(
      {required this.validation,
      required this.authentication,
      required this.saveCurrentAccount});

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null;
  }

  // Emite para a tela um novo evento
  Future<void> auth() async {
    try {
      _isLoading.value = true;
      final account = await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      _mainError.value = error.description;
      _isLoading.value = false;
    }
  }

  void dispose() {}
}
