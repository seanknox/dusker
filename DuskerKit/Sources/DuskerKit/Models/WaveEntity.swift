import Foundation
import CoreData

@objc(WaveEntity)
public class WaveEntity: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var startTime: Date
    @NSManaged public var endTime: Date
    @NSManaged public var distance: Double
    @NSManaged public var duration: Double
    @NSManaged public var maxSpeed: Double
    @NSManaged public var coordinates: Data
    @NSManaged public var confidence: Double
    @NSManaged public var session: SurfSessionEntity?
    
    // MARK: - Computed Properties
    
    public var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: duration) ?? "0s"
    }
    
    public var averageSpeed: Double {
        return distance / duration
    }
    
    // MARK: - Conversion Methods
    
    public func toWave() -> Wave {
        return Wave(
            id: id,
            startTime: startTime,
            endTime: endTime,
            distance: distance,
            duration: duration,
            maxSpeed: maxSpeed,
            coordinates: coordinates,
            confidence: confidence
        )
    }
}

// MARK: - Fetch Request Extensions

extension WaveEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaveEntity> {
        return NSFetchRequest<WaveEntity>(entityName: "Wave")
    }
    
    public class func fetchAll(in context: NSManagedObjectContext) -> [WaveEntity] {
        let request = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \WaveEntity.startTime, ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching waves: \(error)")
            return []
        }
    }
    
    public class func fetch(withId id: UUID, in context: NSManagedObjectContext) -> WaveEntity? {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            print("Error fetching wave with id \(id): \(error)")
            return nil
        }
    }
    
    public class func fetchWaves(forSessionId sessionId: UUID, in context: NSManagedObjectContext) -> [WaveEntity] {
        let request = fetchRequest()
        request.predicate = NSPredicate(format: "session.id == %@", sessionId as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \WaveEntity.startTime, ascending: true)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching waves for session \(sessionId): \(error)")
            return []
        }
    }
} 