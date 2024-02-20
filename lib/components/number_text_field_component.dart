import 'package:flutter/material.dart';
import 'package:htag_directory/services/generate_hashtag/generate_hashtag_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';

class NumberTextFieldComponent extends StatefulWidget {
  const NumberTextFieldComponent({Key? key}) : super(key: key);

  @override
  State<NumberTextFieldComponent> createState() =>
      _NumberTextFieldComponentState();
}

class _NumberTextFieldComponentState extends State<NumberTextFieldComponent> {
  int _number = 0;

  late final TextEditingController _numberController = TextEditingController(
    text: "0",
  );

  @override
  dispose() {
    _numberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GenerateHashtagBloc, GenerateHashtagState>(
      listener: (context, state) {
        if (state is GenerateHashtagInitialState) {
          _numberController.text = (context.read<GenerateHashtagBloc>().state
                  as GenerateHashtagInitialState)
              .number
              .toString();
        }
      },
      child: TextField(
        controller: _numberController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: '0',
          prefixIcon: IconButton(
            onPressed: () {
              if (_number == 0) return;
              setState(() => _number--);

              context
                  .read<GenerateHashtagBloc>()
                  .add(OnChangeNumberHastagEvent(_number));

              _numberController.text = '$_number';
            },
            icon: const Icon(
              Icons.minimize,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _number++);

              context
                  .read<GenerateHashtagBloc>()
                  .add(OnChangeNumberHastagEvent(_number));

              _numberController.text = '';
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}
