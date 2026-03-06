// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_vitals_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opVitalsControllerHash() =>
    r'919edd12c4117a754a2538844e23d19e10029854';

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

abstract class _$OpVitalsController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpVitalsController].
@ProviderFor(OpVitalsController)
const opVitalsControllerProvider = OpVitalsControllerFamily();

/// See also [OpVitalsController].
class OpVitalsControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpVitalsController].
  const OpVitalsControllerFamily();

  /// See also [OpVitalsController].
  OpVitalsControllerProvider call(
    String consultationId,
  ) {
    return OpVitalsControllerProvider(
      consultationId,
    );
  }

  @override
  OpVitalsControllerProvider getProviderOverride(
    covariant OpVitalsControllerProvider provider,
  ) {
    return call(
      provider.consultationId,
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
  String? get name => r'opVitalsControllerProvider';
}

/// See also [OpVitalsController].
class OpVitalsControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpVitalsController, AsyncValue<void>> {
  /// See also [OpVitalsController].
  OpVitalsControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpVitalsController()..consultationId = consultationId,
          from: opVitalsControllerProvider,
          name: r'opVitalsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opVitalsControllerHash,
          dependencies: OpVitalsControllerFamily._dependencies,
          allTransitiveDependencies:
              OpVitalsControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpVitalsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.consultationId,
  }) : super.internal();

  final String consultationId;

  @override
  AsyncValue<void> runNotifierBuild(
    covariant OpVitalsController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpVitalsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpVitalsControllerProvider._internal(
        () => create()..consultationId = consultationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        consultationId: consultationId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<OpVitalsController, AsyncValue<void>>
      createElement() {
    return _OpVitalsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpVitalsControllerProvider &&
        other.consultationId == consultationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, consultationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OpVitalsControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpVitalsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpVitalsController,
        AsyncValue<void>> with OpVitalsControllerRef {
  _OpVitalsControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpVitalsControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
