import Foundation

public struct Wave: Identifiable, Codable {
    public let id: UUID
    public let startTime: Date
    public var endTime: Date
    public var distance: Double
    public var duration: Double
    public var maxSpeed: Double
    public var coordinates: Data
    public var confidence: Double
    
    public init(
        id: UUID = UUID(),
        startTime: Date = Date(),
        endTime: Date = Date().addingTimeInterval(30),
        distance: Double = 0.0,
        duration: Double = 0.0,
        maxSpeed: Double = 0.0,
        coordinates: Data = Data(),
        confidence: Double = 1.0
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.distance = distance
        self.duration = duration
        self.maxSpeed = maxSpeed
        self.coordinates = coordinates
        self.confidence = confidence
    }
    
    // Computed properties
    public var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: duration) ?? "0s"
    }
    
    public var averageSpeed: Double {
        return distance / duration
    }
} 