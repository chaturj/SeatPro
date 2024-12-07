import Foundation



struct EventManagerConfigParams: Encodable {
    var event: String?
    var events: [String]?
    var messages: [String: String]?
    var extraConfig: AnyEncodable?
}

public final class EventManagerConfig: SeatsioConfig {
    
    private(set) var params = EventManagerConfigParams()
    public private(set) var onObjectSelected: ((SeatsioObject) -> Void)?
    public private(set) var onObjectDeselected: ((SeatsioObject) -> Void)?
    public private(set) var onObjectClicked: ((SeatsioObject) -> Void)?

    
    public init() {}
    
   
    public func event(_ event: String) -> Self {
        params.event = event
        return self
    }
    
    public func events(_ events: [String]) -> Self {
        params.events = events
        return self
    }

   
    
    public func messages(_ messages: [String: String]) -> Self {
        params.messages = messages
        return self
    }
   
    public func onObjectSelected(_ onObjectSelected: @escaping (SeatsioObject) -> ()) -> Self {
        self.onObjectSelected = onObjectSelected
        return self
    }

    public func onObjectDeselected(_ onObjectDeselected: @escaping (SeatsioObject) -> ()) -> Self {
        self.onObjectDeselected = onObjectDeselected
        return self
    }

    public func onObjectClicked(_ onObjectClicked: @escaping (SeatsioObject) -> ()) -> Self {
        self.onObjectClicked = onObjectClicked
        return self
    }

   

    
    
    public var jsonStringRepresentation: String {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(params) else {
            assertionFailure("Failed to encode config")
            return ""
        }
        return String(decoding: jsonData, as: UTF8.self)
    }
}
