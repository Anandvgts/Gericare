// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'al_consultation_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alConsultationRecordControllerHash() =>
    r'c36dca234728ead79aa6d9e3cc88e5b352a215a0';

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

abstract class _$AlConsultationRecordController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// See also [AlConsultationRecordController].
@ProviderFor(AlConsultationRecordController)
const alConsultationRecordControllerProvider =
    AlConsultationRecordControllerFamily();

/// See also [AlConsultationRecordController].
class AlConsultationRecordControllerFamily extends Family<AsyncValue<void>> {
  /// See also [AlConsultationRecordController].
  const AlConsultationRecordControllerFamily();

  /// See also [AlConsultationRecordController].
  AlConsultationRecordControllerProvider call(
    String patientId,
  ) {
    return AlConsultationRecordControllerProvider(
      patientId,
    );
  }

  @override
  AlConsultationRecordControllerProvider getProviderOverride(
    covariant AlConsultationRecordControllerProvider provider,
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
  String? get name => r'alConsultationRecordControllerProvider';
}

/// See also [AlConsultationRecordController].
class AlConsultationRecordControllerProvider
    extends AutoDisposeNotifierProviderImpl<AlConsultationRecordController,
        AsyncValue<void>> {
  /// See also [AlConsultationRecordController].
  AlConsultationRecordControllerProvider(
    String patientId,
  ) : this._internal(
          () => AlConsultationRecordController()..patientId = patientId,
          from: alConsultationRecordControllerProvider,
          name: r'alConsultationRecordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$alConsultationRecordControllerHash,
          dependencies: AlConsultationRecordControllerFamily._dependencies,
          allTransitiveDependencies:
              AlConsultationRecordControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  AlConsultationRecordControllerProvider._internal(
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
    covariant AlConsultationRecordController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(AlConsultationRecordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AlConsultationRecordControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<AlConsultationRecordController,
      AsyncValue<void>> createElement() {
    return _AlConsultationRecordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlConsultationRecordControllerProvider &&
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
mixin AlConsultationRecordControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _AlConsultationRecordControllerProviderElement
    extends AutoDisposeNotifierProviderElement<AlConsultationRecordController,
        AsyncValue<void>> with AlConsultationRecordControllerRef {
  _AlConsultationRecordControllerProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as AlConsultationRecordControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
