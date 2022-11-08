import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:task_app/core/utils/enum.dart';
import 'package:task_app/presentation/controller/home/home_bloc.dart';
import 'package:task_app/presentation/controller/home/home_state.dart';
import 'package:task_app/presentation/screens/component/compenent.dart';
import '../../../core/services/service_locator.dart';
import '../../controller/home/home_event.dart';

class AddTaskScreen extends StatefulWidget {
  final void Function(String path) onStop;
   AddTaskScreen({Key? key,required this.onStop}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var startDateController = TextEditingController();

  var endDateController = TextEditingController();

  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;
   dynamic path;

@override
  void initState() {
  _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
    setState(() => _recordState = recordState);
  });

  _amplitudeSub = _audioRecorder
      .onAmplitudeChanged(const Duration(milliseconds: 300))
      .listen((amp) => setState(() => _amplitude = amp));
    super.initState();

  }
  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
          print('${AudioEncoder.aacLc.name} supported: $isSupported');


        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
        print(e);
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    path = await _audioRecorder.stop();

    print(path);
    if (path != null) {
      widget.onStop(path);
    }
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Task"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600"
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: IconButton(
                            onPressed: () {
                              print('click');
                              sl<HomeBloc>().add(GetImageFromGalleryEvent());
                            }, icon: const Icon(Icons.image, size: 32,),
                            color: Colors.blue,

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.1,),
                  defaultFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title must not be empty';
                        }
                        return null;
                      },
                      label: "Title",
                      prefixIcon: Icons.title),
                  SizedBox(height: height * 0.01,),
                  defaultFormField(
                      controller: descriptionController,
                      type: TextInputType.text,
                      label: "Description",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Description must not be empty';
                        }
                        return null;
                      },
                      prefixIcon: Icons.description),
                  SizedBox(height: height * 0.01,),
                  defaultFormField(
                      controller: startDateController,
                      type: TextInputType.none,
                      onTap: () {
                        showDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          context: context,
                        ).then((value) {
                          startDateController.text =
                          value.toString().split(' ')[0];
                        });
                      },
                      label: "Start Date",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Start Date must not be empty';
                        }
                        return null;
                      },
                      prefixIcon: Icons.date_range),
                  SizedBox(height: height * 0.01,),
                  defaultFormField(
                      controller: endDateController,
                      type: TextInputType.none,
                      onTap: () {
                        showDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050), context: context,
                        ).then((value) {
                          endDateController.text = value.toString().split(' ')[0];
                        });
                      },
                      label: "End Date",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'End Date must not be empty';
                        }
                        return null;
                      },
                      prefixIcon: Icons.date_range),

                  SizedBox(height: height * 0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildRecordStopControl(),
                  const SizedBox(width: 20),
                  _buildPauseResumeControl(),
                  const SizedBox(width: 20),
                  _buildText(),
                ],
              ),
              if (_amplitude != null) ...[
            const SizedBox(height: 40),
            Text('Current: ${_amplitude?.current ?? 0.0}'),
            Text('Max: ${_amplitude?.max ?? 0.0}'),],
                  // Row(
                  //   children: [
                  //     StreamBuilder(
                  //       stream: recorder.onProgress,
                  //         builder: (context,snapshot){
                  //         final duration=snapshot.hasData?
                  //         snapshot.data!.duration:Duration.zero;
                  //         String twoDigits(int n)=>n.toString().padLeft(1);
                  //         final twoDigitMinutes=twoDigits(duration.inMinutes.remainder(60));
                  //         final twoDigitSeconds=twoDigits(duration.inSeconds.remainder(60));
                  //         return Text("$twoDigitMinutes:$twoDigitSeconds");
                  //         },
                  //
                  //     ),
                  //     const Spacer(),
                  //     ElevatedButton(
                  //         onPressed: ()async{
                  //           recorder.isRecording?await stop():await record();
                  //           setState(() {
                  //
                  //           });
                  //         },
                  //         child: Icon(
                  //           recorder.isRecording?Icons.stop:Icons.mic,
                  //           size: 20,
                  //         )),
                  //   ],
                  //
                  SizedBox(height: height * 0.1,),

                  defaultButton(text: 'Save Task', function: () {
                    print(path);
                    print(state.image!.path);
                    sl<HomeBloc>().add(
                        SendTaskDataEvent(
                            title: titleController.text,
                            description: descriptionController.text,
                            voicePath: path??"",
                            voiceName: 'Voice',
                            imagePath: state.image!.path,
                            imageName: state.image!.name,
                            startDate: startDateController.text,
                            endDate: endDateController.text));
                  })


                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if(state.sendTaskState==RequestState.loaded) {
          Navigator.pop(context);
          showToast(text: "Task Sent Successfully", state: ToastStates.SUCCESS);
        }
      }),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (_recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            print(path);
            (_recordState == RecordState.pause) ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }

    return const Text("Waiting to record");
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}

