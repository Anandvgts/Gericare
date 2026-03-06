// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_symptoms_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opSymptomsControllerHash() =>
    r'b9b02aecc5686ce218200ed9e89015baca0dcff1';

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

abstract class _$OpSymptomsController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpSymptomsController].
@ProviderFor(OpSymptomsController)
const opSymptomsControllerProvider = OpSymptomsControllerFamily();

/// See also [OpSymptomsController].
class OpSymptomsControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpSymptomsController].
  const OpSymptomsControllerFamily();

  /// See also [OpSymptomsController].
  OpSymptomsControllerProvider call(
    String consultationId,
  ) {
    return OpSymptomsControllerProvider(
      consultationId,
    );
  }

  @override
  OpSymptomsControllerProvider getProviderOverride(
    covariant OpSymptomsControllerProvider provider,
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
  String? get name => r'opSymptomsControllerProvider';
}

/// See also [OpSymptomsController].
class OpSymptomsControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpSymptomsController, AsyncValue<void>> {
  /// See also [OpSymptomsController].
  OpSymptomsControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpSymptomsController()..consultationId = consultationId,
          from: opSymptomsControllerProvider,
          name: r'opSymptomsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opSymptomsControllerHash,
          dependencies: OpSymptomsControllerFamily._dependencies,
          allTransitiveDependencies:
              OpSymptomsControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpSymptomsControllerProvider._internal(
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
    covariant OpSymptomsController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpSymptomsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpSymptomsControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpSymptomsController, AsyncValue<void>>
      createElement() {
    return _OpSymptomsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpSymptomsControllerProvider &&
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
mixin OpSymptomsControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpSymptomsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpSymptomsController,
        AsyncValue<void>> with OpSymptomsControllerRef {
  _OpSymptomsControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpSymptomsControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
