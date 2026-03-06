// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_consultation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opConsultationControllerHash() =>
    r'b5877e105a4b732b9565aaf019783fb30776bf99';

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

abstract class _$OpConsultationController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final PatientSchedule schedule;

  AsyncValue<void> build(
    PatientSchedule schedule,
  );
}

/// See also [OpConsultationController].
@ProviderFor(OpConsultationController)
const opConsultationControllerProvider = OpConsultationControllerFamily();

/// See also [OpConsultationController].
class OpConsultationControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpConsultationController].
  const OpConsultationControllerFamily();

  /// See also [OpConsultationController].
  OpConsultationControllerProvider call(
    PatientSchedule schedule,
  ) {
    return OpConsultationControllerProvider(
      schedule,
    );
  }

  @override
  OpConsultationControllerProvider getProviderOverride(
    covariant OpConsultationControllerProvider provider,
  ) {
    return call(
      provider.schedule,
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
  String? get name => r'opConsultationControllerProvider';
}

/// See also [OpConsultationController].
class OpConsultationControllerProvider extends AutoDisposeNotifierProviderImpl<
    OpConsultationController, AsyncValue<void>> {
  /// See also [OpConsultationController].
  OpConsultationControllerProvider(
    PatientSchedule schedule,
  ) : this._internal(
          () => OpConsultationController()..schedule = schedule,
          from: opConsultationControllerProvider,
          name: r'opConsultationControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opConsultationControllerHash,
          dependencies: OpConsultationControllerFamily._dependencies,
          allTransitiveDependencies:
              OpConsultationControllerFamily._allTransitiveDependencies,
          schedule: schedule,
        );

  OpConsultationControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.schedule,
  }) : super.internal();

  final PatientSchedule schedule;

  @override
  AsyncValue<void> runNotifierBuild(
    covariant OpConsultationController notifier,
  ) {
    return notifier.build(
      schedule,
    );
  }

  @override
  Override overrideWith(OpConsultationController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpConsultationControllerProvider._internal(
        () => create()..schedule = schedule,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        schedule: schedule,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<OpConsultationController, AsyncValue<void>>
      createElement() {
    return _OpConsultationControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpConsultationControllerProvider &&
        other.schedule == schedule;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, schedule.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OpConsultationControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `schedule` of this provider.
  PatientSchedule get schedule;
}

class _OpConsultationControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpConsultationController,
        AsyncValue<void>> with OpConsultationControllerRef {
  _OpConsultationControllerProviderElement(super.provider);

  @override
  PatientSchedule get schedule =>
      (origin as OpConsultationControllerProvider).schedule;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
