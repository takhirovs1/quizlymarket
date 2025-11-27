// ignore_for_file: avoid_print
import 'dart:io';

int _newGeneratedVecFilesCount = 0, _existingVecFilesCount = 0, _errorOccurredFilesCount = 0;

void main(List<String> args) async {
  // To determine run time
  final sw = Stopwatch()..start();

  'Creating vector graphic files started...'._printInfo;

  /// Variables
  const vectorFileName = 'vectors';
  final assetsDirectory = Directory('assets/');
  final vecDirectory = Directory('assets/$vectorFileName');

  // Delete existing vector graphic files if regeneration is required
  if ((args.length == 1 && (args[0] == 'true' || args[0] == 't')) && vecDirectory.existsSync()) {
    'assets/vectors directory has been deleted for regeneration...'._printInfo;
    vecDirectory.deleteSync(recursive: true);
  }

  // Check whether assets directory exists
  if (!assetsDirectory.existsSync()) {
    return print('The assets directory does not exists.');
  }

  'Searching .svg files from all\x1B[38;2;220;202;109m assets\x1B[0m directory...'._printInfo;

  // Check whether [vectorFileName] directory exists
  // If does not exists, create new one
  if (!vecDirectory.existsSync()) vecDirectory.createSync(recursive: true);

  // Get all SVG files from assets directories
  final svgFiles = await _getSvgFiles(dir: assetsDirectory);

  // Existing VecFiles without extension. Just basename e.g.:
  // If a file path is 'assets/vectors/icon.vec'
  // path.basenameWithoutExtension() would return 'icon'
  final existingVecFiles = Set<String>.from(
    vecDirectory.listSync().map((e) => e.path.split('.').firstOrNull?.split('/').last),
  );

  // List to store all vector compilation futures
  final vectorGeneratorFutureFunctions = <Future<void>>[];

  'Processing files...'._printInfo;

  // Iterate through all SVG files
  for (final file in svgFiles) {
    final inputFile = file.path;
    final baseName = inputFile.split('.').firstOrNull?.split('/').last;
    final outputFile = '${vecDirectory.path}/$baseName.vec';

    // Skipping if the .vec file already exists
    if (existingVecFiles.contains(baseName)) {
      _existingVecFilesCount++;
      continue;
    }

    vectorGeneratorFutureFunctions.add(_compileVector(inputFile: inputFile, outputFile: outputFile));
  }

  // Compiling all vector files concurrently using Future.wait()
  await Future.wait(vectorGeneratorFutureFunctions);

  '$_existingVecFilesCount existing vector files found and they are skipped'._printInfo;
  '$_errorOccurredFilesCount files failed to compile'._printInfo;
  '$_newGeneratedVecFilesCount new .vec files has been generated'._printInfo;

  // Printing info that with took time
  'All files processed, took: ${(sw.elapsedMilliseconds / 1000).toStringAsFixed(1)}s\n'._printInfo;
}

/// Retrieves all SVG files from the given directory and including its subdirectories
///
/// Returns a list of file which contains SVG files
Future<List<File>> _getSvgFiles({required Directory dir}) async {
  final svgFiles = <File>[];

  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.toLowerCase().endsWith('.svg')) {
      svgFiles.add(entity);
    }
  }

  return svgFiles;
}

/// Compiles an SVG file into a VEC file
///
/// [inputFile] The path to the input SVG file
/// [outputFile] The path where the output VEC file should be saved
Future<void> _compileVector({required String inputFile, required String outputFile}) async {
  final result = await Process.run('dart', ['run', 'vector_graphics_compiler', '-i', inputFile, '-o', outputFile]);

  // Print the result of the compilation process
  if (result.exitCode == 0) {
    _newGeneratedVecFilesCount++;
  } else {
    _errorOccurredFilesCount++;
    print('❌ Failed to generate $outputFile. Error: ${result.stderr}');
  }
}

/// [INFO] printer with color
extension _PrinterX on String {
  void get _printInfo => print('\x1B[38;2;70;198;178m[INFO]\x1B[0m $this');
}
