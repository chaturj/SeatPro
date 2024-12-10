import Foundation



public class SeatingChartConfig: SeatsioConfig, Encodable {
    

    public private(set) var workspaceKey: String?
    public private(set) var events: Set<String>?
    public private(set) var chart: String?

    public private(set) var priceFormatter: ((Float) -> String)?
    public private(set) var numberOfPlacesToSelect: Int?
    public private(set) var objectWithoutPricingSelectable: Bool?
    public private(set) var selectableObjects: [String]?
    public private(set) var messages: [String: String]?
    public private(set) var maxSelectedObjects: AnyEncodable?
    public private(set) var showSeatLabels: Bool?
    public private(set) var showActiveSectionTooltip: Bool?
    public private(set) var showViewFromYourSeat: Bool?
    public private(set) var sectionColor: String?
    public private(set) var extraConfig: AnyEncodable?
    public private(set) var showZoomOutButtonOnMobile: Bool?
    public private(set) var channels: Set<String>?

    
    public private(set) var onObjectClicked: ((SeatsioObject) -> Void)?
    public private(set) var onObjectSelected: ((SeatsioObject) -> Void)?
    public private(set) var onObjectDeselected: ((SeatsioObject) -> Void)?
    public private(set) var onCartChange: ((CartObject) -> Void)?
    
    public var toolName: String { "SeatingChart" }

    public init() {}

    public func workspaceKey(_ workspaceKey: String) -> Self {
        self.workspaceKey = workspaceKey
        return self
    }

    public func event(_ event: String) -> Self {
        self.events = [event]
        return self
    }

    public func chart(_ chart: String) -> Self {
        self.chart = chart
        return self
    }

    public func events(_ events: Set<String>) -> Self {
        self.events = events
        return self
    }

    public func messages(_ messages: [String: String]) -> Self {
        self.messages = messages
        return self
    }

    public func maxSelectedObjects(_ maxSelectedObjects: Int) -> Self {
        self.maxSelectedObjects = AnyEncodable(value: maxSelectedObjects)
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

    public func onCartChange(_ onCartChange: @escaping (CartObject) -> ()) -> Self {
        self.onCartChange = onCartChange
        return self
    }
    
    @available(*, deprecated, message: "use showSectionContents('always') instead")
    

    

   

    public func showActiveSectionTooltip(_ showActiveSectionTooltip: Bool) -> Self {
        self.showActiveSectionTooltip = showActiveSectionTooltip
        return self
    }

    public func showViewFromYourSeat(_ showViewFromYourSeat: Bool) -> Self {
        self.showViewFromYourSeat = showViewFromYourSeat
        return self
    }


 

    

    

   

    
    public func sectionColor(_ sectionColor: String) -> Self {
        self.sectionColor = sectionColor
        return self
    }

    public func extraConfig(_ extraConfig: Encodable) -> Self {
        self.extraConfig = AnyEncodable(value: extraConfig)
        return self
    }

    

    
    public func onObjectClicked(_ onObjectClicked: @escaping (SeatsioObject) -> ()) -> Self {
        self.onObjectClicked = onObjectClicked
        return self
    }

   
  

 


   

    public func showZoomOutButton(_ showZoomOutButton: Bool) -> Self {
        self.showZoomOutButtonOnMobile = showZoomOutButton
        return self
    }

    public func channels(_ channels: Set<String>) -> Self {
        self.channels = channels
        return self
    }
    
    public var jsonStringRepresentation: String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return String(decoding: jsonData, as: UTF8.self)
    }

     enum CodingKeys: String, CodingKey {
        case workspaceKey
        case events
        case chart
        case numberOfPlacesToSelect
        case objectWithoutPricingSelectable
        case selectableObjects
        case messages
        case maxSelectedObjects
        case showViewFromYourSeat = "showViewFromYourSeatOnMobile"
        case extraConfig
        case showZoomOutButtonOnMobile
        case channels
    }
}
