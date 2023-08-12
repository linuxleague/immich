//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SystemConfigJobDto {
  /// Returns a new [SystemConfigJobDto] instance.
  SystemConfigJobDto({
    required this.backgroundTask,
    required this.clipEncoding,
    required this.metadataExtraction,
    required this.objectTagging,
    required this.recognizeFaces,
    required this.search,
    required this.sidecar,
    required this.smartAlbum,
    required this.storageTemplateMigration,
    required this.thumbnailGeneration,
    required this.videoConversion,
  });

  JobSettingsDto backgroundTask;

  JobSettingsDto clipEncoding;

  JobSettingsDto metadataExtraction;

  JobSettingsDto objectTagging;

  JobSettingsDto recognizeFaces;

  JobSettingsDto search;

  JobSettingsDto sidecar;

  JobSettingsDto smartAlbum;

  JobSettingsDto storageTemplateMigration;

  JobSettingsDto thumbnailGeneration;

  JobSettingsDto videoConversion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SystemConfigJobDto &&
     other.backgroundTask == backgroundTask &&
     other.clipEncoding == clipEncoding &&
     other.metadataExtraction == metadataExtraction &&
     other.objectTagging == objectTagging &&
     other.recognizeFaces == recognizeFaces &&
     other.search == search &&
     other.sidecar == sidecar &&
     other.smartAlbum == smartAlbum &&
     other.storageTemplateMigration == storageTemplateMigration &&
     other.thumbnailGeneration == thumbnailGeneration &&
     other.videoConversion == videoConversion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (backgroundTask.hashCode) +
    (clipEncoding.hashCode) +
    (metadataExtraction.hashCode) +
    (objectTagging.hashCode) +
    (recognizeFaces.hashCode) +
    (search.hashCode) +
    (sidecar.hashCode) +
    (smartAlbum.hashCode) +
    (storageTemplateMigration.hashCode) +
    (thumbnailGeneration.hashCode) +
    (videoConversion.hashCode);

  @override
  String toString() => 'SystemConfigJobDto[backgroundTask=$backgroundTask, clipEncoding=$clipEncoding, metadataExtraction=$metadataExtraction, objectTagging=$objectTagging, recognizeFaces=$recognizeFaces, search=$search, sidecar=$sidecar, smartAlbum=$smartAlbum, storageTemplateMigration=$storageTemplateMigration, thumbnailGeneration=$thumbnailGeneration, videoConversion=$videoConversion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'backgroundTask'] = this.backgroundTask;
      json[r'clipEncoding'] = this.clipEncoding;
      json[r'metadataExtraction'] = this.metadataExtraction;
      json[r'objectTagging'] = this.objectTagging;
      json[r'recognizeFaces'] = this.recognizeFaces;
      json[r'search'] = this.search;
      json[r'sidecar'] = this.sidecar;
      json[r'smartAlbum'] = this.smartAlbum;
      json[r'storageTemplateMigration'] = this.storageTemplateMigration;
      json[r'thumbnailGeneration'] = this.thumbnailGeneration;
      json[r'videoConversion'] = this.videoConversion;
    return json;
  }

  /// Returns a new [SystemConfigJobDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SystemConfigJobDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      return SystemConfigJobDto(
        backgroundTask: JobSettingsDto.fromJson(json[r'backgroundTask'])!,
        clipEncoding: JobSettingsDto.fromJson(json[r'clipEncoding'])!,
        metadataExtraction: JobSettingsDto.fromJson(json[r'metadataExtraction'])!,
        objectTagging: JobSettingsDto.fromJson(json[r'objectTagging'])!,
        recognizeFaces: JobSettingsDto.fromJson(json[r'recognizeFaces'])!,
        search: JobSettingsDto.fromJson(json[r'search'])!,
        sidecar: JobSettingsDto.fromJson(json[r'sidecar'])!,
        smartAlbum: JobSettingsDto.fromJson(json[r'smartAlbum'])!,
        storageTemplateMigration: JobSettingsDto.fromJson(json[r'storageTemplateMigration'])!,
        thumbnailGeneration: JobSettingsDto.fromJson(json[r'thumbnailGeneration'])!,
        videoConversion: JobSettingsDto.fromJson(json[r'videoConversion'])!,
      );
    }
    return null;
  }

  static List<SystemConfigJobDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SystemConfigJobDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SystemConfigJobDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SystemConfigJobDto> mapFromJson(dynamic json) {
    final map = <String, SystemConfigJobDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SystemConfigJobDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SystemConfigJobDto-objects as value to a dart map
  static Map<String, List<SystemConfigJobDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SystemConfigJobDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SystemConfigJobDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'backgroundTask',
    'clipEncoding',
    'metadataExtraction',
    'objectTagging',
    'recognizeFaces',
    'search',
    'sidecar',
    'smartAlbum',
    'storageTemplateMigration',
    'thumbnailGeneration',
    'videoConversion',
  };
}

