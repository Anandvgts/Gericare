// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifyOtpControllerHash() =>
    r'3166c160a324b0941ca41509f27f949abd516190';

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

abstract class _$VerifyOtpController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final VerifyOtpArguments args;

  AsyncValue<void> build(
    VerifyOtpArguments args,
  );
}

/// See also [VerifyOtpController].
@ProviderFor(VerifyOtpController)
const verifyOtpControllerProvider = VerifyOtpControllerFamily();

/// See also [VerifyOtpController].
class VerifyOtpControllerFamily extends Family<AsyncValue<void>> {
  /// See also [VerifyOtpController].
  const VerifyOtpControllerFamily();

  /// See also [VerifyOtpController].
  VerifyOtpControllerProvider call(
    VerifyOtpArguments args,
  ) {
    return VerifyOtpControllerProvider(
      args,
    );
  }

  @override
  VerifyOtpControllerProvider getProviderOverride(
    covariant VerifyOtpControllerProvider provider,
  ) {
    return call(
      provider.args,
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
  String? get name => r'verifyOtpControllerProvider';
}

/// See also [VerifyOtpController].
class VerifyOtpControllerProvider extends AutoDisposeNotifierProviderImpl<
    VerifyOtpController, AsyncValue<void>> {
  /// See also [VerifyOtpController].
  VerifyOtpControllerProvider(
    VerifyOtpArguments args,
  ) : this._internal(
          () => VerifyOtpController()..args = args,
          from: verifyOtpControllerProvider,
          name: r'verifyOtpControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$verifyOtpControllerHash,
          dependencies: VerifyOtpControllerFamily._dependencies,
          allTransitiveDependencies:
              VerifyOtpControllerFamily._allTransitiveDependencies,
          args: args,
        );

  VerifyOtpControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final VerifyOtpArguments args;

  @override
  AsyncValue<void> runNotifierBuild(
    covariant VerifyOtpController notifier,
  ) {
    return notifier.build(
      args,
    );
  }

  @override
  Override overrideWith(VerifyOtpController Function() create) {
    return ProviderOverride(
      origin: this,
      override: VerifyOtpControllerProvider._internal(
        () => create()..args = args,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<VerifyOtpController, AsyncValue<void>>
      createElement() {
    return _VerifyOtpControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VerifyOtpControllerProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VerifyOtpControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `args` of this provider.
  VerifyOtpArguments get args;
}

class _VerifyOtpControllerProviderElement
    extends AutoDisposeNotifierProviderElement<VerifyOtpController,
        AsyncValue<void>> with VerifyOtpControllerRef {
  _VerifyOtpControllerProviderElement(super.provider);

  @override
  VerifyOtpArguments get args => (origin as VerifyOtpControllerProvider).args;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
