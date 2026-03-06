// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_procedures_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opProceduresControllerHash() =>
    r'e74db305910af7a9814396de86b8e8c1c8fa0986';

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

abstract class _$OpProceduresController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpProceduresController].
@ProviderFor(OpProceduresController)
const opProceduresControllerProvider = OpProceduresControllerFamily();

/// See also [OpProceduresController].
class OpProceduresControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpProceduresController].
  const OpProceduresControllerFamily();

  /// See also [OpProceduresController].
  OpProceduresControllerProvider call(
    String consultationId,
  ) {
    return OpProceduresControllerProvider(
      consultationId,
    );
  }

  @override
  OpProceduresControllerProvider getProviderOverride(
    covariant OpProceduresControllerProvider provider,
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
  String? get name => r'opProceduresControllerProvider';
}

/// See also [OpProceduresController].
class OpProceduresControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpProceduresController, AsyncValue<void>> {
  /// See also [OpProceduresController].
  OpProceduresControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpProceduresController()..consultationId = consultationId,
          from: opProceduresControllerProvider,
          name: r'opProceduresControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opProceduresControllerHash,
          dependencies: OpProceduresControllerFamily._dependencies,
          allTransitiveDependencies:
              OpProceduresControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpProceduresControllerProvider._internal(
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
    covariant OpProceduresController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpProceduresController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpProceduresControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpProceduresController, AsyncValue<void>>
      createElement() {
    return _OpProceduresControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpProceduresControllerProvider &&
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
mixin OpProceduresControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpProceduresControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpProceduresController,
        AsyncValue<void>> with OpProceduresControllerRef {
  _OpProceduresControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpProceduresControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
