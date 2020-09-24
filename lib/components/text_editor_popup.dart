import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:teste_gb/components/rounded_button.dart';

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

    return Dialog(
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
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 12),
                        padding: EdgeInsets.all(20),
                        child: Image(
                          image: AssetImage("assets/img/placeholder.jpg"),
                        ),
                      ),
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
                                    child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 8,
                                        controller: controller,
                                        onChanged: (String text) => widget.onTextChange(text),
                                        decoration: InputDecoration(
                                            hintMaxLines: 2,
                                            hintText: "Compartilhe aqui suas ideias...",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(color: Colors.green, width: 1),
                                            ))),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 4),
                              child: AutoSizeText(
                                "Escreva no máximo 280 caracteres",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey),
                              ),
                            ),
                            Container(
                              height: 29,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: MyRoundedButton(
                                      backgroundColor: Colors.green,
                                      textColor: Colors.grey,
                                      onTap: widget.cancelButtonCallback,
                                      text: "Cancelar",
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
                                            snapshot.hasData ? Colors.grey : Colors.green.withOpacity(0.3),
                                            onTap: snapshot.hasData
                                                ? () {
                                              widget.confirmButtonCallback();
                                              Navigator.pop(context);
                                            }
                                                : () {},
                                            text: "Postar",
                                          ));
                                    }),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }
}
