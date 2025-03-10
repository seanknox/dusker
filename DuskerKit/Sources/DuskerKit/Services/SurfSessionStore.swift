import Foundation
import CoreData

public class SurfSessionStore {
    private let coreDataManager: CoreDataManager
    
    public init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Session Operations
    
    public func createSession(
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
    ) -> SurfSessionEntity {
        let context = coreDataManager.viewContext
        let session = SurfSessionEntity(context: context)
        
        session.id = UUID()
        session.startDate = startDate
        session.endDate = endDate
        session.location = location
        session.latitude = latitude
        session.longitude = longitude
        session.totalWaves = Int32(totalWaves)
        session.maxSpeed = maxSpeed
        session.avgHeartRate = avgHeartRate
        session.distanceSurfed = distanceSurfed
        session.distancePaddled = distancePaddled
        session.strokeCount = Int32(strokeCount)
        session.notes = notes
        session.isUploaded = isUploaded
        
        coreDataManager.saveContext()
        return session
    }
    
    public func updateSession(_ session: SurfSessionEntity, with updatedSession: SurfSession) {
        session.startDate = updatedSession.startDate
        session.endDate = updatedSession.endDate
        session.location = updatedSession.location
        session.latitude = updatedSession.latitude
        session.longitude = updatedSession.longitude
        session.totalWaves = Int32(updatedSession.totalWaves)
        session.maxSpeed = updatedSession.maxSpeed
        session.avgHeartRate = updatedSession.avgHeartRate
        session.distanceSurfed = updatedSession.distanceSurfed
        session.distancePaddled = updatedSession.distancePaddled
        session.strokeCount = Int32(updatedSession.strokeCount)
        session.notes = updatedSession.notes
        session.isUploaded = updatedSession.isUploaded
        
        coreDataManager.saveContext()
    }
    
    public func deleteSession(_ session: SurfSessionEntity) {
        let context = coreDataManager.viewContext
        context.delete(session)
        coreDataManager.saveContext()
    }
    
    public func getAllSessions() -> [SurfSessionEntity] {
        return SurfSessionEntity.fetchAll(in: coreDataManager.viewContext)
    }
    
    public func getSession(withId id: UUID) -> SurfSessionEntity? {
        return SurfSessionEntity.fetch(withId: id, in: coreDataManager.viewContext)
    }
    
    // MARK: - Wave Operations
    
    public func addWave(
        toSession session: SurfSessionEntity,
        startTime: Date,
        endTime: Date,
        distance: Double,
        duration: Double,
        maxSpeed: Double,
        coordinates: Data,
        confidence: Double
    ) -> WaveEntity {
        let context = coreDataManager.viewContext
        let wave = WaveEntity(context: context)
        
        wave.id = UUID()
        wave.startTime = startTime
        wave.endTime = endTime
        wave.distance = distance
        wave.duration = duration
        wave.maxSpeed = maxSpeed
        wave.coordinates = coordinates
        wave.confidence = confidence
        wave.session = session
        
        // Update session totalWaves count
        session.totalWaves += 1
        
        // Update session maxSpeed if this wave has a higher speed
        if maxSpeed > session.maxSpeed {
            session.maxSpeed = maxSpeed
        }
        
        coreDataManager.saveContext()
        return wave
    }
    
    public func updateWave(_ wave: WaveEntity, with updatedWave: Wave) {
        wave.startTime = updatedWave.startTime
        wave.endTime = updatedWave.endTime
        wave.distance = updatedWave.distance
        wave.duration = updatedWave.duration
        wave.maxSpeed = updatedWave.maxSpeed
        wave.coordinates = updatedWave.coordinates
        wave.confidence = updatedWave.confidence
        
        coreDataManager.saveContext()
    }
    
    public func deleteWave(_ wave: WaveEntity) {
        if let session = wave.session {
            session.totalWaves -= 1
        }
        
        let context = coreDataManager.viewContext
        context.delete(wave)
        coreDataManager.saveContext()
    }
    
    public func getWavesForSession(withId sessionId: UUID) -> [WaveEntity] {
        return WaveEntity.fetchWaves(forSessionId: sessionId, in: coreDataManager.viewContext)
    }
} 