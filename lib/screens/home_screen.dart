// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:word_definition_app/screens/detail_screen.dart';

// import '../cubit/dictionary_cubit.dart';
// import '../helper/snackBar.dart';
// import '../repository/dictionary_repository.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DictionaryCubit(context.read<DictionaryRepository>()),
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text('text'),
//           ),
//           body: const BodyPart()),
//     );
//   }
// }

// class BodyPart extends StatelessWidget {
//   const BodyPart({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<DictionaryCubit, DictionaryState>(
//       listener: (context, state) {
//         if (state.dictionaryStatus == DictionaryStatus.notFound) {
//           snackBarMessage("Word does not have in the dictionary, please try again!", context);
//         } else if (state.dictionaryStatus == DictionaryStatus.noInternet) {
//           snackBarMessage("No Internet Connection", context);
//         }
//       },
//       child: BlocBuilder<DictionaryCubit, DictionaryState>(
//         builder: (context, state) {
//           return Column(
//             children: <Widget>[
//               ElevatedButton(
//                   onPressed: () async {
//                     await context.read<DictionaryCubit>().getDictionary();
//                     print("length: " + state.dictionaries.length.toString());

//                     if (state.dictionaryStatus == DictionaryStatus.success) {
//                       print(state.dictionaries.length);
//                       // print(state.dictionaries.last.meanings![0].definition);
//                     }
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DetailScreen(meanings: state.dictionaries.last.meanings ?? []),
//                         ));
//                   },
//                   child: Row(
//                     children: [
//                       if (state.dictionaryStatus == DictionaryStatus.loading)
//                         const Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                           ),
//                         ),
//                       const Text('Get Press'),
//                     ],
//                   )),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: state.dictionaries.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                       leading: Text(state.dictionaries[index].meanings != null ? 'Success' : 'Not Found'),
//                       title: Text(state.dictionaries[index].word));
//                 },
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
