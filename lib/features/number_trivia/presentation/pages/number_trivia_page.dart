import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tdd_clean_architecture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:flutter_tdd_clean_architecture/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:flutter_tdd_clean_architecture/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:flutter_tdd_clean_architecture/injection_container.dart';

import '../bloc/number_trivia_bloc.dart';
import '../widgets/loading_widget.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Number Trivia",
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => sl<NumberTriviaBloc>(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state is Empty) {
                        return MessageDisplay(
                          message: "Start Searching !",
                        );
                      } else if (state is Loading) {
                        return LoadingWidget();
                      } else if (state is Loaded) {
                        return TriviaDisplay(
                          numberTrivia: state.trivia,
                        );
                      } else if (state is Error) {
                        return MessageDisplay(
                          message: state.message,
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TriviaControls(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
