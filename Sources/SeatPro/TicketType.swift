import Foundation

public struct TicketType: Codable {

    public let price: Float
    public init(price: Float) {
        self.price = price
    }
}
