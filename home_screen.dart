// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromRGBO(255, 153, 51, 5),
              Color.fromRGBO(255, 255, 255, 5),
              Color.fromRGBO(19, 136, 8, 5),
            ]),
        shape: BoxShape.rectangle,
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
                child: RichText(
              text: TextSpan(
                text: 'D',
                style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black,
                        offset: Offset(0, 2.0),
                      ),
                    ],
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Color.fromRGBO(0, 0, 128, 5)),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'OWNLODER',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          color: Color.fromRGBO(0, 0, 128, 5))),
                ],
              ),
            )),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        onChanged: (value) {},
                        controller: textController,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Past Your URL',
                          helperStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shadowColor:
                                  MaterialStatePropertyAll(Colors.blue),
                              backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(255, 153, 51, 5),
                              )),
                          onPressed: () async {
                            ClipboardData? cdata =
                                await Clipboard.getData(Clipboard.kTextPlain);

                            textController.text = cdata!.text.toString();
                          },
                          child: Text("Past")),
                    )
                  ],
                )),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(Colors.blue),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(0, 0, 128, 5))),
                  onPressed: () {
                    FileDownloader.downloadFile(
                        url: textController.value.text,
                        name: "Downloader File",
                        onProgress: (fileName, progress) =>
                            CircularProgressIndicator(),
                        onDownloadError: (errorMessage) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)));
                        },
                        onDownloadCompleted: (path) async {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Download Completed -> $path")));
                        });
                  },
                  child: Text("Download")),
            )
          ],
        ),
      ),
    ));
  }
}
