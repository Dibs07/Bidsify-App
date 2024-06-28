import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";
  final String _privateKey =
      "0x643c5f2782ee4835532c544f30dcbfee4b004ebd0f2cc1f1f44564ff1d4469cd";

  late Web3Client _client;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _createAccount;
  late ContractFunction _loginAccount;

  bool isLoading = false;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = await Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  getAbi() async {
    String artifactString =
        await rootBundle.loadString("src/artifacts/Auth.json");
    var jsonFile = jsonDecode(artifactString);
    _abiCode = jsonEncode(jsonFile["abi"]);
    //print(_abiCode);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    // ignore: deprecated_member_use
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Auth"), _contractAddress);

    _createAccount = _contract.function("createAccount");
    _loginAccount = _contract.function("loginAccount");
  }

  createAccount(String name, String pass, String mail) async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _createAccount,
            parameters: [name, pass, mail],
            maxGas: 1000000));
    print("Account Created Bro");

    isLoading = false;
    notifyListeners();
  }

  loginAccount(String mail, String pass) async {
    var msg = await _client.call(
        contract: _contract, function: _loginAccount, params: [mail, pass]);
    print(msg[0]);
    isLoading = false;
    notifyListeners();
  }
}