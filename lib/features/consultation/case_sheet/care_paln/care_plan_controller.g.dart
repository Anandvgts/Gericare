// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_plan_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$carePlanControllerHash() =>
    r'0c224cd865ade909ed9e736fba759ad441f9e1e0';

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

abstract class _$CarePlanController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [CarePlanController].
@ProviderFor(CarePlanController)
const carePlanControllerProvider = CarePlanControllerFamily();

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [CarePlanController].
class CarePlanControllerFamily extends Family<AsyncValue<void>> {
  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [CarePlanController].
  const CarePlanControllerFamily();

  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [CarePlanController].
  CarePlanControllerProvider call(
    String patientId,
  ) {
    return CarePlanControllerProvider(
      patientId,
    );
  }

  @override
  CarePlanControllerProvider getProviderOverride(
    covariant CarePlanControllerProvider provider,
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
  String? get name => r'carePlanControllerProvider';
}

/// ───────────── CONTROLLER ─────────────
///
/// Copied from [CarePlanController].
class CarePlanControllerProvider extends AutoDisposeNotifierProviderImpl<
    CarePlanController, AsyncValue<void>> {
  /// ───────────── CONTROLLER ─────────────
  ///
  /// Copied from [CarePlanController].
  CarePlanControllerProvider(
    String patientId,
  ) : this._internal(
          () => CarePlanController()..patientId = patientId,
          from: carePlanControllerProvider,
          name: r'carePlanControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$carePlanControllerHash,
          dependencies: CarePlanControllerFamily._dependencies,
          allTransitiveDependencies:
              CarePlanControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  CarePlanControllerProvider._internal(
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
    covariant CarePlanController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(CarePlanController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CarePlanControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<CarePlanController, AsyncValue<void>>
      createElement() {
    return _CarePlanControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CarePlanControllerProvider && other.patientId == patientId;
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
mixin CarePlanControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _CarePlanControllerProviderElement
    extends AutoDisposeNotifierProviderElement<CarePlanController,
        AsyncValue<void>> with CarePlanControllerRef {
  _CarePlanControllerProviderElement(super.provider);

  @override
  String get patientId => (origin as CarePlanControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
