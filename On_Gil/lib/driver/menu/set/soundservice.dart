import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class SoundService {
  final AudioPlayer _player = AudioPlayer();

  bool soundEnabled = true;
  bool vibrationEnabled = true;

  Future<void> playAlert() async {
    if (soundEnabled) {
      await _player.play(AssetSource('alert.mp3'));
    }

    if (vibrationEnabled) {
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 1000);
      }
    }
  }

  void setSound(bool value) {
    soundEnabled = value;
  }

  void setVibration(bool value) {
    vibrationEnabled = value;
  }
}
