import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_definition_app/core/colors.dart';
import 'package:word_definition_app/cubit/dictionary_cubit.dart';
import 'package:word_definition_app/repository/dictionary_repository.dart';
import 'package:word_definition_app/screens/second_page.dart';

import '../helper/snack_bar.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DictionaryCubit(context.read<DictionaryRepository>()),
        child: BlocListener<DictionaryCubit, DictionaryState>(
          listener: (context, state) {
            if (state.dictionaryStatus == DictionaryStatus.notFound) {
              snackBarMessage("There is no such word in the dictionary, please try again!", context);
            } else if (state.dictionaryStatus == DictionaryStatus.noInternet) {
              snackBarMessage("No Internet Connection", context);
            } else if (state.dictionaryStatus == DictionaryStatus.success) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(dict: state.dictionaries[0]),
                  ));
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: MediaQuery.of(context).orientation == Orientation.portrait ? true : false,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0, top: 32),
                      child: Text(
                        'Dictionary',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SearchForm(),
                    const SizedBox(height: 16.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, bottom: 12),
                      child: Text('Recent', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const ListItems(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ListItems extends StatelessWidget {
  const ListItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: state.dictionaries.length,
            itemBuilder: (context, index) => _buildCard(state, index, context),
          ),
        );
      },
    );
  }

  Widget _buildCard(DictionaryState state, int index, BuildContext context) {
    return InkWell(
      onTap: state.dictionaries[index].meanings != null
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(dict: state.dictionaries[index]),
                  ));
            }
          : null,
      child: Card(
        elevation: 2,
        color: state.dictionaries[index].meanings != null ? kGreyColor : kOrangeColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
          child: Text(
            state.dictionaries[index].word,
            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  SearchForm({
    Key? key,
  }) : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DictionaryCubit, DictionaryState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            Expanded(child: _buildTextField(context, state, controller)),
            const SizedBox(width: 8),
            _buildSearchButton(context, state),
          ],
        );
      },
    );
  }

  SizedBox _buildSearchButton(BuildContext context, DictionaryState state) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all<Color>(kBlueColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)))),
        onPressed: () async {
          await context.read<DictionaryCubit>().getDictionary();
          controller.clear();
        },
        child: state.dictionaryStatus == DictionaryStatus.loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ))
            : const Icon(
                Icons.search,
                color: kWhiteColor,
                size: 30,
              ),
      ),
    );
  }

  TextField _buildTextField(BuildContext context, state, TextEditingController controller) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        context.read<DictionaryCubit>().searchTextChanged(value);
      },
      cursorColor: kBlackColor,
      onSubmitted: (value) {
        context.read<DictionaryCubit>().getDictionary();
      },
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: "Search word...",
        suffixIcon: state.searchText.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: kBlackColor,
                  size: 26,
                ),
                onPressed: () {
                  context.read<DictionaryCubit>().searchTextChanged("");
                  controller.clear();
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kGreyColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kGreyColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
