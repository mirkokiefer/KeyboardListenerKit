import keylistener
import Foundation

let globalKeyListener = GlobalKeyListener()

globalKeyListener.callback = { modifierKeys, unicodeString, keyCode in
    print("Key Pressed: \(modifierKeys)\(unicodeString) (\(keyCode))")
}

globalKeyListener.startListening()
print("Global key listener started. Press any key...")

// Add signal handler for SIGINT
var signalInterrupt = false
let signalHandler: @convention(c) (Int32) -> Void = { _ in
    signalInterrupt = true
    globalKeyListener.stopListening()
    CFRunLoopStop(CFRunLoopGetCurrent())
}
signal(SIGINT, signalHandler)

// Run the main run loop until a signal interrupt occurs
while !signalInterrupt {
    RunLoop.current.run(mode: .default, before: .distantFuture)
}