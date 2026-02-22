import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class SoundService {
  final AudioPlayer _player = AudioPlayer();

  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  void setSound(bool enabled) {
    _soundEnabled = enabled;

    if (!enabled) {
      _player.stop();
    }
  }

  void setVibration(bool enabled) {
    _vibrationEnabled = enabled;
  }

  Future<void> playAlert() async {
    if (_soundEnabled) {
      await _player.play(AssetSource('alert.wav'));
    }

    if (_vibrationEnabled &&
        (await Vibration.hasVibrator() ?? false)) {
      Vibration.vibrate(duration: 300);
    }
  }
}