import 'package:flutter/material.dart';
import 'package:word_definition_app/core/colors.dart';
import 'package:word_definition_app/model/dictionary.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
    required this.dict,
  }) : super(key: key);
  final Dictionary dict;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildBackButton(context),
          if (MediaQuery.of(context).orientation == Orientation.portrait) const SizedBox(height: 50),
          _buildSearchedText(),
          _buildListView()
        ],
      ),
    );
  }




  Padding _buildSearchedText() {
    return Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            widget.dict.word[0].toUpperCase() + widget.dict.word.substring(1),
            style: const TextStyle(color: kBlackColor, fontSize: 50, fontWeight: FontWeight.w600),
          ),
        );
  }

  Expanded _buildListView() {
    return Expanded(
        child: ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: widget.dict.meanings!.length,
      itemBuilder: (context, index) => _buildDefinition(index),
    ));
  }

  Widget _buildDefinition(int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 20, offset: Offset(2, 2), color: Colors.black12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: kOrangeColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.dict.meanings![index].partOfSpeech ?? '',
              style: const TextStyle(color: kWhiteColor, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          _buildHeadingText('DEFINITION'),
          const SizedBox(height: 8),
          Text(
            widget.dict.meanings![index].definition ?? 'No definition',
            style: const TextStyle(color: kBlackColor, fontSize: 16),
          ),
          const SizedBox(height: 20),
          _buildHeadingText('EXAMPLE'),
          const SizedBox(height: 8),
          Text(
            widget.dict.meanings![index].example ?? 'No example',
            style: const TextStyle(color: kBlackColor, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              SizedBox(
                width: 120,
                child: _buildHeadingText('SYNONYMS'),
              ),
              const SizedBox(width: 110),
              _buildHeadingText('ANTONYMS')
            ],
          ),
          _buildSynonymAntonym(index),
        ],
      ),
    );
  }

  Row _buildSynonymAntonym(int index) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    widget.dict.meanings![index].synonyms != null && widget.dict.meanings![index].synonyms!.isNotEmpty
                        ? widget.dict.meanings![index].synonyms!.map((e) => _buildBlueText(e)).toList()
                        : [
                            _buildBlueText('No synonyms'),
                          ],
              ),
            ),
            const SizedBox(width: 110),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  widget.dict.meanings![index].antonyms != null && widget.dict.meanings![index].synonyms!.isNotEmpty
                      ? widget.dict.meanings![index].antonyms!.map((e) => _buildBlueText(e)).toList()
                      : [
                          _buildBlueText('No antonyms'),
                        ],
            )
          ],
        );
  }

  Padding _buildBlueText(String e) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        e,
        style: const TextStyle(color: kBlueColor, fontSize: 16),
      ),
    );
  }

  Text _buildHeadingText(String text) {
    return Text(
      text,
      style: const TextStyle(color: kBlackColor, fontSize: 22, fontWeight: FontWeight.w700),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextButton(
        onPressed: () {
          Navigator.maybePop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Icon(
              Icons.arrow_back_ios_new,
              size: 28,
            ),
            SizedBox(width: 4),
            Text(
              'Search',
              style: TextStyle(color: kBlueColor, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
