import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/model/user_model.dart';

class BidCard extends StatelessWidget {
  final String title;
  final String bidder;
  late double? latestBid;
  final String buttonText;
  final bool isHistory;
  final VoidCallback onClick;
  final String? transactionId;
   BidCard({
    super.key,
    required this.title,
    required this.bidder,
    required this.latestBid,
    required this.buttonText,
    required this.onClick,
    required this.isHistory,
    this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0x663348B5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon ?? Container(),
              const SizedBox(
                width: 12,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12, 16, 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'By ${bidder}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Text(
                      'Latest Bid: $latestBid',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 19, vertical: 8),
                    child: Text(
                      'Your Bid: $latestBid',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: transactionId != null
                ? Row(
                    children: [
                      Container(
                        width: 195,
                        child: Text(
                          '${transactionId?.substring(0, 10)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      !isHistory ? myButton(
                        height: 50,
                        width: 120,
                        text: buttonText,
                        onClick: onClick,
                      ) : Container(),
                    ],
                  )
                : myButton(
                    height: 50,
                    width: 120,
                    text: buttonText,
                    onClick: onClick,
                  ),
          ),
        ],
      ),
    );
  }
}
