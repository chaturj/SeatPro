public protocol SeatsioConfig {
    
    var jsonStringRepresentation: String { get  }
    var onObjectClicked: ((SeatsioObject) -> Void)? { get }
    var onObjectSelected: ((SeatsioObject) -> Void)? { get }
    var onObjectDeselected: ((SeatsioObject) -> Void)? { get }
}
