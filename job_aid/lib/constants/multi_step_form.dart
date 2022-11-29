import 'package:flutter/material.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'models/step_model.dart';

class MultiStepForm extends StatefulWidget {
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? buttonBackgroundColor;
  final List<StepModel>? steps;
  final Function()? onCompleted;

  const MultiStepForm({
    Key? key,
    required this.selectedColor,
    required this.unselectedColor,
    required this.steps,
    required this.buttonBackgroundColor,
    required this.onCompleted,
  }) : super(key: key);

  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final formKey = GlobalKey<FormState>();
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int _curPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: StepProgressIndicator(
              totalSteps: widget.steps!.length,
              currentStep: _curPage,
              size: 36,
              selectedColor: widget.selectedColor!,
              unselectedColor: widget.unselectedColor!,
              customStep: (index, color, _) => color == Colors.black
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: color,
                          ),
                        ),
                        Text(
                          widget.steps![index].title!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: color),
                        )
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: color,
                          ),
                        ),
                        Text(
                          widget.steps![index].title!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: color),
                        )
                      ],
                    ),
            ),
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: PageView(
                controller: pageController,
                pageSnapping: false,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  widget.steps!.length,
                  (index) => widget.steps![index].body!,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        color: AppColor.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_curPage > 1)
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _curPage--;
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                  });
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      TextSpan(text: ' Back'),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            MaterialButton(
              onPressed: _curPage == widget.steps!.length
                  ? widget.onCompleted!
                  : () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          pageController.animateToPage(_curPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear);
                          _curPage++;
                        });
                      }
                    },
              child: _curPage == widget.steps!.length
                  ? const Text('Submit')
                  : RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'Next '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.arrow_forward,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
