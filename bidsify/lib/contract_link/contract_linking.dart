import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ContractLinking {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";
  final String _privateKey = "0x643c5f2782ee4835532c544f30dcbfee4b004ebd0f2cc1f1f44564ff1d4469cd";

  Web3Client? _client;
  bool isLoading = true;

  String? _abiCode;
  EthereumAddress? _contractAddress;
  Credentials? _credentials;

  DeployedContract? _contract;
  ContractFunction? _placeBid;
  ContractFunction? _finalizeAuction;
  ContractFunction? _highestBid;
  ContractFunction? _highestBidder;

  ContractLinking() {
    initialSetup();
  }

  Future<void> initialSetup() async {
    _client = Web3Client(_rpcUrl, Client());
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString('assets/YourContract.json');
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress = EthereumAddress.fromHex(jsonAbi['networks']['NETWORK_ID']['address']);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
      ContractAbi.fromJson(_abiCode!, 'Auction'),
      _contractAddress!,
    );

    _placeBid = _contract!.function('placeBid');
    _finalizeAuction = _contract!.function('finalizeAuction');
    _highestBid = _contract!.function('highestBindingBid');
    _highestBidder = _contract!.function('highestBidder');

    isLoading = false;
  }

  Future<void> placeBid() async {
    isLoading = true;
    await _client!.sendTransaction(
      _credentials!,
      Transaction.callContract(
        contract: _contract!,
        function: _placeBid!,
        parameters: [],
        // ignore: deprecated_member_use
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
      ),
    );
    isLoading = false;
  }

  Future<void> finalizeAuction() async {
    isLoading = true;
    await _client!.sendTransaction(
      _credentials!,
      Transaction.callContract(
        contract: _contract!,
        function: _finalizeAuction!,
        parameters: [],
      ),
    );
    isLoading = false;
  }

  Future<EtherAmount> getHighestBid() async {
    final result = await _client!.call(
      contract: _contract!,
      function: _highestBid!,
      params: [],
    );
    return result.first as EtherAmount;
  }

  Future<EthereumAddress> getHighestBidder() async {
    final result = await _client!.call(
      contract: _contract!,
      function: _highestBidder!,
      params: [],
    );
    return result.first as EthereumAddress;
  }
}
