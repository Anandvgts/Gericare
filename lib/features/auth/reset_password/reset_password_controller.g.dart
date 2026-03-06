// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resetPasswordControllerHash() =>
    r'b6d3b2becc29994d61ce233840a6d8ba46f6b3d5';

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

abstract class _$ResetPasswordController
    extends BuildlessAutoDisposeNotifier<AsyncValue<void>> {
  late final ResetPasswordArguments args;

  AsyncValue<void> build(
    ResetPasswordArguments args,
  );
}

/// See also [ResetPasswordController].
@ProviderFor(ResetPasswordController)
const resetPasswordControllerProvider = ResetPasswordControllerFamily();

/// See also [ResetPasswordController].
class ResetPasswordControllerFamily extends Family<AsyncValue<void>> {
  /// See also [ResetPasswordController].
  const ResetPasswordControllerFamily();

  /// See also [ResetPasswordController].
  ResetPasswordControllerProvider call(
    ResetPasswordArguments args,
  ) {
    return ResetPasswordControllerProvider(
      args,
    );
  }

  @override
  ResetPasswordControllerProvider getProviderOverride(
    covariant ResetPasswordControllerProvider provider,
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
  String? get name => r'resetPasswordControllerProvider';
}

/// See also [ResetPasswordController].
class ResetPasswordControllerProvider extends AutoDisposeNotifierProviderImpl<
    ResetPasswordController, AsyncValue<void>> {
  /// See also [ResetPasswordController].
  ResetPasswordControllerProvider(
    ResetPasswordArguments args,
  ) : this._internal(
          () => ResetPasswordController()..args = args,
          from: resetPasswordControllerProvider,
          name: r'resetPasswordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$resetPasswordControllerHash,
          dependencies: ResetPasswordControllerFamily._dependencies,
          allTransitiveDependencies:
              ResetPasswordControllerFamily._allTransitiveDependencies,
          args: args,
        );

  ResetPasswordControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final ResetPasswordArguments args;

  @override
  AsyncValue<void> runNotifierBuild(
    covariant ResetPasswordController notifier,
  ) {
    return notifier.build(
      args,
    );
  }

  @override
  Override overrideWith(ResetPasswordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ResetPasswordControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<ResetPasswordController, AsyncValue<void>>
      createElement() {
    return _ResetPasswordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResetPasswordControllerProvider && other.args == args;
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
mixin ResetPasswordControllerRef
    on AutoDisposeNotifierProviderRef<AsyncValue<void>> {
  /// The parameter `args` of this provider.
  ResetPasswordArguments get args;
}

class _ResetPasswordControllerProviderElement
    extends AutoDisposeNotifierProviderElement<ResetPasswordController,
        AsyncValue<void>> with ResetPasswordControllerRef {
  _ResetPasswordControllerProviderElement(super.provider);

  @override
  ResetPasswordArguments get args =>
      (origin as ResetPasswordControllerProvider).args;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
