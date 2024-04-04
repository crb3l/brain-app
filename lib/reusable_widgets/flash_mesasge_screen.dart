import 'package:flutter/material.dart';

class FlashMessageScreen extends StatelessWidget {
  const FlashMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("Flutter default SnackBar is showing."),
                  behavior: SnackBarBehavior.floating),
            );
          },
          child: const Text("Show"),
        ),
      ),
    );
  }
}

// class FlashMessageScreen extends StatelessWidget {
//   const FlashMessageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Container(
//                   padding: EdgeInsets.all(16),
//                   height: 90,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFC72C41),
//                   ),
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 48),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Oh snap!",
//                               style: TextStyle(fontSize: 18, color: Colors.white),
//                             ),
//                             Text(
//                               "Flutter default SnackBar is showing.",
//                               style: TextStyle(fontSize: 12, color: Colors.white),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 behavior: SnackBarBehavior.floating,
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//               ),
//             );
//           },
//           child: const Text("Show message."),
//         ),
//       ),
//     );
//   }
// }
