// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_instructions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opInstructionsControllerHash() =>
    r'd31c705b6a43973f9983f3ebb16221ef5cc9fc7b';

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

abstract class _$OpInstructionsController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpInstructionsController].
@ProviderFor(OpInstructionsController)
const opInstructionsControllerProvider = OpInstructionsControllerFamily();

/// See also [OpInstructionsController].
class OpInstructionsControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpInstructionsController].
  const OpInstructionsControllerFamily();

  /// See also [OpInstructionsController].
  OpInstructionsControllerProvider call(
    String consultationId,
  ) {
    return OpInstructionsControllerProvider(
      consultationId,
    );
  }

  @override
  OpInstructionsControllerProvider getProviderOverride(
    covariant OpInstructionsControllerProvider provider,
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
  String? get name => r'opInstructionsControllerProvider';
}

/// See also [OpInstructionsController].
class OpInstructionsControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpInstructionsController, AsyncValue<void>> {
  /// See also [OpInstructionsController].
  OpInstructionsControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpInstructionsController()..consultationId = consultationId,
          from: opInstructionsControllerProvider,
          name: r'opInstructionsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opInstructionsControllerHash,
          dependencies: OpInstructionsControllerFamily._dependencies,
          allTransitiveDependencies:
              OpInstructionsControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpInstructionsControllerProvider._internal(
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
    covariant OpInstructionsController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpInstructionsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpInstructionsControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpInstructionsController, AsyncValue<void>>
      createElement() {
    return _OpInstructionsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpInstructionsControllerProvider &&
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
mixin OpInstructionsControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpInstructionsControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpInstructionsController,
        AsyncValue<void>> with OpInstructionsControllerRef {
  _OpInstructionsControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpInstructionsControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
