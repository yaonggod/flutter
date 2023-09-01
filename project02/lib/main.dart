import 'package:flutter/material.dart';
import 'package:project01/widgets/button.dart';
import 'package:project01/widgets/currency_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Hey, Siri',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w600,
                          )),
                      Text('welcome back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 18,
                          )),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 120,
              ),
              Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '\$ 5 194 482',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.amber,
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: const Padding(
                  //       padding: EdgeInsets.symmetric(
                  //         horizontal: 50,
                  //         vertical: 20,
                  //       ),
                  //       child: Text(
                  //         'Transfer',
                  //         style: TextStyle(
                  //           fontSize: 22,
                  //         ),
                  //       )),
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: const Color.fromARGB(255, 47, 47, 47),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: const Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 50,
                  //       vertical: 20,
                  //     ),
                  //     child: Text(
                  //       'Request',
                  //       style: TextStyle(
                  //         fontSize: 22,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Button(
                    text: 'transfer',
                    bgColor: Colors.amber,
                    txtColor: Colors.black,
                  ),
                  Button(
                    bgColor: Color.fromARGB(255, 47, 47, 47),
                    text: 'request',
                    txtColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Wallets',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   clipBehavior: Clip.hardEdge,
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 47, 47, 47),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(20),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const Text(
              //               'Euro',
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 32,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             Row(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: [
              //                 const Text(
              //                   '6 428',
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 20,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text(
              //                   'EUR',
              //                   style: TextStyle(
              //                     color: Colors.white.withOpacity(0.7),
              //                     fontSize: 15,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //         Transform.scale(
              //           scale: 2,
              //           child: Transform.translate(
              //             offset: const Offset(-10, 15),
              //             child: Icon(
              //               Icons.euro_rounded,
              //               color: Colors.white.withOpacity(0.5),
              //               size: 80,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              const CurrencyCard(
                name: 'Euro',
                code: 'EUR',
                amount: '6 428',
                icon: Icons.euro_rounded,
                isInverted: false,
                order: 1,
              ),

              const CurrencyCard(
                name: 'Bitcoin',
                code: 'BTC',
                amount: '400',
                icon: Icons.currency_bitcoin,
                isInverted: true,
                order: 2,
              ),
              const CurrencyCard(
                name: 'Dollar',
                code: 'USD',
                amount: '2 340',
                icon: Icons.attach_money_outlined,
                isInverted: false,
                order: 3,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
