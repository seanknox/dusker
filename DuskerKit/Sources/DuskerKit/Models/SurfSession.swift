import Foundation

public struct SurfSession: Identifiable, Codable {
    public let id: UUID
    public let startDate: Date
    public var endDate: Date?
    public var location: String
    public var latitude: Double
    public var longitude: Double
    public var totalWaves: Int
    public var maxSpeed: Double
    public var avgHeartRate: Double
    public var distanceSurfed: Double
    public var distancePaddled: Double
    public var strokeCount: Int
    public var notes: String?
    public var isUploaded: Bool
    
    public init(
        id: UUID = UUID(),
        startDate: Date = Date(),
        endDate: Date? = nil,
        location: String = "",
        latitude: Double = 0.0,
        longitude: Double = 0.0,
        totalWaves: Int = 0,
        maxSpeed: Double = 0.0,
        avgHeartRate: Double = 0.0,
        distanceSurfed: Double = 0.0,
        distancePaddled: Double = 0.0,
        strokeCount: Int = 0,
        notes: String? = nil,
        isUploaded: Bool = false
    ) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.totalWaves = totalWaves
        self.maxSpeed = maxSpeed
        self.avgHeartRate = avgHeartRate
        self.distanceSurfed = distanceSurfed
        self.distancePaddled = distancePaddled
        self.strokeCount = strokeCount
        self.notes = notes
        self.isUploaded = isUploaded
    }
    
    // Computed properties
    public var duration: TimeInterval {
        guard let end = endDate else { return Date().timeIntervalSince(startDate) }
        return end.timeIntervalSince(startDate)
    }
    
    public var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: duration) ?? "0s"
    }
} 