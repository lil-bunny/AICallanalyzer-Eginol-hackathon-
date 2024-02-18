import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmagent/view/dummydata.dart';

class AudioViewController extends GetxController {
  var isPlaying = false.obs;
  final player = AudioPlayer();
  var slidervalue = 0.0.obs;
  var currentSecond = 0.0.obs;
  var totalDuration = 0.obs;
  var sentiment = ''.obs;
  var currentChoice = 'Transcription'.obs;
  void togglePlay() async {
    isPlaying.value = !isPlaying.value;

    if (isPlaying.value) {
      // await player.setAudioSource(AudioSource.uri(Uri.parse(
      //     'https://firebasestorage.googleapis.com/v0/b/coolcat-397015.appspot.com/o/WhatsApp%20Audio%202024-02-16%20at%207.30.14%20PM.aac?alt=media&token=255d9b55-3163-4fab-92b8-327444cb77ba')));

      await player.play();
    } else {
      await player.pause();
    }
  }

  var url = TextEditingController();
  var transcribeStatus = false.obs;
  Future<void> transcribeAudio(audiourl) async {
    var url = 'http://127.0.0.1:8000/transcribe_audio';
    var formData = dio.FormData();
    formData.fields.addAll([MapEntry("url", audiourl)]);
    var data = await dio.Dio()
        .post(url,
            data: formData,
            options: dio.Options(headers: {
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
              'Access-Control-Allow-Headers':
                  'Origin, Content-Type, Accept, Authorization',
            }))
        .then((value) => value.data);
    print("done calling=${data}");
    customerObjection.value = data['customer_objection'];
    customerSteps.value = data['customer_steps'];
    agentImprovement.value = data['agent_improvement'];
    entity_data.value = data['entity_list'];
    sentiment.value = data['sentiment'];
    print("got sentiment=${sentiment.value}");
    transcribeStatus.value = true;
  }
}
