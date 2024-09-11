// RUN: %target-typecheck-verify-swift \
// RUN:     -verify-additional-prefix enabled- \
// RUN:     -enable-experimental-feature CoroutineAccessors \
// RUN:     -debug-diagnostic-names
// RUN: %target-typecheck-verify-swift \
// RUN:     -verify-additional-prefix disabled- \
// RUN:     -debug-diagnostic-names

// Properties with implicit getters which call functions named modify.

func modify<T>(_ c : () -> T) -> T { c() }

// enabled: need reader
// disabled: ok!
var im : Int {
  modify { // expected-enabled-error{{variable with a 'modify' accessor must also have a getter, addressor, or 'read' accessor}}
    1 // expected-enabled-warning{{integer literal is unused}}
  }
}
