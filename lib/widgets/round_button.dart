// import 'package:flutter/material.dart';

// class RoundButton extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;
//   final bool loading;

//   const RoundButton(
//       {super.key,
//       required this.title,
//       required this.onTap,
//       required this.loading});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 50,
//         width: 100,
//         decoration: BoxDecoration(
//           color: Colors.deepPurple,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: loading
//               ? const CircularProgressIndicator(
//                   color: Colors.white,
//                 )
//               : Text(
//                   title,
//                   style: const TextStyle(color: Colors.white, fontSize: 15),
//                 ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ButtonElevated extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading = false;

  const ButtonElevated(
      {super.key, required this.title, required this.onTap, loading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 40),
      ),
    );
  }
}
