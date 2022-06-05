import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:javizen/Helpers/PrefHelpers.dart';

enum WebControllers {
  markets,
  register,
  auth,
  wallets,
}

enum WebMethods {
  ticker,
  token,
  getAddress,
  withdraw,
}

class RequestHelper {
  static const String BaseUrl = 'https://javizen.com/api/v1';
  static const String ImageUrl = 'https://javizen.com/api/v1';

  static Future<ApiResult> _makeRequestGet({
    WebControllers? webController,
    WebMethods? webMethod,
    Map<String, String> header = const {},
    Map body = const {},
    Map<String, dynamic> queryParameters = const {},
  }) async {
    String url = RequestHelper._makePath(webController, webMethod);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response = await http.get(
        Uri.parse(url).replace(queryParameters: queryParameters),
        headers: header);
    ApiResult apiResult = ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        Map? data2 = jsonDecode(response.body);
        apiResult.data2 = data2;
        apiResult.success = data['success'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.success = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.success = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "success: ${apiResult.success}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> _makeRequestPost({
    WebControllers? webController,
    WebMethods? webMethod,
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(webController, webMethod);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response =
        await http.post(Uri.parse(url), headers: header, body: body);
    ApiResult apiResult = ApiResult();
    apiResult.statusCode = response.statusCode;
    print(response.body);
    apiResult.data2 = jsonDecode(response.body);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 201) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.success = data['success'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
        apiResult.data2 = data;
      } catch (e) {
        apiResult.success = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.success = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "success: ${apiResult.success}\n"
        "data: ${apiResult.data2}"
        "}");
    print(await PrefHelpers.getToken());
    return apiResult;
  }

  static Future<ApiResult> _makeRequestPost2({
    WebControllers? webController,
    WebMethods? webMethod,
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath2(webController);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response =
        await http.post(Uri.parse(url), headers: header, body: body);
    ApiResult apiResult = ApiResult();
    apiResult.statusCode = response.statusCode;
    print(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 201) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.success = data['success'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.success = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.success = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "success: ${apiResult.success}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> _makeRequestGet2({
    WebControllers? webController,
    WebMethods? webMethod,
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath2(webController);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response = await http.get(Uri.parse(url), headers: header);
    ApiResult apiResult = ApiResult();
    apiResult.statusCode = response.statusCode;
    print(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 201) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.success = data['success'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.success = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.success = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "success: ${apiResult.success}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> _makeRequestPatch({
    WebControllers? webController,
    WebMethods? webMethod,
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(webController, webMethod);
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response =
        await http.patch(Uri.parse(url), headers: header, body: body);
    ApiResult apiResult = ApiResult();
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.success = data['success'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.success = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.success = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "success: ${apiResult.success}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static String _makePath(
      WebControllers? webController, WebMethods? webMethod) {
    return "${RequestHelper.BaseUrl}/${webController.toString().split('.').last}/${webMethod.toString().split('.').last}";
  }

  static String _makePath2(WebControllers? webController) {
    return "${RequestHelper.BaseUrl}/${webController.toString().split('.').last}";
  }

  // static Future<ApiResult> LoginOtp({String? mobile, String? code}) async {
  //   return await RequestHelper._makeRequestPost(
  //     webController: WebControllers.auth,
  //     webMethod: WebMethods.verify_code,
  //     body: {'phone_number': mobile, 'code': code},
  //   ).timeout(
  //     Duration(seconds: 50),
  //   );
  // }
  //
  static Future<ApiResult> getCoinList() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.markets,
      webMethod: WebMethods.ticker,
    ).timeout(
      const Duration(seconds: 50),
    );
  }

  static Future<ApiResult> register(
      {String? email,
      String? password,
      String? password_confirmation,
      String? terms}) async {
    return await RequestHelper._makeRequestPost2(
      webController: WebControllers.register,
      body: {
        "email": email,
        "password": password,
        "device_name": "android",
        "password_confirmation": password_confirmation,
        "terms": terms,
      },
    ).timeout(
      const Duration(seconds: 180),
    );
  }

  static Future<ApiResult> getWallet() async {
    return await RequestHelper._makeRequestGet2(
        webController: WebControllers.wallets,
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader:
              "Bearer ${await PrefHelpers.getToken()}"
        }).timeout(
      const Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getAddress(String symbol, {int network = 8}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.wallets,
        webMethod: WebMethods.getAddress,
        queryParameters: {
          'symbol': symbol,
          'network': network.toString()
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader:
              "Bearer ${await PrefHelpers.getToken()}"
        }).timeout(
      const Duration(seconds: 50),
    );
  }

  static Future<ApiResult> withdraw(
      {String network = '8',
      String address = '',
      String amount = '',
      String paymentId = '',
      String symbol = ''}) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.wallets,
        webMethod: WebMethods.withdraw,
        body: {
          'network': network,
          'address': address,
          'amount': amount,
          'payment_id': paymentId,
          'symbol': symbol
        },
        header: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader:
              "Bearer ${await PrefHelpers.getToken()}"
        }).timeout(
      const Duration(seconds: 50),
    );
  }

  static Future<ApiResult> getTokenAndLogin({
    String? email,
    String? password,
  }) async {
    return await RequestHelper._makeRequestPost(
        webController: WebControllers.auth,
        webMethod: WebMethods.token,
        body: {
          "email": email,
          "password": password,
          "device_name": "android",
        }).timeout(
      const Duration(seconds: 50),
    );
  }

//  **************************************************************************
//  **************************************************************************
//  **************************************************************************

  static Future<ApiResult> getDeposits() async {
    String url = "https://javizen.com/api/v1/wallets/deposits/coin";
    print(url);
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${await PrefHelpers.getToken()}"
    });
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.success = data['success'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.success = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = 'fcm';
        apiResult.data = response.body;
      }
    } else {
      apiResult.success = true;
    }
    print("\nRequest url: $url\nResponse: {"
        "status: ${response.statusCode}\n"
        "success: ${apiResult.success}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> getWithdraws() async {
    String url = "https://javizen.com/api/v1/wallets/withdrawals/coin";
    print(url);
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${await PrefHelpers.getToken()}"
    });
    ApiResult apiResult = new ApiResult();
    apiResult.statusCode = response.statusCode;
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.success = data['success'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.success = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        apiResult.requestedMethod = 'fcm';
        apiResult.data = response.body;
      }
    } else {
      apiResult.success = true;
    }
    print("\nRequest url: $url\nResponse: {"
        "status: ${response.statusCode}\n"
        "success: ${apiResult.success}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }
}

class ApiResult {
  bool? success;
  String? requestedMethod;
  dynamic data;
  dynamic data2;
  var statusCode;

  ApiResult({
    this.success,
    this.requestedMethod,
    this.data,
    this.data2,
    this.statusCode,
  });
}
