// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$incidentControllerHash() =>
    r'03b3f2fb0291cf4bd98916247f458d050305c8ea';

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

abstract class _$IncidentController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [IncidentController].
@ProviderFor(IncidentController)
const incidentControllerProvider = IncidentControllerFamily();

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [IncidentController].
class IncidentControllerFamily extends Family<AsyncValue<void>> {
  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [IncidentController].
  const IncidentControllerFamily();

  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [IncidentController].
  IncidentControllerProvider call(
    String patientId,
  ) {
    return IncidentControllerProvider(
      patientId,
    );
  }

  @override
  IncidentControllerProvider getProviderOverride(
    covariant IncidentControllerProvider provider,
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
  String? get name => r'incidentControllerProvider';
}

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [IncidentController].
class IncidentControllerProvider extends AutoDisposeNotifierProviderImpl<
    IncidentController, AsyncValue<void>> {
  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [IncidentController].
  IncidentControllerProvider(
    String patientId,
  ) : this._internal(
          () => IncidentController()..patientId = patientId,
          from: incidentControllerProvider,
          name: r'incidentControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$incidentControllerHash,
          dependencies: IncidentControllerFamily._dependencies,
          allTransitiveDependencies:
              IncidentControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  IncidentControllerProvider._internal(
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
    covariant IncidentController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(IncidentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: IncidentControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<IncidentController, AsyncValue<void>>
      createElement() {
    return _IncidentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IncidentControllerProvider && other.patientId == patientId;
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
mixin IncidentControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _IncidentControllerProviderElement
    extends AutoDisposeNotifierProviderElement<IncidentController,
        AsyncValue<void>> with IncidentControllerRef {
  _IncidentControllerProviderElement(super.provider);

  @override
  String get patientId => (origin as IncidentControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
