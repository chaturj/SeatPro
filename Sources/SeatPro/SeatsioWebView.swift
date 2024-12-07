import Foundation
import WebKit

struct ChartKey: Codable {
    var workspaceKey: String?
    var events:[String]?
}
public class SeatsioWebView: WKWebView {
    var bridge: JustBridge!
    var seatsioConfig: SeatsioConfig
    
    public init(frame: CGRect, region: String, seatsioConfig: SeatsioConfig)
    {
        self.seatsioConfig = seatsioConfig
        super.init(frame: frame, configuration: WKWebViewConfiguration())
        bridge = JustBridge(with: self)
        loadSeatingChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    
    private func loadSeatingChart() {
        let callbacks = self.buildCallbacksConfiguration().joined(separator: ",")
        print(callbacks)
        let config = self.buildConfiguration()
        print(config)
        let data = config.data(using: .utf8)!
        do {
            let f = try JSONDecoder().decode(ChartKey.self, from: data)
            let eventKey = f.events?[0]
            let htmlString = HTML1
                .replacingOccurrences(of: "%workSpacekey%", with: f.workspaceKey ?? "")
                .replacingOccurrences(of: "%eventID%", with: eventKey ?? "")
                .replacingOccurrences(of: "%configAsJs%", with: callbacks)
            self.loadHTMLString(htmlString, baseURL: nil)
        } catch {
            print(error)
        }
        
        
        
    }
    private func buildConfiguration() -> String
    {
        seatsioConfig.jsonStringRepresentation
    }
    
    private func buildCallbacksConfiguration() -> [String] {
        var callbacks = [String]()
        
        if (self.seatsioConfig.onObjectSelected != nil) {
            bridge.register("onSeatSelect") { (data, callback) in
                self.seatsioConfig.onObjectSelected!(decodeSeatsioObject(firstArg(data)))
            }
            callbacks.append(buildCallbackConfigAsJS("onSeatSelect"))
        }
        if (self.seatsioConfig.onObjectDeselected != nil) {
            bridge.register("onSeatDeselect") { (data, callback) in
                self.seatsioConfig.onObjectDeselected!(decodeSeatsioObject(firstArg(data)))
            }
            callbacks.append(buildCallbackConfigAsJS("onSeatDeselect"))
        }
        print(callbacks)
        return callbacks
    }
    private func buildCallbackConfigAsJS(_ name: String) -> String {
        return """
                   \(name): (arg1, arg2) => 
                    window.bridge.call("\(name)", [JSON.stringify(arg1), JSON.stringify(arg2)], data => resolve(data), error => reject(error))
                   """
    }
    public func cleanup() {
        bridge.cleanUp()
        bridge = nil
    }
}

private func firstArg(_ data: Any?) -> Any {
    return (data as! [Any])[0]
}

private func secondArg(_ data: Any?) -> Any {
    return (data as! [Any])[1]
}

func decodeSeatsioObject(_ data: Any) -> SeatsioObject {
    let dataToDecode = (data as! String).data(using: .utf8)!
    return try! JSONDecoder().decode(SeatsioObject.self, from: dataToDecode)
}



func decodeSeatsioObjects(_ data: Any) -> [SeatsioObject] {
    let dataToDecode = (data as! String).data(using: .utf8)!
    return try! JSONDecoder().decode([SeatsioObject].self, from: dataToDecode)
}




func decodeFloat(_ data: Any) -> Float {
    return (data as! NSString).floatValue
}

func decodeBool(_ data: Any) -> Bool {
    return (data as! NSString).boolValue
}


func decodeTicketType(_ data: Any) -> TicketType? {
    if (data is NSNull) {
        return nil
    }
    
    let dataAsString = data as! String
    
    if (dataAsString == "null") {
        return nil
    }
    
    let dataToDecode = dataAsString.data(using: .utf8)!
    return try! JSONDecoder().decode(TicketType.self, from: dataToDecode)
}
