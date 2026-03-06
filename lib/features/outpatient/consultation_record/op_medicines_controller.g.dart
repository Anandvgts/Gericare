// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_medicines_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opMedicinesControllerHash() =>
    r'95120d052dbac04289dffae8b5ad248facd41291';

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

abstract class _$OpMedicinesController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpMedicinesController].
@ProviderFor(OpMedicinesController)
const opMedicinesControllerProvider = OpMedicinesControllerFamily();

/// See also [OpMedicinesController].
class OpMedicinesControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpMedicinesController].
  const OpMedicinesControllerFamily();

  /// See also [OpMedicinesController].
  OpMedicinesControllerProvider call(
    String consultationId,
  ) {
    return OpMedicinesControllerProvider(
      consultationId,
    );
  }

  @override
  OpMedicinesControllerProvider getProviderOverride(
    covariant OpMedicinesControllerProvider provider,
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
  String? get name => r'opMedicinesControllerProvider';
}

/// See also [OpMedicinesController].
class OpMedicinesControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpMedicinesController, AsyncValue<void>> {
  /// See also [OpMedicinesController].
  OpMedicinesControllerProvider(
    String consultationId,
  ) : this._internal(
          () => OpMedicinesController()..consultationId = consultationId,
          from: opMedicinesControllerProvider,
          name: r'opMedicinesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opMedicinesControllerHash,
          dependencies: OpMedicinesControllerFamily._dependencies,
          allTransitiveDependencies:
              OpMedicinesControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpMedicinesControllerProvider._internal(
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
    covariant OpMedicinesController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpMedicinesController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpMedicinesControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpMedicinesController, AsyncValue<void>>
      createElement() {
    return _OpMedicinesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpMedicinesControllerProvider &&
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
mixin OpMedicinesControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpMedicinesControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpMedicinesController,
        AsyncValue<void>> with OpMedicinesControllerRef {
  _OpMedicinesControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpMedicinesControllerProvider).consultationId;
}

String _$opMedicineDosageControllerHash() =>
    r'e0a6adcea1b0701618799dd3be93a9973d47cd98';

/// See also [OpMedicineDosageController].
@ProviderFor(OpMedicineDosageController)
final opMedicineDosageControllerProvider = AutoDisposeNotifierProvider<
    OpMedicineDosageController, AsyncValue<void>>.internal(
  OpMedicineDosageController.new,
  name: r'opMedicineDosageControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$opMedicineDosageControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OpMedicineDosageController = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
