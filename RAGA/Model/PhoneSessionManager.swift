import Foundation
import WatchConnectivity

class PhoneSessionManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = PhoneSessionManager()
    private override init() { super.init() }
    
    private let session = WCSession.default

    func startSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }

    // Example: Send message to Watch
    func send(message: [String: Any]) {
        if session.isPaired && session.isWatchAppInstalled {
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }

    // MARK: - WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Handle received message from Watch
        print("Received from Watch: \(message)")
    }
} 