import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmagent/controller/audiopagecontroller.dart';
import 'package:pmagent/view/dummydata.dart';

class AudioView extends StatefulWidget {
  const AudioView({super.key});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  var controller = AudioViewController();
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    // controller.player.playerStateStream.listen((state) {
    //   if (state.processingState == ProcessingState.idle) {
    //     print("playing ${controller.player.position.inSeconds.toDouble()}");
    //     controller.currentSecond.value =
    //         controller.player.position.inSeconds.toDouble();

    //     print(controller.currentSecond.value);
    //   } else {
    //     print("not playing");
    //   }
    // });
    controller.player
        .setUrl(
            'https://firebasestorage.googleapis.com/v0/b/coolcat-397015.appspot.com/o/WhatsApp%20Audio%202024-02-16%20at%207.30.14%20PM.aac?alt=media&token=255d9b55-3163-4fab-92b8-327444cb77ba')
        .then((value) {
      controller.totalDuration.value = value!.inSeconds;
      print("total duration=${controller.totalDuration.value}");
    });

    controller.player.positionStream.listen((event) {
      controller.currentSecond.value = event!.inSeconds.toDouble();
      print("current second=${event!.inSeconds}");
    });
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    void showProcessingUnit() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                content: Container(
                    height: height * 0.3,
                    width: width * 0.39,
                    child: ListTile(
                      visualDensity: VisualDensity(
                        vertical: 4,
                      ),
                      dense: true,
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(
                                        'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExdjF3dDFzaDdxdmdjdnB3Z2o1OGs4bmtiamVpanVsc3V5OGZpd2JyMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/9RsqXfdNHapMgVjicE/giphy.gif'))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'AI is anlayzing the callrecording ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Generating  may take up to 120-150 seconds'),
                              AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        '\"AI is summarizing\" ',
                                        speed: Duration(milliseconds: 200),
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold)),
                                    TypewriterAnimatedText(
                                        '\"Finding customer objection\" ',
                                        speed: Duration(milliseconds: 200),
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold)),
                                    TypewriterAnimatedText(
                                        '\"Analyzing agent performance\" ',
                                        speed: Duration(milliseconds: 200),
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold))
                                  ])

                              // Text(
                              //   'Please wait while we prepare your testcases .You can also choose to close this tab and\n we will mail you once its done',
                              //   textAlign: TextAlign.center,
                              // )
                            ],
                          ),
                        ],
                      ),
                    )),
              ));
    }

    Widget audioCard() {
      return Obx(
        () => ListTile(
          leading: InkWell(
            onTap: () async {
              print('hello');

              controller.togglePlay();
            },
            child: CircleAvatar(
              child: Icon(
                controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
            ),
          ),
          title: controller.totalDuration.value == 0
              ? Container()
              : Slider(
                  value: controller.currentSecond.value,
                  onChanged: (s) {
                    print(s);
                    controller.currentSecond.value = s;
                    controller.player.seek(Duration(seconds: s.toInt()));
                  },
                  max: controller.totalDuration.value.toDouble(),
                  min: 0.0),
          trailing: StreamBuilder(
            stream: controller.player.durationStream,
            builder: (context, snapshot) => Text(
              snapshot.data != null
                  ? '${snapshot.data!.inSeconds / 60}:${((snapshot.data!.inSeconds % 60) == 0) ? '00' : (snapshot.data!.inSeconds % 60)}'
                  : 'null',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      );
    }

    return Obx(
      () => Scaffold(
        // appBar: AppBar(),
        body: Container(
          height: height,
          width: width,
          child: !controller.transcribeStatus.value
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height * 0.3,
                      width: width / 3,
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Call \'s ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'Analyst AI ',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          TextField(
                            controller: controller.url,
                            decoration:
                                InputDecoration(hintText: 'Enter audio url'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  showProcessingUnit();
                                  await controller
                                      .transcribeAudio(controller.url.text)
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Analyze')),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Row(
                    children: [
                      Container(
                        color: Colors.white,
                        width: width * 0.65,
                        height: height,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: audioCard(),
                              ),
                              Container(
                                width: width * 0.65,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.currentChoice.value =
                                            'Transcription';
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller.currentChoice
                                                            .value ==
                                                        'Transcription'
                                                    ? Colors.deepPurple
                                                    : Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: controller
                                                        .currentChoice.value ==
                                                    'Transcription'
                                                ? Colors.deepPurple
                                                : Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Transcription',
                                                style: TextStyle(
                                                    color: controller
                                                                .currentChoice
                                                                .value ==
                                                            'Transcription'
                                                        ? Colors.white
                                                        : Colors.black)),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        controller.currentChoice.value =
                                            "Insights";
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller.currentChoice
                                                            .value ==
                                                        'Insights'
                                                    ? Colors.deepPurple
                                                    : Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: controller
                                                        .currentChoice.value ==
                                                    'Insights'
                                                ? Colors.deepPurple
                                                : Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Insights',
                                                style: TextStyle(
                                                    color: controller
                                                                .currentChoice
                                                                .value ==
                                                            'Insights'
                                                        ? Colors.white
                                                        : Colors.black)),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              controller.currentChoice.value == 'Transcription'
                                  ? Container(
                                      height: height * 0.8,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: speakerData.length,
                                        itemBuilder: (context, index) =>
                                            ListTile(
                                          title: Text(
                                              'Speaker ${speakerData[index]['speaker_type']}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          subtitle: Text(
                                              '${speakerData[index]['speaker_text']}'),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: height * 0.8,
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Customer Objection',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle:
                                                Text('${customerObjection}'),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Steps Discussed if any',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text('${customerSteps}'),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Agent Improvement',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle:
                                                Text('${agentImprovement}'),
                                          )
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 218, 223, 226),
                        width: width - width * 0.65,
                        height: height,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height * 0.05,
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: Text(
                                      '   Entities'.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    height: height / 2,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: filterAndCombineDuplicates(
                                                entity_data)
                                            .length,
                                        itemBuilder: (context, index) {
                                          var entitydata_test = [];

                                          var entity_data_test =
                                              filterAndCombineDuplicates(
                                                  entity_data);
                                          return ListTile(
                                            title: Text(
                                                entity_data_test[index]
                                                        ['entity_type']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle: Text(
                                                entity_data_test[index]
                                                        ['entity_text']
                                                    .toString()),
                                          );
                                        }),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: ListTile(
                                        title: Text(
                                          '   Sentimental Analysis'.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        subtitle: Text(
                                            'There are 10 positive and 5 negetive statements')),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
