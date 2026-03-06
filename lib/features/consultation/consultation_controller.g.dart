// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$consultationControllerHash() =>
    r'76c94cd5927f1354d89f7b41ef787320d28bbd7c';

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

abstract class _$ConsultationController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// See also [ConsultationController].
@ProviderFor(ConsultationController)
const consultationControllerProvider = ConsultationControllerFamily();

/// See also [ConsultationController].
class ConsultationControllerFamily extends Family<AsyncValue<void>> {
  /// See also [ConsultationController].
  const ConsultationControllerFamily();

  /// See also [ConsultationController].
  ConsultationControllerProvider call(
    String patientId,
  ) {
    return ConsultationControllerProvider(
      patientId,
    );
  }

  @override
  ConsultationControllerProvider getProviderOverride(
    covariant ConsultationControllerProvider provider,
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
  String? get name => r'consultationControllerProvider';
}

/// See also [ConsultationController].
class ConsultationControllerProvider extends AutoDisposeNotifierProviderImpl<
    ConsultationController, AsyncValue<void>> {
  /// See also [ConsultationController].
  ConsultationControllerProvider(
    String patientId,
  ) : this._internal(
          () => ConsultationController()..patientId = patientId,
          from: consultationControllerProvider,
          name: r'consultationControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$consultationControllerHash,
          dependencies: ConsultationControllerFamily._dependencies,
          allTransitiveDependencies:
              ConsultationControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  ConsultationControllerProvider._internal(
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
    covariant ConsultationController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(ConsultationController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConsultationControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<ConsultationController, AsyncValue<void>>
      createElement() {
    return _ConsultationControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConsultationControllerProvider &&
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
mixin ConsultationControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _ConsultationControllerProviderElement
    extends AutoDisposeNotifierProviderElement<ConsultationController,
        AsyncValue<void>> with ConsultationControllerRef {
  _ConsultationControllerProviderElement(super.provider);

  @override
  String get patientId => (origin as ConsultationControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
