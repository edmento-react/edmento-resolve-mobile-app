// lib/core/security/security_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SecurityThreat {
  appIntegrity,
  obfuscationIssues,
  debug,
  deviceBinding,
  deviceId,
  hooks,
  passcodeMissing,
  privilegedAccess,
  noSecureHardware,
  emulatorOrSimulator,
  systemVpn,
  devMode,
  adbEnabled,
  unofficialStore,
  screenshot,
  screenRecording,
  multiInstance,
}

String threatLabel(SecurityThreat t) {
  switch (t) {
    case SecurityThreat.appIntegrity:
      return 'APP_INTEGRITY';
    case SecurityThreat.obfuscationIssues:
      return 'OBFUSCATION_ISSUES';
    case SecurityThreat.debug:
      return 'DEBUGGER_ATTACHED';
    case SecurityThreat.deviceBinding:
      return 'DEVICE_BINDING';
    case SecurityThreat.deviceId:
      return 'DEVICE_ID';
    case SecurityThreat.hooks:
      return 'HOOKS_DETECTED';
    case SecurityThreat.passcodeMissing:
      return 'PASSCODE_MISSING';
    case SecurityThreat.privilegedAccess:
      return 'ROOT/JAILBREAK';
    case SecurityThreat.noSecureHardware:
      return 'NO_SECURE_HARDWARE';
    case SecurityThreat.emulatorOrSimulator:
      return 'EMULATOR/SIMULATOR';
    case SecurityThreat.systemVpn:
      return 'SYSTEM_VPN';
    case SecurityThreat.devMode:
      return 'DEV_MODE';
    case SecurityThreat.adbEnabled:
      return 'ADB_ENABLED';
    case SecurityThreat.unofficialStore:
      return 'UNOFFICIAL_STORE';
    case SecurityThreat.screenshot:
      return 'SCREENSHOT';
    case SecurityThreat.screenRecording:
      return 'SCREEN_RECORDING';
    case SecurityThreat.multiInstance:
      return 'MULTI_INSTANCE';
  }
}

class SecurityState extends Equatable {
  final Set<SecurityThreat> active;
  const SecurityState(this.active);

  @override
  List<Object?> get props => [active];
}

class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit() : super(const SecurityState({}));

  void add(SecurityThreat t) {
    if (!state.active.contains(t)) {
      print('[SECURITY] + ${threatLabel(t)}');
      final next = {...state.active, t};
      emit(SecurityState(next));
    } else {
      print('[SECURITY] (dup) ${threatLabel(t)} already active');
    }
  }

  void clear(SecurityThreat t) {
    if (state.active.contains(t)) {
      print('[SECURITY] - ${threatLabel(t)}');
      final next = {...state.active}..remove(t);
      emit(SecurityState(next));
    }
  }

  void clearAll() {
    if (state.active.isNotEmpty) {
      print(
        '[SECURITY] clearAll -> ${state.active.map(threatLabel).join(', ')}',
      );
      emit(const SecurityState({}));
    }
  }

  // Optional: print state diffs whenever state changes
  @override
  void onChange(Change<SecurityState> change) {
    super.onChange(change);
    final prev = change.currentState.active;
    final curr = change.nextState.active;

    final added = curr.difference(prev).map(threatLabel).toList();
    final removed = prev.difference(curr).map(threatLabel).toList();

    if (added.isNotEmpty || removed.isNotEmpty) {
      print(
        '[SECURITY] state -> added: $added | removed: $removed | now: ${curr.map(threatLabel).toList()}',
      );
    }
  }
}
