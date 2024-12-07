import Foundation

public class SeatingChart {

    let seatsioWebView: SeatsioWebView

    public init(_ seatsioWebView: SeatsioWebView) {
        self.seatsioWebView = seatsioWebView
    }

    @MainActor public func selectObjects(_ objects: [String]) {
        seatsioWebView.bridge.call("selectObjects", data: objects)
    }

    @MainActor public func deselectObjects(_ objects: [String]) {
        seatsioWebView.bridge.call("deselectObjects", data: objects)
    }
    @MainActor public func zoomToSelectedObjects() {
        seatsioWebView.bridge.call("zoomToSelectedObjects", data: nil)
    }

    @MainActor public func zoomToSection(label: String) {
        seatsioWebView.bridge.call("zoomToSection", data: label)
    }

    @MainActor public func rerender() {
        seatsioWebView.bridge.call("rerender", data: nil)
    }

    @MainActor public func resetView() {
        seatsioWebView.bridge.call("resetView", data: nil)
    }

    @MainActor public func startNewSession() {
        seatsioWebView.bridge.call("startNewSession", data: nil)
    }

    @MainActor public func selectCategories(_ categories: [String]) {
        seatsioWebView.bridge.call("selectCategories", data: categories)
    }

    @MainActor public func deselectCategories(_ categories: [String]) {
        seatsioWebView.bridge.call("deselectCategories", data: categories)
    }

   

    @MainActor public func changeConfig(_ configChange: ConfigChange) {
        seatsioWebView.bridge.call("changeConfig", data: toJsonString(AnyEncodable(value: configChange)))
    }

    @MainActor public func clearSelection(_ callback: @escaping () -> ()) {
        seatsioWebView.bridge.call(
                "clearSelection",
                data: nil,
                callback: { (response) in callback() }
        )
    }

   

    @MainActor public func findObject(_ object: String, _ successCallback: @escaping (SeatsioObject) -> (), _ errorCallback: @escaping () -> ()) {
        seatsioWebView.bridge.call(
                "findObject",
                data: object,
                callback: { (response) in
                    if response == nil {
                        errorCallback()
                    } else {
                        successCallback(decodeSeatsioObject(response!))
                    }
                }
        )
    }

    @MainActor public func listSelectedObjects(_ callback: @escaping ([SeatsioObject]) -> ()) {
        seatsioWebView.bridge.call(
                "listSelectedObjects",
                data: nil,
                callback: { (response) in callback(decodeSeatsioObjects(response!)) }
        )
    }

                   

    @MainActor public func selectObject(_ label: String, _ ticketType: String?) {
        seatsioWebView.bridge.call("selectObject", data: ["label": label, "ticketType": ticketType])
    }

    @MainActor public func deselectObject(_ label: String, _ ticketType: String?) {
        seatsioWebView.bridge.call("deselectObject", data: ["label": label, "ticketType": ticketType])
    }

    @MainActor public func pulseObject(_ label: String) {
        seatsioWebView.bridge.call("pulseObject", data: label)
    }

    @MainActor public func unpulseObject(_ label: String) {
        seatsioWebView.bridge.call("unpulseObject", data: label)
    }

    @MainActor public func isObjectInChannel(_ label: String, _ channel: String, _ callback: @escaping (Bool) -> ()) {
        seatsioWebView.bridge.call("isObjectInChannel", data: ["label": label, "channel": channel], callback: { (response) in callback((response as? Bool)!) })
    }
}

func toJsonString(_ o: AnyEncodable) -> String {
    let data = try! JSONEncoder().encode(o)
    return String(data: data, encoding: .utf8)!
}

func nullToNil(value: Any?) -> Any? {
    if value is NSNull {
        return nil
    } else {
        return value
    }
}
