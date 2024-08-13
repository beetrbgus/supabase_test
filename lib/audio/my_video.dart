import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_test/audio/position_data.dart';
import 'package:supabase_test/audio/seek_bar.dart';

class MyVideo extends StatefulWidget {
  const MyVideo({super.key});

  @override
  State<StatefulWidget> createState() => _MyVideoState();
}

class _MyVideoState extends State<MyVideo> {
  String url =
      'https://cymczsdxjrhihyvrsiry.supabase.co/storage/v1/object/sign/testbucket/public/REC_03.wav?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0ZXN0YnVja2V0L3B1YmxpYy9SRUNfMDMud2F2IiwiaWF0IjoxNzIzNDczMzY4LCJleHAiOjE3NTUwMDkzNjh9.yiT2PvyeMFmcFDXd16zm-3X64DMesD_wioSe-NTzt6c&t=2024-08-12T14%3A36%3A08.954Z';
  String imgUrl =
      'https://cymczsdxjrhihyvrsiry.supabase.co/storage/v1/object/sign/testbucket/public/cat.jpeg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0ZXN0YnVja2V0L3B1YmxpYy9jYXQuanBlZyIsImlhdCI6MTcyMzQ3Mzk1NSwiZXhwIjoxNzU1MDA5OTU1fQ.kmoO8LEvH2Sg00cQQJ8P-CUdKPQKP28GvBd1r26ufzk&t=2024-08-12T14%3A45%3A55.766Z';
  late AudioPlayer player;
  bool isPlaying = false;
  double volume = 0.5;
  bool isVolumeDisabled = false;

  void _playAudio() async {
    setState(() {
      isPlaying = true;
    });
    await player.play();
  }

  void _pauseAudio() async {
    setState(() {
      isPlaying = false;
    });
    await player.pause();
  }

  void _activateVolume() async {
    // Set volume to previous value before it was 0
    await player.setVolume(volume);
    setState(() {
      isVolumeDisabled = false;
    });
  }

  void _disableVolume() async {
    // Set volume to 0
    await player.setVolume(0);
    setState(() {
      if (volume > 0) {
        isVolumeDisabled = true;
      }
    });
  }

  IconData _getPlayPauseIcon() {
    return (isPlaying) ? Icons.pause : Icons.play_arrow;
  }

  IconData _getVolumeIcon() {
    return (player.volume == 0) ? Icons.volume_off : Icons.volume_up_rounded;
  }

  void _initialize() async {
    player = AudioPlayer();

    await player.setUrl(url);
    await player.setVolume(volume);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Just Audio Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 300,
            child: Image.network(imgUrl),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  switch (isPlaying) {
                    case true:
                      return _pauseAudio();
                    default:
                      return _playAudio();
                  }
                },
                icon: Icon(_getPlayPauseIcon(), size: 50, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          StreamBuilder<PositionData>(
            stream: _positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              Duration remaining = (positionData?.duration != null &&
                      positionData?.position != null)
                  ? positionData!.duration - positionData.position
                  : Duration.zero;
              return Row(
                children: [
                  Expanded(
                    child: SeekBar(
                      duration: positionData?.duration ?? Duration.zero,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                      onChangeEnd: player.seek,
                    ),
                  ),
                  Text(
                    RegExp(r'((^0*[1-9]d*:)?d{2}:d{2}).d+$')
                            .firstMatch("$remaining")
                            ?.group(1) ??
                        '$remaining',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  switch (isVolumeDisabled) {
                    case true:
                      return _activateVolume();
                    default:
                      return _disableVolume();
                  }
                },
                icon: Icon(_getVolumeIcon(), size: 30, color: Colors.white),
              ),
              Expanded(
                child: Slider(
                  value: player.volume,
                  max: 1,
                  min: 0,
                  onChanged: (value) async {
                    setState(() {
                      volume = value;
                    });
                    await player.setVolume(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
