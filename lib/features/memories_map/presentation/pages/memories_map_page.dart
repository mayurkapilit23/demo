import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../di/memories_map_di.dart';
import '../bloc/memories_map_bloc.dart';
import '../bloc/memories_map_event.dart';
import '../bloc/memories_map_state.dart';
import '../widgets/empty_memory_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/memory_info_bottom_sheet.dart';
import '../../domain/entities/memory_location.dart';
import 'memory_detail_page.dart';

class MemoriesMapPage extends StatelessWidget {
  const MemoriesMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MemoriesMapBloc>()..add(LoadMemoriesMap()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Memories Map'),
        ),
        body: BlocBuilder<MemoriesMapBloc, MemoriesMapState>(
          builder: (context, state) {
            if (state is MemoriesMapLoading) {
              return const LoadingWidget();
            } else if (state is MemoriesMapLoaded) {
              if (state.memories.isEmpty) {
                return const EmptyMemoryWidget();
              }
              return _GoogleMapContent(memories: state.memories);
            } else if (state is MemoriesMapError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _GoogleMapContent extends StatefulWidget {
  final List<MemoryLocation> memories;

  const _GoogleMapContent({required this.memories});

  @override
  State<_GoogleMapContent> createState() => _GoogleMapContentState();
}

class _GoogleMapContentState extends State<_GoogleMapContent> {
  late GoogleMapController _controller;
  final Map<String, BitmapDescriptor> _markerIcons = {};
  final Map<String, BitmapDescriptor> _selectedMarkerIcons = {};
  String? _selectedMemoryId;
  MapType _currentMapType = MapType.normal;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 4.8,
  );

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.hybrid
          : MapType.normal;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
  }

  @override
  void didUpdateWidget(_GoogleMapContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.memories != oldWidget.memories) {
      _loadCustomMarkers();
    }
  }

  Future<void> _loadCustomMarkers() async {
    for (final memory in widget.memories) {
      if (!_markerIcons.containsKey(memory.id)) {
        final icon = await _generateMarkerIcon(memory);
        final selectedIcon = await _generateMarkerIcon(memory, isSelected: true);
        if (mounted) {
          setState(() {
            _markerIcons[memory.id] = icon;
            _selectedMarkerIcons[memory.id] = selectedIcon;
          });
        }
      }
    }
  }

  Future<BitmapDescriptor> _generateMarkerIcon(MemoryLocation memory, {bool isSelected = false}) async {
    const double imageSize = 120;
    const double textPadding = 8;
    const double fontSize = 28;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
    );
    textPainter.text = TextSpan(
      text: memory.title,
      style: TextStyle(
        fontSize: fontSize,
        color: isSelected ? Colors.deepPurple : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();

    final double width = imageSize > textPainter.width ? imageSize : textPainter.width;
    final double height = imageSize + textPadding + textPainter.height;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // 1. Draw Image with border
    final double imageLeft = (width - imageSize) / 2;
    
    // Draw background circle for image
    canvas.drawCircle(
      Offset(imageLeft + imageSize / 2, imageSize / 2),
      imageSize / 2 + 6,
      Paint()..color = isSelected ? Colors.deepPurple : Colors.white,
    );

    try {
      final ui.Image image = await _loadNetworkImage(memory.imageUrl);
      
      canvas.save();
      final Path clipPath = Path()
        ..addOval(Rect.fromLTWH(imageLeft, 0, imageSize, imageSize));
      canvas.clipPath(clipPath);
      
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(imageLeft, 0, imageSize, imageSize),
        image: image,
        fit: BoxFit.cover,
      );
      canvas.restore();
    } catch (e) {
      canvas.drawCircle(
        Offset(imageLeft + imageSize / 2, imageSize / 2),
        imageSize / 2,
        Paint()..color = Colors.grey[300]!,
      );
    }

    // 2. Draw Title Text below image
    textPainter.paint(
      canvas,
      Offset((width - textPainter.width) / 2, imageSize + textPadding),
    );

    final ui.Image markerImage = await pictureRecorder.endRecording().toImage(
          width.toInt(),
          height.toInt(),
        );
    final ByteData? byteData = await markerImage.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  Future<ui.Image> _loadNetworkImage(String path) async {
    final Completer<ImageInfo> completer = Completer();
    final NetworkImage image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener((info, _) => completer.complete(info)),
        );
    final ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  Set<Marker> _createMarkers() {
    return widget.memories.map((memory) {
      final isSelected = _selectedMemoryId == memory.id;
      return Marker(
        markerId: MarkerId(memory.id),
        position: LatLng(memory.latitude, memory.longitude),
        icon: isSelected
            ? (_selectedMarkerIcons[memory.id] ?? BitmapDescriptor.defaultMarker)
            : (_markerIcons[memory.id] ?? BitmapDescriptor.defaultMarker),
        zIndex: isSelected ? 1 : 0,
        onTap: () {
          _onMemorySelected(memory);
        },
      );
    }).toSet();
  }

  void _onMemorySelected(MemoryLocation memory) {
    setState(() {
      _selectedMemoryId = memory.id;
    });
    _showMemoryBottomSheet(context, memory);
  }

  void _showMemoryBottomSheet(BuildContext context, MemoryLocation memory) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => MemoryInfoBottomSheet(
        memory: memory,
        onViewDetail: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemoryDetailPage(memory: memory),
            ),
          );
        },
      ),
    );
    if (mounted) {
      setState(() {
        _selectedMemoryId = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: _currentMapType,
          initialCameraPosition: _initialPosition,
          markers: _createMarkers(),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton.small(
              onPressed: _onMapTypeButtonPressed,
              backgroundColor: Colors.white.withOpacity(0.9),
              child: Icon(
                _currentMapType == MapType.normal
                    ? Icons.satellite_alt
                    : Icons.map,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
