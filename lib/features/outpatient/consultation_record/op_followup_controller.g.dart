// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_followup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opFollowupControllerHash() =>
    r'5401fe1c42002824d922193aecbc1ba04c358edc';

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

abstract class _$OpFollowupController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpFollowupController].
@ProviderFor(OpFollowupController)
const opFollowupControllerProvider = OpFollowupControllerFamily();

/// See also [OpFollowupController].
class OpFollowupControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpFollowupController].
  const OpFollowupControllerFamily();

  /// See also [OpFollowupController].
  OpFollowupControllerProvider call(
    String consultationId,
  ) {
    return OpFollowupControllerProvider(
      consultationId,
    );
  }

  @override
  OpFollowupControllerProvider getProviderOverride(
    covariant OpFollowupControllerProvider provider,
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
  String? get name => r'opFollowupControllerProvider';
}

/// See also [OpFollowupController].
class OpFollowupControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpFollowupController, AsyncValue<void>> {
  /// See also [OpFollowupController].
  OpFollowupControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpFollowupController()..consultationId = consultationId,
          from: opFollowupControllerProvider,
          name: r'opFollowupControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opFollowupControllerHash,
          dependencies: OpFollowupControllerFamily._dependencies,
          allTransitiveDependencies:
              OpFollowupControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpFollowupControllerProvider._internal(
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
    covariant OpFollowupController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpFollowupController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpFollowupControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpFollowupController, AsyncValue<void>>
      createElement() {
    return _OpFollowupControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpFollowupControllerProvider &&
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
mixin OpFollowupControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpFollowupControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpFollowupController,
        AsyncValue<void>> with OpFollowupControllerRef {
  _OpFollowupControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpFollowupControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
