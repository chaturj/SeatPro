import Foundation

public struct ConfigChange: Encodable {

    public let numberOfPlacesToSelect: Int?
    public let maxSelectedObjects: AnyEncodable?
    public let extraConfig: AnyEncodable?

    public init(objectColor: String? = nil, objectLabel: String? = nil, numberOfPlacesToSelect: Int? = nil, maxSelectedObjects: AnyEncodable? = nil, extraConfig: AnyEncodable? = nil) {
        
        self.numberOfPlacesToSelect = numberOfPlacesToSelect
        self.maxSelectedObjects = maxSelectedObjects
        self.extraConfig = extraConfig
    }
}
