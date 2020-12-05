import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_store/models/credit_card.dart';
import 'package:firebase_store/models/user.dart';

class CieloPayment {
  final functions = CloudFunctions.instance;
  Future<void> authrorize(
      {CreditCard creditCard, num price, String orderId, User user}) async {
    final Map<String, dynamic> dataSale = {
      'merchantOrderId': orderId,
      'amount': (price * 100).toInt(),
      'softDescriptor': 'TG Store',
      'installments': 1,
      'creditCard': creditCard.toJason(),
      'cpf': user.cpf,
      'paymentType': 'CreditCard',
    };
    final HttpsCallable callable =
        functions.getHttpsCallable(functionName: 'authorizeCreditCard');
    final response = await callable.call(dataSale);
    print(response.data);
  }
}
