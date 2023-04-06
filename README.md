# KeyboardListenerKit

A Swift package for listening to global keyboard events in macOS applications.

## Features

- Listen to global keyboard events.
- Get the Unicode characters, modifier keys, and key codes of the typed characters.
- Easy to integrate into SwiftUI macOS applications.

## Installation

Add `KeyboardListenerKit` to your project using Swift Package Manager.

In Xcode, go to `File` > `Add Packages...` > search for `https://github.com/mirkokiefer/KeyboardListenerKit.swift.git` and add the package.

## Usage

Here's an example of how to use `KeyboardListenerKit` in a modern SwiftUI macOS application:

### 1. Create a new SwiftUI macOS app project.

### 2. Add the `KeyboardListenerKit` package to the project using Swift Package Manager.

### 3. Replace the contents of `AppNameApp.swift` with the following code:

```swift
import SwiftUI
import KeyboardListenerKit

@main
struct AppNameApp: App {
    @StateObject private var keyboardListener = KeyboardListener()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(keyboardListener)
        }
    }
}
```

### 4. Replace the contents of `ContentView.swift` with the following code:

```swift
import SwiftUI
import KeyboardListenerKit

struct ContentView: View {
    @EnvironmentObject private var keyboardListener: KeyboardListener

    var body: some View {
        VStack {
            Text("KeyboardListener Example")
                .font(.largeTitle)

            Text("Last typed character:")
                .font(.title2)

            Text("\(keyboardListener.lastTypedCharacter)")
                .font(.title)
                .bold()
        }
        .padding()
        .onAppear {
            keyboardListener.callback = { modifierKeys, unicodeString, keyCode in
                print("Character typed: \(modifierKeys) \(unicodeString) \(keyCode)")
                keyboardListener.lastTypedCharacter = unicodeString
            }
            keyboardListener.startListening()
        }
        .onDisappear {
            keyboardListener.stopListening()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(KeyboardListener())
    }
}
```

### 5. Update the `KeyboardListener` class by adding a `@Published` property `lastTypedCharacter`:

```swift
public class KeyboardListener: ObservableObject {
    // Add this line
    @Published public var lastTypedCharacter: String = ""

    // ... (rest of the class implementation)
}
```

Now, when you run the app, it will display the last typed character and print the character along with the modifier keys and key code in the console. The `KeyboardListener` will start listening for events when the `ContentView` appears and stop listening when it disappears.

## License

`KeyboardListenerKit` is available under the MIT license. See the [LICENSE](LICENSE) file for more information.