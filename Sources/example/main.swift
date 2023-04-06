import KeyboardListenerKit
import Foundation

let listener = KeyboardListener()

listener.callback = { modifierKeys, unicodeString, keyCode in
    print("Key Pressed: \(modifierKeys)\(unicodeString) (\(keyCode))")
}

let _ = listener.startListening()
print("Global key listener started. Press any key...")

let keyAppListener = KeyAppListener()

keyAppListener.callback = { app in
    print("Key App: \(app)")
}

keyAppListener.startListening()

// Add signal handler for SIGINT
var signalInterrupt = false
let signalHandler: @convention(c) (Int32) -> Void = { _ in
    signalInterrupt = true
    listener.stopListening()
    CFRunLoopStop(CFRunLoopGetCurrent())
}
signal(SIGINT, signalHandler)

// Run the main run loop until a signal interrupt occurs
while !signalInterrupt {
    RunLoop.current.run(mode: .default, before: .distantFuture)
}