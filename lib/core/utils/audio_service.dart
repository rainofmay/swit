// import 'package:just_audio/just_audio.dart';
//
// class AudioService {
//   Future<AudioPlayer> createPlayer(String url, {String? title, String? artist}) async {
//     try {
//       final player = AudioPlayer();
//       final audioSource = AudioSource.uri(
//         Uri.parse(url),
//         tag: MediaItem(
//           id: url,
//           title: title ?? 'Unknown Title',
//           artist: artist ?? 'Unknown Artist',
//         ),
//       );
//       await player.setAudioSource(audioSource);
//       return player;
//     } catch (e) {
//       print('Error creating audio player: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> play(AudioPlayer player) async {
//     try {
//       await player.play();
//     } catch (e) {
//       print('Error playing audio: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> pause(AudioPlayer player) async {
//     try {
//       await player.pause();
//     } catch (e) {
//       print('Error pausing audio: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> stop(AudioPlayer player) async {
//     try {
//       await player.stop();
//     } catch (e) {
//       print('Error stopping audio: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> setVolume(AudioPlayer player, double volume) async {
//     try {
//       await player.setVolume(volume);
//     } catch (e) {
//       print('Error setting volume: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> seekTo(AudioPlayer player, Duration position) async {
//     try {
//       await player.seek(position);
//     } catch (e) {
//       print('Error seeking audio: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> setLoopMode(AudioPlayer player, LoopMode mode) async {
//     try {
//       await player.setLoopMode(mode);
//     } catch (e) {
//       print('Error setting loop mode: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> setShuffleModeEnabled(AudioPlayer player, bool enabled) async {
//     await player.setShuffleModeEnabled(enabled);
//   }
//
//   Future<void> dispose(AudioPlayer player) async {
//     try {
//       await player.dispose();
//     } catch (e) {
//       print('Error disposing audio player: $e');
//       rethrow;
//     }
//   }
// }