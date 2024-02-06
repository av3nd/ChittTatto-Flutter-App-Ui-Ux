// import 'package:amazonclone/common/widgets/loader.dart';
// import 'package:amazonclone/features/account/services/account_services.dart';
// import 'package:amazonclone/features/admin/model/sales.dart';
// import 'package:amazonclone/features/admin/services/admin_service.dart';
// // import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';

// class AnalyticsScreen extends StatefulWidget {
//   const AnalyticsScreen({Key? key}) : super(key: key);

//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen> {
//   final AdminServices adminServices = AdminServices();
//   int? totalSales;
//   List<Sales>? earnings;

//   @override
//   void initState() {
//     super.initState();
//     getEarnings();
//   }

//   getEarnings() async {
//     var earningData = await adminServices.getEarnings(context);
//     totalSales = earningData['totalEarnings'];
//     earnings = earningData['sales'];
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return earnings == null || totalSales == null
//         ? const Loader()
//         : Column(
//             children: [
//               Text(
//                 '\$$totalSales',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // SizedBox(
//               //   height: 250,
//               //   child: CategoryProductsChart(seriesList: [
//               //     charts.Series(
//               //       id: 'Sales',
//               //       data: earnings!,
//               //       domainFn: (Sales sales, _) => sales.label,
//               //       measureFn: (Sales sales, _) => sales.earning,
//               //     ),
//               //   ]),
//               // ),
//               ElevatedButton(
//                   onPressed: () => AccountServices().logOut(context),
//                   child: Text('Log Out'))
//             ],
//           );
//   }
// }
