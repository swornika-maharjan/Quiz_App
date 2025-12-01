import 'package:get/get.dart';
import 'package:quizzie/api-service/api_service.dart';

class ProfileController extends GetxController {
  final RxMap _userInfo = {}.obs;
  final RxBool _isLoading = false.obs;

//getter
  Map get userInfo => _userInfo;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    _isLoading(true);
    RESTExecutor(
      domain: 'users',
      label: 'profile',
      method: 'GET',
      successCallback: (res) {
        print('SUCCESS: ${res['message']}');
        final result = res ?? {};
        _userInfo.assignAll(result);

        _isLoading(false);
      },
      errorCallback: (err) {
        _isLoading(false);
        print('ERROR: ${err['message']}');
      },
    ).execute();
  }
}
