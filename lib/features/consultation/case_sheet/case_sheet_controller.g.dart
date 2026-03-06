// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_sheet_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$caseSheetControllerHash() =>
    r'62d09ed4eabfbb7476bafb7623f46329ba905475';

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

abstract class _$CaseSheetController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final String patientId;

  AsyncValue<void> build(
    String patientId,
  );
}

/// See also [CaseSheetController].
@ProviderFor(CaseSheetController)
const caseSheetControllerProvider = CaseSheetControllerFamily();

/// See also [CaseSheetController].
class CaseSheetControllerFamily extends Family<AsyncValue<void>> {
  /// See also [CaseSheetController].
  const CaseSheetControllerFamily();

  /// See also [CaseSheetController].
  CaseSheetControllerProvider call(
    String patientId,
  ) {
    return CaseSheetControllerProvider(
      patientId,
    );
  }

  @override
  CaseSheetControllerProvider getProviderOverride(
    covariant CaseSheetControllerProvider provider,
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
  String? get name => r'caseSheetControllerProvider';
}

/// See also [CaseSheetController].
class CaseSheetControllerProvider extends AutoDisposeNotifierProviderImpl<
    CaseSheetController, AsyncValue<void>> {
  /// See also [CaseSheetController].
  CaseSheetControllerProvider(
    String patientId,
  ) : this._internal(
          () => CaseSheetController()..patientId = patientId,
          from: caseSheetControllerProvider,
          name: r'caseSheetControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$caseSheetControllerHash,
          dependencies: CaseSheetControllerFamily._dependencies,
          allTransitiveDependencies:
              CaseSheetControllerFamily._allTransitiveDependencies,
          patientId: patientId,
        );

  CaseSheetControllerProvider._internal(
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
    covariant CaseSheetController notifier,
  ) {
    return notifier.build(
      patientId,
    );
  }

  @override
  Override overrideWith(CaseSheetController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CaseSheetControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<CaseSheetController, AsyncValue<void>>
      createElement() {
    return _CaseSheetControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CaseSheetControllerProvider && other.patientId == patientId;
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
mixin CaseSheetControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _CaseSheetControllerProviderElement
    extends AutoDisposeNotifierProviderElement<CaseSheetController,
        AsyncValue<void>> with CaseSheetControllerRef {
  _CaseSheetControllerProviderElement(super.provider);

  @override
  String get patientId => (origin as CaseSheetControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
