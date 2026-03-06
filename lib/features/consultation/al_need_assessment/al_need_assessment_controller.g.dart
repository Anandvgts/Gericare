// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'al_need_assessment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alNeedAssessmentControllerHash() =>
    r'4d26156ee2b69a15fee49ea3feaf5585278982a9';

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

abstract class _$AlNeedAssessmentController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// See also [AlNeedAssessmentController].
@ProviderFor(AlNeedAssessmentController)
const alNeedAssessmentControllerProvider = AlNeedAssessmentControllerFamily();

/// See also [AlNeedAssessmentController].
class AlNeedAssessmentControllerFamily extends Family<AsyncValue<void>> {
  /// See also [AlNeedAssessmentController].
  const AlNeedAssessmentControllerFamily();

  /// See also [AlNeedAssessmentController].
  AlNeedAssessmentControllerProvider call(
    String patientId,
  ) {
    return AlNeedAssessmentControllerProvider(
      patientId,
    );
  }

  @override
  AlNeedAssessmentControllerProvider getProviderOverride(
    covariant AlNeedAssessmentControllerProvider provider,
  ) {
    return call(
      provider.patientId,
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
  String? get name => r'alNeedAssessmentControllerProvider';
}

/// See also [AlNeedAssessmentController].
class AlNeedAssessmentControllerProvider
    extends AutoDisposeNotifierProviderImpl<AlNeedAssessmentController,
        AsyncValue<void>> {
  /// See also [AlNeedAssessmentController].
  AlNeedAssessmentControllerProvider(
    String patientId,
  ) : this._internal(
          () => AlNeedAssessmentController()..patientId = patientId,
          from: alNeedAssessmentControllerProvider,
          name: r'alNeedAssessmentControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$alNeedAssessmentControllerHash,
          dependencies: AlNeedAssessmentControllerFamily._dependencies,
          allTransitiveDependencies:
              AlNeedAssessmentControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  AlNeedAssessmentControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
  }) : super.internal();

  final String patientId;

  @override
  AsyncValue<void> runNotifierBuild(
    covariant AlNeedAssessmentController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(AlNeedAssessmentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AlNeedAssessmentControllerProvider._internal(
        () => create()..patientId = patientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AlNeedAssessmentController,
      AsyncValue<void>> createElement() {
    return _AlNeedAssessmentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlNeedAssessmentControllerProvider &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AlNeedAssessmentControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _AlNeedAssessmentControllerProviderElement
    extends AutoDisposeNotifierProviderElement<AlNeedAssessmentController,
        AsyncValue<void>> with AlNeedAssessmentControllerRef {
  _AlNeedAssessmentControllerProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as AlNeedAssessmentControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
