// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'op_consultation_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opConsultationReportControllerHash() =>
    r'd2e9bad2c7c781a863d5ea2a229c1a58fe92d426';

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

abstract class _$OpConsultationReportController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String consultationId;

  AsyncValue<void> build(
    String consultationId,
  );
}

/// See also [OpConsultationReportController].
@ProviderFor(OpConsultationReportController)
const opConsultationReportControllerProvider =
    OpConsultationReportControllerFamily();

/// See also [OpConsultationReportController].
class OpConsultationReportControllerFamily extends Family<AsyncValue<void>> {
  /// See also [OpConsultationReportController].
  const OpConsultationReportControllerFamily();

  /// See also [OpConsultationReportController].
  OpConsultationReportControllerProvider call(
    String consultationId,
  ) {
    return OpConsultationReportControllerProvider(
      consultationId,
    );
  }

  @override
  OpConsultationReportControllerProvider getProviderOverride(
    covariant OpConsultationReportControllerProvider provider,
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
  String? get name => r'opConsultationReportControllerProvider';
}

/// See also [OpConsultationReportController].
class OpConsultationReportControllerProvider
    extends AutoDisposeNotifierProviderImpl<OpConsultationReportController,
        AsyncValue<void>> {
  /// See also [OpConsultationReportController].
  OpConsultationReportControllerProvider(
    String consultationId,
  ) : this._internal(
          () =>
              OpConsultationReportController()..consultationId = consultationId,
          from: opConsultationReportControllerProvider,
          name: r'opConsultationReportControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$opConsultationReportControllerHash,
          dependencies: OpConsultationReportControllerFamily._dependencies,
          allTransitiveDependencies:
              OpConsultationReportControllerFamily._allTransitiveDependencies,
          consultationId: consultationId,
        );

  OpConsultationReportControllerProvider._internal(
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
    covariant OpConsultationReportController notifier,
  ) {
    return notifier.build(
      consultationId,
    );
  }

  @override
  Override overrideWith(OpConsultationReportController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpConsultationReportControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<OpConsultationReportController,
      AsyncValue<void>> createElement() {
    return _OpConsultationReportControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpConsultationReportControllerProvider &&
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
mixin OpConsultationReportControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `consultationId` of this provider.
  String get consultationId;
}

class _OpConsultationReportControllerProviderElement
    extends AutoDisposeNotifierProviderElement<OpConsultationReportController,
        AsyncValue<void>> with OpConsultationReportControllerRef {
  _OpConsultationReportControllerProviderElement(super.provider);

  @override
  String get consultationId =>
      (origin as OpConsultationReportControllerProvider).consultationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
