import Foundation
import CoreData

public class PreviewData {
    
    // MARK: - Core Data Preview Helper
    
    public static func createPreviewContext() -> NSManagedObjectContext {
        // Create model programmatically for testing
        let managedObjectModel = createManagedObjectModel()
        
        let persistentContainer = NSPersistentContainer(name: "DuskerDataModel", managedObjectModel: managedObjectModel)
        
        // Configure in-memory store
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }
    
    // Create the managed object model programmatically
    private static func createManagedObjectModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        // Create SurfSession entity
        let surfSessionEntity = NSEntityDescription()
        surfSessionEntity.name = "SurfSession"
        surfSessionEntity.managedObjectClassName = "SurfSessionEntity"
        
        // Create Wave entity
        let waveEntity = NSEntityDescription()
        waveEntity.name = "Wave"
        waveEntity.managedObjectClassName = "WaveEntity"
        
        // Create SurfSession attributes
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .UUIDAttributeType
        idAttribute.isOptional = false
        
        let startDateAttribute = NSAttributeDescription()
        startDateAttribute.name = "startDate"
        startDateAttribute.attributeType = .dateAttributeType
        startDateAttribute.isOptional = false
        
        let endDateAttribute = NSAttributeDescription()
        endDateAttribute.name = "endDate"
        endDateAttribute.attributeType = .dateAttributeType
        endDateAttribute.isOptional = true
        
        let locationAttribute = NSAttributeDescription()
        locationAttribute.name = "location"
        locationAttribute.attributeType = .stringAttributeType
        locationAttribute.isOptional = false
        locationAttribute.defaultValue = ""
        
        let latitudeAttribute = NSAttributeDescription()
        latitudeAttribute.name = "latitude"
        latitudeAttribute.attributeType = .doubleAttributeType
        latitudeAttribute.isOptional = true
        latitudeAttribute.defaultValue = 0.0
        
        let longitudeAttribute = NSAttributeDescription()
        longitudeAttribute.name = "longitude"
        longitudeAttribute.attributeType = .doubleAttributeType
        longitudeAttribute.isOptional = true
        longitudeAttribute.defaultValue = 0.0
        
        let totalWavesAttribute = NSAttributeDescription()
        totalWavesAttribute.name = "totalWaves"
        totalWavesAttribute.attributeType = .integer32AttributeType
        totalWavesAttribute.isOptional = true
        totalWavesAttribute.defaultValue = 0
        
        let maxSpeedAttribute = NSAttributeDescription()
        maxSpeedAttribute.name = "maxSpeed"
        maxSpeedAttribute.attributeType = .doubleAttributeType
        maxSpeedAttribute.isOptional = true
        maxSpeedAttribute.defaultValue = 0.0
        
        let avgHeartRateAttribute = NSAttributeDescription()
        avgHeartRateAttribute.name = "avgHeartRate"
        avgHeartRateAttribute.attributeType = .doubleAttributeType
        avgHeartRateAttribute.isOptional = true
        avgHeartRateAttribute.defaultValue = 0.0
        
        let distanceSurfedAttribute = NSAttributeDescription()
        distanceSurfedAttribute.name = "distanceSurfed"
        distanceSurfedAttribute.attributeType = .doubleAttributeType
        distanceSurfedAttribute.isOptional = true
        distanceSurfedAttribute.defaultValue = 0.0
        
        let distancePaddledAttribute = NSAttributeDescription()
        distancePaddledAttribute.name = "distancePaddled"
        distancePaddledAttribute.attributeType = .doubleAttributeType
        distancePaddledAttribute.isOptional = true
        distancePaddledAttribute.defaultValue = 0.0
        
        let strokeCountAttribute = NSAttributeDescription()
        strokeCountAttribute.name = "strokeCount"
        strokeCountAttribute.attributeType = .integer32AttributeType
        strokeCountAttribute.isOptional = true
        strokeCountAttribute.defaultValue = 0
        
        let notesAttribute = NSAttributeDescription()
        notesAttribute.name = "notes"
        notesAttribute.attributeType = .stringAttributeType
        notesAttribute.isOptional = true
        
        let isUploadedAttribute = NSAttributeDescription()
        isUploadedAttribute.name = "isUploaded"
        isUploadedAttribute.attributeType = .booleanAttributeType
        isUploadedAttribute.isOptional = false
        isUploadedAttribute.defaultValue = false
        
        // Create Wave attributes
        let waveIdAttribute = NSAttributeDescription()
        waveIdAttribute.name = "id"
        waveIdAttribute.attributeType = .UUIDAttributeType
        waveIdAttribute.isOptional = false
        
        let startTimeAttribute = NSAttributeDescription()
        startTimeAttribute.name = "startTime"
        startTimeAttribute.attributeType = .dateAttributeType
        startTimeAttribute.isOptional = false
        
        let endTimeAttribute = NSAttributeDescription()
        endTimeAttribute.name = "endTime"
        endTimeAttribute.attributeType = .dateAttributeType
        endTimeAttribute.isOptional = false
        
        let distanceAttribute = NSAttributeDescription()
        distanceAttribute.name = "distance"
        distanceAttribute.attributeType = .doubleAttributeType
        distanceAttribute.isOptional = true
        distanceAttribute.defaultValue = 0.0
        
        let durationAttribute = NSAttributeDescription()
        durationAttribute.name = "duration"
        durationAttribute.attributeType = .doubleAttributeType
        durationAttribute.isOptional = true
        durationAttribute.defaultValue = 0.0
        
        let waveMaxSpeedAttribute = NSAttributeDescription()
        waveMaxSpeedAttribute.name = "maxSpeed"
        waveMaxSpeedAttribute.attributeType = .doubleAttributeType
        waveMaxSpeedAttribute.isOptional = true
        waveMaxSpeedAttribute.defaultValue = 0.0
        
        let coordinatesAttribute = NSAttributeDescription()
        coordinatesAttribute.name = "coordinates"
        coordinatesAttribute.attributeType = .binaryDataAttributeType
        coordinatesAttribute.isOptional = true
        
        let confidenceAttribute = NSAttributeDescription()
        confidenceAttribute.name = "confidence"
        confidenceAttribute.attributeType = .doubleAttributeType
        confidenceAttribute.isOptional = true
        confidenceAttribute.defaultValue = 0.0
        
        // Add attributes to entities
        surfSessionEntity.properties = [
            idAttribute,
            startDateAttribute,
            endDateAttribute,
            locationAttribute,
            latitudeAttribute,
            longitudeAttribute,
            totalWavesAttribute,
            maxSpeedAttribute,
            avgHeartRateAttribute,
            distanceSurfedAttribute,
            distancePaddledAttribute,
            strokeCountAttribute,
            notesAttribute,
            isUploadedAttribute
        ]
        
        waveEntity.properties = [
            waveIdAttribute,
            startTimeAttribute,
            endTimeAttribute,
            distanceAttribute,
            durationAttribute,
            waveMaxSpeedAttribute,
            coordinatesAttribute,
            confidenceAttribute
        ]
        
        // Create relationships
        let wavesToSessionRelationship = NSRelationshipDescription()
        wavesToSessionRelationship.name = "session"
        wavesToSessionRelationship.destinationEntity = surfSessionEntity
        wavesToSessionRelationship.deleteRule = .nullifyDeleteRule
        wavesToSessionRelationship.maxCount = 1
        wavesToSessionRelationship.minCount = 0
        
        let sessionToWavesRelationship = NSRelationshipDescription()
        sessionToWavesRelationship.name = "waves"
        sessionToWavesRelationship.destinationEntity = waveEntity
        sessionToWavesRelationship.deleteRule = .cascadeDeleteRule
        sessionToWavesRelationship.minCount = 0
        
        // Set inverse relationships
        wavesToSessionRelationship.inverseRelationship = sessionToWavesRelationship
        sessionToWavesRelationship.inverseRelationship = wavesToSessionRelationship
        
        // Add relationships to entities
        surfSessionEntity.properties.append(sessionToWavesRelationship)
        waveEntity.properties.append(wavesToSessionRelationship)
        
        // Add entities to model
        model.entities = [surfSessionEntity, waveEntity]
        
        return model
    }
    
    // MARK: - Sample Data Generation
    
    public static func createSampleData(in context: NSManagedObjectContext) {
        // Create sample sessions
        let session1 = createSampleSession(
            in: context,
            id: UUID(),
            startDate: Date().addingTimeInterval(-3600 * 3), // 3 hours ago
            endDate: Date().addingTimeInterval(-3600), // 1 hour ago
            location: "Malibu Beach",
            latitude: 34.0259,
            longitude: -118.7798,
            totalWaves: 12,
            maxSpeed: 15.7,
            avgHeartRate: 142.5,
            distanceSurfed: 1250.0,
            distancePaddled: 3500.0,
            strokeCount: 1200,
            notes: "Great session with clean waves",
            isUploaded: true
        )
        
        let session2 = createSampleSession(
            in: context,
            id: UUID(),
            startDate: Date().addingTimeInterval(-86400), // 1 day ago
            endDate: Date().addingTimeInterval(-86400 + 7200), // 1 day ago + 2 hours
            location: "Huntington Beach",
            latitude: 33.6595,
            longitude: -118.0010,
            totalWaves: 8,
            maxSpeed: 12.3,
            avgHeartRate: 138.2,
            distanceSurfed: 980.0,
            distancePaddled: 2800.0,
            strokeCount: 950,
            notes: "Crowded but found some good waves",
            isUploaded: true
        )
        
        let session3 = createSampleSession(
            in: context,
            id: UUID(),
            startDate: Date().addingTimeInterval(-172800), // 2 days ago
            endDate: Date().addingTimeInterval(-172800 + 5400), // 2 days ago + 1.5 hours
            location: "Trestles",
            latitude: 33.3853,
            longitude: -117.5939,
            totalWaves: 15,
            maxSpeed: 18.2,
            avgHeartRate: 145.8,
            distanceSurfed: 1800.0,
            distancePaddled: 4200.0,
            strokeCount: 1450,
            notes: "Perfect conditions, best session in weeks",
            isUploaded: false
        )
        
        // Add waves to sessions
        addSampleWaves(to: session1, in: context, count: 12)
        addSampleWaves(to: session2, in: context, count: 8)
        addSampleWaves(to: session3, in: context, count: 15)
        
        // Save the context
        do {
            try context.save()
        } catch {
            print("Error saving preview context: \(error)")
        }
    }
    
    private static func createSampleSession(
        in context: NSManagedObjectContext,
        id: UUID,
        startDate: Date,
        endDate: Date?,
        location: String,
        latitude: Double,
        longitude: Double,
        totalWaves: Int,
        maxSpeed: Double,
        avgHeartRate: Double,
        distanceSurfed: Double,
        distancePaddled: Double,
        strokeCount: Int,
        notes: String?,
        isUploaded: Bool
    ) -> SurfSessionEntity {
        let session = SurfSessionEntity(context: context)
        session.id = id
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
        return session
    }
    
    private static func addSampleWaves(to session: SurfSessionEntity, in context: NSManagedObjectContext, count: Int) {
        guard let sessionEndDate = session.endDate else { return }
        let sessionDuration = sessionEndDate.timeIntervalSince(session.startDate)
        let averageWaveDuration: TimeInterval = 30 // 30 seconds per wave
        
        for i in 0..<count {
            // Distribute waves evenly throughout the session
            let waveStartOffset = (sessionDuration / Double(count + 1)) * Double(i + 1)
            let waveStartTime = session.startDate.addingTimeInterval(waveStartOffset)
            let waveEndTime = waveStartTime.addingTimeInterval(averageWaveDuration)
            
            // Create random wave data
            let distance = Double.random(in: 50...200)
            let duration = waveEndTime.timeIntervalSince(waveStartTime)
            let maxSpeed = Double.random(in: 8...20)
            
            // Create sample coordinates data
            let coordinates = createSampleCoordinates(
                startLat: session.latitude,
                startLon: session.longitude,
                distance: distance
            )
            
            // Create the wave
            let wave = WaveEntity(context: context)
            wave.id = UUID()
            wave.startTime = waveStartTime
            wave.endTime = waveEndTime
            wave.distance = distance
            wave.duration = duration
            wave.maxSpeed = maxSpeed
            wave.coordinates = coordinates
            wave.confidence = Double.random(in: 0.7...1.0)
            wave.session = session
        }
    }
    
    private static func createSampleCoordinates(startLat: Double, startLon: Double, distance: Double) -> Data {
        // Create a simple array of coordinates that simulate a wave ride
        // In a real app, this would be actual GPS coordinates
        var coordinates: [[String: Double]] = []
        
        // Number of points to generate
        let pointCount = 20
        
        // Small random variations to simulate movement
        for i in 0..<pointCount {
            let progress = Double(i) / Double(pointCount - 1)
            let latOffset = (distance / 111000.0) * progress * Double.random(in: 0.8...1.2) // Convert meters to degrees
            let lonOffset = (distance / 111000.0) * progress * Double.random(in: 0.8...1.2) / cos(startLat * .pi / 180.0)
            
            let point: [String: Double] = [
                "latitude": startLat + latOffset * Double.random(in: -1...1),
                "longitude": startLon + lonOffset * Double.random(in: -1...1),
                "timestamp": Double(i) // Simplified timestamp
            ]
            coordinates.append(point)
        }
        
        // Convert to Data
        do {
            return try JSONSerialization.data(withJSONObject: coordinates, options: [])
        } catch {
            print("Error creating sample coordinates: \(error)")
            return Data()
        }
    }
} 