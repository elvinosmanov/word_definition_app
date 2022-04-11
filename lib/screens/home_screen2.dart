import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_definition_app/core/colors.dart';
import 'package:word_definition_app/cubit/dictionary_cubit.dart';
import 'package:word_definition_app/repository/dictionary_repository.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DictionaryCubit(context.read<DictionaryRepository>()),
        child: Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: <Widget>[
                  SearchForm(),
                  const SizedBox(height: 16.0),
                  ListItems(),
                ],
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
            itemCount: state.dictionaries.length,
            itemBuilder: (context, index) => Card(
              elevation: 2,
              color: state.dictionaries[index].meanings != null ? kGreyColor : kOrangeColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                child: Text(
                  state.dictionaries[index].word,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        );
      },
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
        print(state.searchText);
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
      width: 50,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all<Color>(kBlueColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)))),
        onPressed: () {
          context.read<DictionaryCubit>().getDictionary();
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
                size: 26,
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
