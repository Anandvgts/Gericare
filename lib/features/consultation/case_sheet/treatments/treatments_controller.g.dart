// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$treatmentsControllerHash() =>
    r'1136c61cb4d91632d47f78f319e86a566c33469a';

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

abstract class _$TreatmentsController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [TreatmentsController].
@ProviderFor(TreatmentsController)
const treatmentsControllerProvider = TreatmentsControllerFamily();

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [TreatmentsController].
class TreatmentsControllerFamily extends Family<AsyncValue<void>> {
  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [TreatmentsController].
  const TreatmentsControllerFamily();

  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [TreatmentsController].
  TreatmentsControllerProvider call(
    String patientId,
  ) {
    return TreatmentsControllerProvider(
      patientId,
    );
  }

  @override
  TreatmentsControllerProvider getProviderOverride(
    covariant TreatmentsControllerProvider provider,
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
  String? get name => r'treatmentsControllerProvider';
}

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [TreatmentsController].
class TreatmentsControllerProvider extends AutoDisposeNotifierProviderImpl<
    TreatmentsController, AsyncValue<void>> {
  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [TreatmentsController].
  TreatmentsControllerProvider(
    String patientId,
  ) : this._internal(
          () => TreatmentsController()..patientId = patientId,
          from: treatmentsControllerProvider,
          name: r'treatmentsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$treatmentsControllerHash,
          dependencies: TreatmentsControllerFamily._dependencies,
          allTransitiveDependencies:
              TreatmentsControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  TreatmentsControllerProvider._internal(
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
    covariant TreatmentsController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(TreatmentsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TreatmentsControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<TreatmentsController, AsyncValue<void>>
      createElement() {
    return _TreatmentsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TreatmentsControllerProvider &&
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
mixin TreatmentsControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _TreatmentsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TreatmentsController,
        AsyncValue<void>> with TreatmentsControllerRef {
  _TreatmentsControllerProviderElement(super.provider);

  @override
  String get patientId => (origin as TreatmentsControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
