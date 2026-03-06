// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_consultation_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opConsultationDetailControllerHash() =>
    r'6ffefa73ab594db1d710df4a44fe3263e210ebdb';

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

abstract class _$OpConsultationDetailController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final OpConsultation consultation;

  AsyncValue<void> build(
    OpConsultation consultation,
  );
}

/// See also [OpConsultationDetailController].
@ProviderFor(OpConsultationDetailController)
const opConsultationDetailControllerProvider =
    OpConsultationDetailControllerFamily();

/// See also [OpConsultationDetailController].
class OpConsultationDetailControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpConsultationDetailController].
  const OpConsultationDetailControllerFamily();

  /// See also [OpConsultationDetailController].
  OpConsultationDetailControllerProvider call(
    OpConsultation consultation,
  ) {
    return OpConsultationDetailControllerProvider(
      consultation,
    );
  }

  @override
  OpConsultationDetailControllerProvider getProviderOverride(
    covariant OpConsultationDetailControllerProvider provider,
  ) {
    return call(
      provider.consultation,
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
  String? get name => r'opConsultationDetailControllerProvider';
}

/// See also [OpConsultationDetailController].
class OpConsultationDetailControllerProvider
    extends AutoDisposeNotifierProviderImpl<OpConsultationDetailController,
        AsyncValue<void>> {
  /// See also [OpConsultationDetailController].
  OpConsultationDetailControllerProvider(
    OpConsultation consultation,
  ) : this._internal(
          () => OpConsultationDetailController()..consultation = consultation,
          from: opConsultationDetailControllerProvider,
          name: r'opConsultationDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opConsultationDetailControllerHash,
          dependencies: OpConsultationDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              OpConsultationDetailControllerFamily._allTransitiveDependencies,
          consultation: consultation,
        );

  OpConsultationDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.consultation,
  }) : super.internal();

  final OpConsultation consultation;

  @override
  AsyncValue<void> runNotifierBuild(
    covariant OpConsultationDetailController notifier,
  ) {
    return notifier.build(
      consultation,
    );
  }

  @override
  Override overrideWith(OpConsultationDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpConsultationDetailControllerProvider._internal(
        () => create()..consultation = consultation,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        consultation: consultation,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<OpConsultationDetailController,
      AsyncValue<void>> createElement() {
    return _OpConsultationDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpConsultationDetailControllerProvider &&
        other.consultation == consultation;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, consultation.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OpConsultationDetailControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultation` of this provider.
  OpConsultation get consultation;
}

class _OpConsultationDetailControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpConsultationDetailController,
        AsyncValue<void>> with OpConsultationDetailControllerRef {
  _OpConsultationDetailControllerProviderElement(super.provider);

  @override
  OpConsultation get consultation =>
      (origin as OpConsultationDetailControllerProvider).consultation;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
