// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_findings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opFindingsControllerHash() =>
    r'b3242af19cb77d5c237e69c965753c92ab43a558';

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

abstract class _$OpFindingsController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpFindingsController].
@ProviderFor(OpFindingsController)
const opFindingsControllerProvider = OpFindingsControllerFamily();

/// See also [OpFindingsController].
class OpFindingsControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpFindingsController].
  const OpFindingsControllerFamily();

  /// See also [OpFindingsController].
  OpFindingsControllerProvider call(
    String consultationId,
  ) {
    return OpFindingsControllerProvider(
      consultationId,
    );
  }

  @override
  OpFindingsControllerProvider getProviderOverride(
    covariant OpFindingsControllerProvider provider,
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
  String? get name => r'opFindingsControllerProvider';
}

/// See also [OpFindingsController].
class OpFindingsControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpFindingsController, AsyncValue<void>> {
  /// See also [OpFindingsController].
  OpFindingsControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpFindingsController()..consultationId = consultationId,
          from: opFindingsControllerProvider,
          name: r'opFindingsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opFindingsControllerHash,
          dependencies: OpFindingsControllerFamily._dependencies,
          allTransitiveDependencies:
              OpFindingsControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpFindingsControllerProvider._internal(
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
    covariant OpFindingsController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpFindingsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpFindingsControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpFindingsController, AsyncValue<void>>
      createElement() {
    return _OpFindingsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpFindingsControllerProvider &&
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
mixin OpFindingsControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpFindingsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpFindingsController,
        AsyncValue<void>> with OpFindingsControllerRef {
  _OpFindingsControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpFindingsControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
