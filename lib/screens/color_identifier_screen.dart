import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

import 'package:colorsense/main.dart'; // for globalCameras
import 'package:colorsense/theme/app_theme.dart';
import 'package:colorsense/screens/detail_warna_screen.dart';
import 'package:colorsense/utils/color_dictionary.dart';
import 'package:colorsense/providers/bottom_nav_provider.dart';

// -----------------------------------------------------------------------------
// 11 - Color Identifier | Figma node: 6:129
// -----------------------------------------------------------------------------

class ColorIdentifierScreen extends ConsumerStatefulWidget {
  final bool isSelectionMode;
  
  const ColorIdentifierScreen({
    super.key,
    this.isSelectionMode = false,
  });

  @override
  ConsumerState<ColorIdentifierScreen> createState() => _ColorIdentifierScreenState();
}

class _ColorIdentifierScreenState extends ConsumerState<ColorIdentifierScreen> {
  CameraController? _cameraController;
  bool _isProcessing = false;
  String? _cameraError;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      if (globalCameras.isEmpty) {
        globalCameras = await availableCameras();
      }
      if (globalCameras.isEmpty) {
        setState(() => _cameraError = 'Kamera tidak ditemukan di perangkat ini.');
        return;
      }
      final camera = globalCameras.first;
      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) setState(() => _cameraError = 'Gagal mengakses kamera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _captureAndIdentify() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      final XFile picture = await _cameraController!.takePicture();
      final bytes = await picture.readAsBytes();
      
      // Decode image
      img.Image? decodedImage = img.decodeImage(bytes);
      if (decodedImage != null) {
        // Get center pixel
        final centerX = decodedImage.width ~/ 2;
        final centerY = decodedImage.height ~/ 2;
        final pixel = decodedImage.getPixel(centerX, centerY);
        
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();

        final colorName = ColorDictionary.getClosestColorName(r, g, b);
        final hexColor = '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();

        if (mounted) {
          if (widget.isSelectionMode) {
            Navigator.pop(context, hexColor);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailWarnaScreen(
                  colorName: colorName,
                  hexColor: hexColor,
                  sourceImageBytes: bytes, // Optional: pass image
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error capturing color: $e');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.darkTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.colors.backgroundPrimary,
            body: Column(
        children: [
          // ── Camera Area ──────────────────────────────────────────────────
          Expanded(
            child: Stack(
              children: [
                // Camera Feed
                if (_cameraController != null && _cameraController!.value.isInitialized)
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CameraPreview(_cameraController!),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xFF2C2C2C), // Dark grey placeholder
                    child: Center(
                      child: _cameraError != null
                          ? Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                _cameraError!,
                                style: const TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),

                // Viewfinder Mask Overlay
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SvgPicture.asset(
                    'assets/icons/ic_viewfinder_mask.svg',
                    fit: BoxFit.cover,
                  ),
                ),

                // Center Reticle
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/ic_reticle.svg',
                    width: 64,
                    height: 64,
                  ),
                ),

                // Top Controls
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              ref.read(bottomNavIndexProvider.notifier).setIndex(0);
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/ic_arrow_left_circle.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),

                        // Flash & Camera Switch
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/icons/ic_flash_circle.svg',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            const SizedBox(width: 7),
                            GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/icons/ic_refresh_circle.svg',
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Panel ─────────────────────────────────────────────────
          Container(
            color: context.colors.backgroundPrimary,
            padding: const EdgeInsets.only(
              left: AppSpacing.screenH,
              right: AppSpacing.screenH,
              top: 20,
              bottom: 30, // SafeArea bottom padding equivalent
            ),
            child: Column(
              children: [
                // Detected Color Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Swatch
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2980B9),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Title & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Biru Cobalt',
                            style: context.textStyles.headlineSmall.copyWith(
                              fontSize: 13,
                              color: const Color(0xFFF0F0FF),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '#2980B9 · RGB(41,128,185)',
                            style: context.textStyles.bodySmall.copyWith(
                              fontSize: 9,
                              color: const Color(0xFFAFADDF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Percentage Button
                    Container(
                      width: 52,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.colors.surfaceActive,
                        border: Border.all(color: const Color(0xFF6C63FF)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '97%',
                        style: context.textStyles.labelSmall.copyWith(
                          color: const Color(0xFF6C63FF),
                          fontSize: 9,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Detail Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailWarnaScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Detail',
                          style: context.textStyles.labelSmall.copyWith(
                            color: const Color(0xFFF0F0FF),
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Recommended Colors
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildColorChip(
                        context: context,
                        color: const Color(0xFF5DADE2),
                        label: 'Biru Langit',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildColorChip(
                        context: context,
                        color: const Color(0xFF1A5276),
                        label: 'Navy',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildColorChip(
                        context: context,
                        color: const Color(0xFFAED6F1),
                        label: 'Biru Muda',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Controls Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Gallery Button
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: context.colors.surfacePrimary,
                        border: Border.all(color: context.colors.borderDefault),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/ic_gallery.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),

                    // Shutter Button
                    GestureDetector(
                      onTap: _isProcessing ? null : _captureAndIdentify,
                      child: SvgPicture.asset(
                        'assets/icons/ic_shutter.svg',
                        width: 54,
                        height: 54,
                      ),
                    ),

                    // Speaker Button
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Text(
                          '🔊',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
          );
        }
      ),
    );
  }

  Widget _buildColorChip({required BuildContext context, required Color color, required String label}) {
    return Container(
      height: 24, // Slightly taller than 20px for better touch target
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        border: Border.all(color: context.colors.borderDefault),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: context.textStyles.bodySmall.copyWith(
                color: const Color(0xFFC0C0E0),
                fontSize: 8,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
