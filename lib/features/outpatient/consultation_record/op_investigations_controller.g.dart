// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_investigations_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opInvestigationsControllerHash() =>
    r'0d019b23fa6d8bc596914a15ac459d35758ea505';

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

abstract class _$OpInvestigationsController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpInvestigationsController].
@ProviderFor(OpInvestigationsController)
const opInvestigationsControllerProvider = OpInvestigationsControllerFamily();

/// See also [OpInvestigationsController].
class OpInvestigationsControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpInvestigationsController].
  const OpInvestigationsControllerFamily();

  /// See also [OpInvestigationsController].
  OpInvestigationsControllerProvider call(
    String consultationId,
  ) {
    return OpInvestigationsControllerProvider(
      consultationId,
    );
  }

  @override
  OpInvestigationsControllerProvider getProviderOverride(
    covariant OpInvestigationsControllerProvider provider,
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
  String? get name => r'opInvestigationsControllerProvider';
}

/// See also [OpInvestigationsController].
class OpInvestigationsControllerProvider
    extends AutoDisposeNotifierProviderImpl<OpInvestigationsController,
        AsyncValue<void>> {
  /// See also [OpInvestigationsController].
  OpInvestigationsControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpInvestigationsController()..consultationId = consultationId,
          from: opInvestigationsControllerProvider,
          name: r'opInvestigationsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opInvestigationsControllerHash,
          dependencies: OpInvestigationsControllerFamily._dependencies,
          allTransitiveDependencies:
              OpInvestigationsControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpInvestigationsControllerProvider._internal(
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
    covariant OpInvestigationsController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpInvestigationsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpInvestigationsControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpInvestigationsController,
      AsyncValue<void>> createElement() {
    return _OpInvestigationsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpInvestigationsControllerProvider &&
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
mixin OpInvestigationsControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpInvestigationsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpInvestigationsController,
        AsyncValue<void>> with OpInvestigationsControllerRef {
  _OpInvestigationsControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpInvestigationsControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
