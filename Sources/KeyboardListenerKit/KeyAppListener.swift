import Cocoa

public class KeyAppListener: NSObject {
  private var observer: NSObjectProtocol?
  public var callback: ((String) -> Void)?
  
  public override init() {
    super.init()
  }
  
  deinit {
    stopListening()
  }
  
  public func startListening() {
    let notificationCenter = NSWorkspace.shared.notificationCenter
    observer = notificationCenter.addObserver(forName: NSWorkspace.didActivateApplicationNotification,
                                              object: nil,
                                              queue: .main) { [weak self] notification in
      self?.handleAppActivation(notification: notification)
    }
  }
  
  public func stopListening() {
    if let observer = observer {
      NotificationCenter.default.removeObserver(observer)
    }
  }
  
  private func handleAppActivation(notification: Notification) {
    guard let userInfo = notification.userInfo,
          let app = userInfo[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
          let app = app.bundleIdentifier else {
      return
    }
    
    callback?(app)
  }
}
