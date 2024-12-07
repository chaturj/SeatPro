import Foundation

public struct SeatsioObject: Decodable {
    public let id: Int?
    public let key: String?
    public let price: Float?
//    public let special: String?
    public let x: Int?
    public let y: Int?
    public let ax: Float?
    public let ay: Float?
    public let sectionId: Int?
    public let sectorId: Int?
    public let seatName: String?
    public let rowNumber: String?
    public let sectionName: String?
    public init(id: Int?, key: String?, price: Float?, x: Int?, y: Int?, ax: Float?, ay: Float?, sectionId: Int?, sectorId: Int?, seatName: String?, rowNumber: String?, sectionName: String?) {
        self.id = id
        self.key = key
        self.price = price
        self.x = x
        self.y = y
        self.ax = ax
        self.ay = ay
        self.sectionId = sectionId
        self.sectorId = sectorId
        self.seatName = seatName
        self.rowNumber = rowNumber
        self.sectionName = sectionName
    }
}
extension SeatsioObject: Equatable {

    public static func ==(lhs: SeatsioObject, rhs: SeatsioObject) -> Bool {
        lhs.id == rhs.id
    }
}
