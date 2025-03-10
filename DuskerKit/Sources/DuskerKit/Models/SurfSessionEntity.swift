import Foundation
import CoreData

@objc(SurfSessionEntity)
public class SurfSessionEntity: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date?
    @NSManaged public var location: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var totalWaves: Int32
    @NSManaged public var maxSpeed: Double
    @NSManaged public var avgHeartRate: Double
    @NSManaged public var distanceSurfed: Double
    @NSManaged public var distancePaddled: Double
    @NSManaged public var strokeCount: Int32
    @NSManaged public var notes: String?
    @NSManaged public var isUploaded: Bool
    @NSManaged public var waves: Set<WaveEntity>?
    
    // MARK: - Computed Properties
    
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
    
    public var wavesArray: [WaveEntity] {
        let set = waves ?? []
        return set.sorted { $0.startTime < $1.startTime }
    }
    
    // MARK: - Conversion Methods
    
    public func toSurfSession() -> SurfSession {
        return SurfSession(
            id: id,
            startDate: startDate,
            endDate: endDate,
            location: location,
            latitude: latitude,
            longitude: longitude,
            totalWaves: Int(totalWaves),
            maxSpeed: maxSpeed,
            avgHeartRate: avgHeartRate,
            distanceSurfed: distanceSurfed,
            distancePaddled: distancePaddled,
            strokeCount: Int(strokeCount),
            notes: notes,
            isUploaded: isUploaded
        )
    }
}

// MARK: - Fetch Request Extensions

extension SurfSessionEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SurfSessionEntity> {
        return NSFetchRequest<SurfSessionEntity>(entityName: "SurfSession")
    }
    
    public class func fetchAll(in context: NSManagedObjectContext) -> [SurfSessionEntity] {
        let request = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SurfSessionEntity.startDate, ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching surf sessions: \(error)")
            return []
        }
    }
    
    public class func fetch(withId id: UUID, in context: NSManagedObjectContext) -> SurfSessionEntity? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            print("Error fetching surf session with id \(id): \(error)")
            return nil
        }
    }
} 