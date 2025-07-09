import Foundation
import Combine
import WatchConnectivity

class WatchSessionManager: NSObject, ObservableObject, WCSessionDelegate {
    // Properly initialize objectWillChange
    var objectWillChange = ObservableObjectPublisher()
    
    static let shared = WatchSessionManager()
    private override init() { super.init() }
    
    private let session = WCSession.default

    func startSession() {
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }

    // Example: Send message to iPhone
    func send(message: [String: Any]) {
        session.sendMessage(message, replyHandler: nil, errorHandler: nil)
    }

    // MARK: - WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Optional: Handle activation state if needed
        print("Session activated with state: \(activationState)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Handle received message from iPhone
        print("Received from iPhone: \(message)")
        objectWillChange.send() // Notify observers of change
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Optional: Handle session becoming inactive
    }
    func sessionDidDeactivate(_ session: WCSession) {
        // Optional: Reactivate session if needed
        session.activate()
    }
    #endif
    
    #if os(watchOS)
    func sessionReachabilityDidChange(_ session: WCSession) {
        // Optional: Handle reachability changes
    }
    #endif
}
