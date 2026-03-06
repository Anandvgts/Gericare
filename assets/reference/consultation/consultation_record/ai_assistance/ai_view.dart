import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/ai_assistance/ai_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:stacked/stacked.dart';

class AIAssistanceView extends StatelessWidget {
  const AIAssistanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AIAssistanceViewModel>.reactive(
      viewModelBuilder: () => AIAssistanceViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarWidget(
            backgroundColor: Colors.white,
            showBack: true,
            title: 'AI Assistance',
          ),
          backgroundColor: context.colors.background,
          bottomNavigationBar: _BottomButtons(vm),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Title(),
              const SizedBox(height: 52),

              /// CENTER CONTENT
              _CenterContent(vm),
            ],
          ),
        );
      },
    );
  }
}

class _CenterContent extends StatelessWidget {
  final AIAssistanceViewModel vm;
  const _CenterContent(this.vm);

  @override
  Widget build(BuildContext context) {
    switch (vm.state) {
      case AIRecordState.idle:
        return _RecordButton(
          label: "Record",
          onTap: vm.startRecording,
        );

      case AIRecordState.recording:
        return Column(
          children: [
            _RecordButton(
              label: "Stop",
              onTap: vm.stopRecording,
            ),
            const SizedBox(height: 16),
            Text(vm.timerText,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            const Text(
              "Listening...",
              style: TextStyle(
                color: Color(0xFF4CAF50),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );

      case AIRecordState.recorded:
        return _AudioWaveCard(timer: vm.timerText);
    }
  }
}

class _RecordButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _RecordButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4CAF50).withOpacity(0.25),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6FBF73),
                Color(0xFF3E8E41),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AudioWaveCard extends StatefulWidget {
  final String timer;
  const _AudioWaveCard({required this.timer});

  @override
  State<_AudioWaveCard> createState() => _AudioWaveCardState();
}

class _AudioWaveCardState extends State<_AudioWaveCard> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE6EAEA)),
      ),
      child: Row(
        children: [
          /// PLAY / PAUSE BUTTON
          GestureDetector(
            onTap: () {
              setState(() => isPlaying = !isPlaying);
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6FBF73),
                    Color(0xFF3E8E41),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// WAVEFORM
          Expanded(
            child: SizedBox(
              height: 26,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  38,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: Container(
                      width: 2,
                      height: (i % 7 + 4).toDouble(),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBFC6C4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// TIMER
          Text(
            widget.timer,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2933),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: Column(
        children: const [
          Text(
            "AI Assistant",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Capture audio to produce an automated clinical summary.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  final AIAssistanceViewModel vm;
  const _BottomButtons(this.vm);

  @override
  Widget build(BuildContext context) {
    final canProcess = vm.state == AIRecordState.recorded;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey,
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    canProcess ? const Color(0xFF4CAF50) : Colors.grey.shade300,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: canProcess ? 2 : 0,
              ),
              onPressed: canProcess
                  ? () async {
                      final file = await vm.processRecording();
                      if (file != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Saved: ${file.path}")),
                        );
                      }
                    }
                  : null,
              child: const Text("Process Recording"),
            ),
          ),
        ],
      ),
    );
  }
}
