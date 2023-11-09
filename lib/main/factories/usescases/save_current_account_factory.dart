import 'package:firstapp/data/usescases/save_current_account/local_save_current_account.dart';
import 'package:firstapp/domain/usecases/save_current_account.dart';
import 'package:firstapp/main/factories/cache/local_storage_adapter_factory.dart';

SaveCurrentAccount makeLocalSaveCurrentAccount() {
  return LocalSaveCurrentAccount(
      saveSecureCacheStorage: makeLocalStorageAdapter());
}
