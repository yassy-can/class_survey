// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$surveynotifierHash() => r'a2a80e56334a1fc19d53b7c5830b29c03c5b7f3b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Surveynotifier extends BuildlessNotifier<Survey> {
  late final String subjectName;

  Survey build({
    required String subjectName,
  });
}

/// See also [Surveynotifier].
@ProviderFor(Surveynotifier)
const surveynotifierProvider = SurveynotifierFamily();

/// See also [Surveynotifier].
class SurveynotifierFamily extends Family<Survey> {
  /// See also [Surveynotifier].
  const SurveynotifierFamily();

  /// See also [Surveynotifier].
  SurveynotifierProvider call({
    required String subjectName,
  }) {
    return SurveynotifierProvider(
      subjectName: subjectName,
    );
  }

  @override
  SurveynotifierProvider getProviderOverride(
    covariant SurveynotifierProvider provider,
  ) {
    return call(
      subjectName: provider.subjectName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'surveynotifierProvider';
}

/// See also [Surveynotifier].
class SurveynotifierProvider
    extends NotifierProviderImpl<Surveynotifier, Survey> {
  /// See also [Surveynotifier].
  SurveynotifierProvider({
    required String subjectName,
  }) : this._internal(
          () => Surveynotifier()..subjectName = subjectName,
          from: surveynotifierProvider,
          name: r'surveynotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$surveynotifierHash,
          dependencies: SurveynotifierFamily._dependencies,
          allTransitiveDependencies:
              SurveynotifierFamily._allTransitiveDependencies,
          subjectName: subjectName,
        );

  SurveynotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subjectName,
  }) : super.internal();

  final String subjectName;

  @override
  Survey runNotifierBuild(
    covariant Surveynotifier notifier,
  ) {
    return notifier.build(
      subjectName: subjectName,
    );
  }

  @override
  Override overrideWith(Surveynotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SurveynotifierProvider._internal(
        () => create()..subjectName = subjectName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subjectName: subjectName,
      ),
    );
  }

  @override
  NotifierProviderElement<Surveynotifier, Survey> createElement() {
    return _SurveynotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SurveynotifierProvider && other.subjectName == subjectName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subjectName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SurveynotifierRef on NotifierProviderRef<Survey> {
  /// The parameter `subjectName` of this provider.
  String get subjectName;
}

class _SurveynotifierProviderElement
    extends NotifierProviderElement<Surveynotifier, Survey>
    with SurveynotifierRef {
  _SurveynotifierProviderElement(super.provider);

  @override
  String get subjectName => (origin as SurveynotifierProvider).subjectName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
