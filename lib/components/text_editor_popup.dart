import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:teste_gb/components/rounded_button.dart';
import 'package:teste_gb/util/constants.dart';
import 'package:teste_gb/style/theme.dart' as Style;

class TextEditorPopup extends StatefulWidget {
  final Function cancelButtonCallback;
  final Function confirmButtonCallback;
  final Function(String) onTextChange;
  final Function onDispose;
  final Stream validatedTextStream;
  final String oldText;

  TextEditorPopup(
      {Key key,
        @required this.cancelButtonCallback,
        @required this.onTextChange,
        @required this.confirmButtonCallback,
        @required this.onDispose,
        @required this.validatedTextStream,
        this.oldText})
      : super(key: key);

  @override
  _TextEditorPopupState createState() => _TextEditorPopupState();
}

class _TextEditorPopupState extends State<TextEditorPopup> {
  Size deviceSize;
  TextEditingController controller;

  @override
  void initState() {
    if (widget.oldText != null) {
      controller = new TextEditingController(text: widget.oldText);
    } else {
      controller = new TextEditingController();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (deviceSize == null) deviceSize = MediaQuery.of(context).size;

    return Container(color: Colors.transparent,
      child: Dialog(backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                  child: Container(
                    width: deviceSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          padding: EdgeInsets.only(left: 19, right: 18, bottom: 26),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: deviceSize.height * 0.4,
                                  ),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 24.0),
                                        child: TextField(
                                            keyboardType: TextInputType.multiline,
                                            maxLength: 280,
                                            maxLines: null,
                                            controller: controller,
                                            onChanged: (String text) => widget.onTextChange(text),
                                            decoration: InputDecoration(
                                                hintMaxLines: 2,
                                                hintText: Constants.POST_HINT,
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Style.MyColors.greenColor, width: 1),
                                                ))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 29,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: MyRoundedButton(
                                        backgroundColor: Colors.grey,
                                        textColor: Style.MyColors.greenColor,
                                        onTap: widget.cancelButtonCallback,
                                        text: Constants.CANCEL_TEXT,
                                      )),
                                  Container(
                                    width: 12,
                                  ),
                                  StreamBuilder(
                                      stream: widget.validatedTextStream,
                                      builder: (context, snapshot) {
                                        return Expanded(
                                            child: MyRoundedButton(
                                              backgroundColor:
                                              snapshot.hasData ? Style.MyColors.greenColor : Style.MyColors.greenColor.withOpacity(0.3),
                                              onTap: snapshot.hasData
                                                  ? () {
                                                widget.confirmButtonCallback();
                                                Navigator.pop(context);
                                              }
                                                  : () {},
                                              text: Constants.OK_TEXT,
                                            ));
                                      }),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )))),
    );
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }
}
