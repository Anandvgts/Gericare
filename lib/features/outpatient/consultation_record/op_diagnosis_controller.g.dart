// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_diagnosis_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opDiagnosisControllerHash() =>
    r'2e94802902c9a5b60e858ad6be1782faef0137a7';

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

abstract class _$OpDiagnosisController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpDiagnosisController].
@ProviderFor(OpDiagnosisController)
const opDiagnosisControllerProvider = OpDiagnosisControllerFamily();

/// See also [OpDiagnosisController].
class OpDiagnosisControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpDiagnosisController].
  const OpDiagnosisControllerFamily();

  /// See also [OpDiagnosisController].
  OpDiagnosisControllerProvider call(
    String consultationId,
  ) {
    return OpDiagnosisControllerProvider(
      consultationId,
    );
  }

  @override
  OpDiagnosisControllerProvider getProviderOverride(
    covariant OpDiagnosisControllerProvider provider,
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
  String? get name => r'opDiagnosisControllerProvider';
}

/// See also [OpDiagnosisController].
class OpDiagnosisControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpDiagnosisController, AsyncValue<void>> {
  /// See also [OpDiagnosisController].
  OpDiagnosisControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpDiagnosisController()..consultationId = consultationId,
          from: opDiagnosisControllerProvider,
          name: r'opDiagnosisControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opDiagnosisControllerHash,
          dependencies: OpDiagnosisControllerFamily._dependencies,
          allTransitiveDependencies:
              OpDiagnosisControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpDiagnosisControllerProvider._internal(
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
    covariant OpDiagnosisController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpDiagnosisController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpDiagnosisControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpDiagnosisController, AsyncValue<void>>
      createElement() {
    return _OpDiagnosisControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpDiagnosisControllerProvider &&
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
mixin OpDiagnosisControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpDiagnosisControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpDiagnosisController,
        AsyncValue<void>> with OpDiagnosisControllerRef {
  _OpDiagnosisControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpDiagnosisControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
