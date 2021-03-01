import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:get/get.dart';

import 'package:tcb_demo/config.dart';
import 'package:tcb_demo/utils/cloudbase/cloudbase.dart';

class HomeController extends GetxController {
  CloudBaseUtil _cloudBaseUtil = CloudBaseUtil();
  //TODO: Implement HomeController

  final loading = false.obs;
  final authState = CloudBaseAuthState().obs;
  final userInfo = CloudBaseUserInfo({}).obs;

  Future<void> login() async {
    print('login');
    loading.value = true;
    _cloudBaseUtil.auth
        .signInAnonymously()
        .then((success) async {
          CloudBaseResponse res = await _cloudBaseUtil.callFunction("auth", {
            "username": CloudConfig.tmpUsername,
            "password": CloudConfig.tmpPassword,
          });
          var ticket = res.data['ticket'];
          await _cloudBaseUtil.auth.signInWithTicket(ticket).then((success) {
            updateAuth();
          }).catchError((err) {
            // 登录失败
          }).whenComplete(() {
            loading.value = false;
          });
        })
        .catchError((err) {})
        .whenComplete(() {
          loading.value = false;
        });
  }

  logout() async {
    print('logout');
    if (authState.value.authType != CloudBaseAuthType.ANONYMOUS) {
      await _cloudBaseUtil.auth.signOut();
      authState.value = null;
      userInfo.value = null;
    } else {
      authState.value = null;
      userInfo.value = null;
    }
  }

  updateAuth() {
    _cloudBaseUtil.auth.getAuthState().then((state) async {
      print('updateAuth');
      print(state);
      if (state != null) {
        print(state.authType);
        authState.value = state;
        await _cloudBaseUtil.auth.getUserInfo().then((info) {
          userInfo.value = info;
        }).catchError((err) {});
      } else {
        authState.value = null;
        userInfo.value = null;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    updateAuth();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
