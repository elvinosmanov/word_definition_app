import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/dictionary_cubit.dart';
import '../repository/dictionary_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DictionaryCubit(context.read<DictionaryRepository>()),
      child: Scaffold(
          appBar: AppBar(
            title: Text('text'),
          ),
          body: const BodyPart()),
    );
  }
}

class BodyPart extends StatelessWidget {
  const BodyPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocListener<DictionaryCubit, DictionaryState>(
      listener: (context, state) {
        if (state.dictionaryStatus == DictionaryStatus.notFound) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("problem"),
              ),
            );
        }
      },
      child: BlocBuilder<DictionaryCubit, DictionaryState>(
        builder: (context, state) {
          if (state.dictionaryStatus == DictionaryStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      context.read<DictionaryCubit>().getDictionary("bananaf");
                    },
                    child: const Text('Get Press')),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.dictionaries.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading:  Text(state.dictionaries[index].meanings!=null?'Success':'Not Found'), title: Text(state.dictionaries[index].word));
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}
