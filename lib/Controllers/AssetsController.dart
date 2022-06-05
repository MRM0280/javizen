import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javizen/Helpers/RequestHelper.dart';
import 'package:javizen/Models/DepositModel.dart';
import 'package:javizen/Models/WithdrawModel.dart';

import '../Models/WalletModel.dart';

class AssetsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxList<WalletModel> walletList = <WalletModel>[].obs;
  RxList<DepositModel> depositList = <DepositModel>[].obs;
  RxList<WithdrawModel> withdrawList = <WithdrawModel>[].obs;
  TextEditingController amountController = TextEditingController();
  RxString address = ''.obs;
  RxBool loading = false.obs;
  RxBool depositLoading = false.obs;
  RxBool withdrawLoading = false.obs;
  RxBool withdrawPostLoading = false.obs;
  RxBool withdrawResult = false.obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    getWallet();
    getDeposits();
    getWithdraws();
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  getWallet() {
    RequestHelper.getWallet().then((value) {
      walletList.clear();
      if (value.success!) {
        walletList.addAll(WalletModel.listFromJson(value.data));
        loading.value = true;
      } else {
        loading.value = false;
      }
    });
  }

  getAddress(selectedSymbol) {
    RequestHelper.getAddress(selectedSymbol).then((value) {
      address = ''.obs;
      if (value.statusCode == 200) {
        address.value = value.data2['address'];
        print(address.value);
        loading.value = true;
      } else {
        loading.value = false;
      }
    });
  }

  getDeposits() {
    RequestHelper.getDeposits().then((value) {
      depositList.clear();
      if (value.statusCode == 200) {
        depositList.addAll(DepositModel.listFromJson(value.data));
        depositLoading.value = true;
      } else {
        depositLoading.value = false;
      }
    });
  }

  getWithdraws() {
    RequestHelper.getWithdraws().then((value) {
      withdrawList.clear();
      if (value.statusCode == 200) {
        withdrawList.addAll(WithdrawModel.listFromJson(value.data));
        withdrawLoading.value = true;
      } else {
        withdrawLoading.value = false;
      }
    });
  }

  withdraw(String address, String symbol) {
    RequestHelper.withdraw(
            amount: amountController.text, address: address, symbol: symbol)
        .then((value) {
      withdrawResult.value = false;
      if (value.statusCode == 200) {
        withdrawResult.value = value.data2['result'];
        withdrawPostLoading.value = true;
      } else {
        withdrawPostLoading.value = false;
      }
    });
  }
}
