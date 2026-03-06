// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultation_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$consultationHistoryControllerHash() =>
    r'5e32d342b097ad275926bc7c42dd93949cfbf957';

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

abstract class _$ConsultationHistoryController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// See also [ConsultationHistoryController].
@ProviderFor(ConsultationHistoryController)
const consultationHistoryControllerProvider =
    ConsultationHistoryControllerFamily();

/// See also [ConsultationHistoryController].
class ConsultationHistoryControllerFamily extends Family<AsyncValue<void>> {
  /// See also [ConsultationHistoryController].
  const ConsultationHistoryControllerFamily();

  /// See also [ConsultationHistoryController].
  ConsultationHistoryControllerProvider call(
    String patientId,
  ) {
    return ConsultationHistoryControllerProvider(
      patientId,
    );
  }

  @override
  ConsultationHistoryControllerProvider getProviderOverride(
    covariant ConsultationHistoryControllerProvider provider,
  ) {
    return call(
      provider.patientId,
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
  String? get name => r'consultationHistoryControllerProvider';
}

/// See also [ConsultationHistoryController].
class ConsultationHistoryControllerProvider
    extends AutoDisposeNotifierProviderImpl<ConsultationHistoryController,
        AsyncValue<void>> {
  /// See also [ConsultationHistoryController].
  ConsultationHistoryControllerProvider(
    String patientId,
  ) : this._internal(
          () => ConsultationHistoryController()..patientId = patientId,
          from: consultationHistoryControllerProvider,
          name: r'consultationHistoryControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$consultationHistoryControllerHash,
          dependencies: ConsultationHistoryControllerFamily._dependencies,
          allTransitiveDependencies:
              ConsultationHistoryControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  ConsultationHistoryControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
  }) : super.internal();

  final String patientId;

  @override
  AsyncValue<void> runNotifierBuild(
    covariant ConsultationHistoryController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(ConsultationHistoryController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConsultationHistoryControllerProvider._internal(
        () => create()..patientId = patientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ConsultationHistoryController,
      AsyncValue<void>> createElement() {
    return _ConsultationHistoryControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConsultationHistoryControllerProvider &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ConsultationHistoryControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _ConsultationHistoryControllerProviderElement
    extends AutoDisposeNotifierProviderElement<ConsultationHistoryController,
        AsyncValue<void>> with ConsultationHistoryControllerRef {
  _ConsultationHistoryControllerProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as ConsultationHistoryControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
