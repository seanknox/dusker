import XCTest
import CoreData
@testable import DuskerKit

final class CoreDataTests: XCTestCase {
    
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        context = createInMemoryContext()
    }
    
    override func tearDown() {
        context = nil
        super.tearDown()
    }
    
    // Create an in-memory Core Data stack for testing
    private func createInMemoryContext() -> NSManagedObjectContext {
        let model = createTestModel()
        let container = NSPersistentContainer(name: "TestModel", managedObjectModel: model)
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load stores: \(error), \(error.userInfo)")
            }
        }
        
        return container.viewContext
    }
    
    // Create a test model programmatically
    private func createTestModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        // Create SurfSession entity
        let surfSessionEntity = NSEntityDescription()
        surfSessionEntity.name = "SurfSession"
        surfSessionEntity.managedObjectClassName = NSStringFromClass(SurfSessionEntity.self)
        
        // Create Wave entity
        let waveEntity = NSEntityDescription()
        waveEntity.name = "Wave"
        waveEntity.managedObjectClassName = NSStringFromClass(WaveEntity.self)
        
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
    
    // MARK: - Test Session Creation and Saving
    
    func testCreateAndSaveSurfSession() {
        // Create a new session
        let session = NSEntityDescription.insertNewObject(forEntityName: "SurfSession", into: context) as! SurfSessionEntity
        session.id = UUID()
        session.startDate = Date()
        session.location = "Test Beach"
        session.latitude = 34.0259
        session.longitude = -118.7798
        session.totalWaves = 5
        session.maxSpeed = 12.5
        session.avgHeartRate = 140.0
        session.distanceSurfed = 800.0
        session.distancePaddled = 2000.0
        session.strokeCount = 750
        session.isUploaded = false
        
        // Save the context
        XCTAssertNoThrow(try context.save(), "Should save context without throwing")
        
        // Fetch the session
        let fetchRequest = NSFetchRequest<SurfSessionEntity>(entityName: "SurfSession")
        fetchRequest.predicate = NSPredicate(format: "id == %@", session.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1, "Should fetch exactly one session")
            
            let fetchedSession = results.first!
            XCTAssertEqual(fetchedSession.id, session.id)
            XCTAssertEqual(fetchedSession.location, "Test Beach")
            XCTAssertEqual(fetchedSession.totalWaves, 5)
            XCTAssertEqual(fetchedSession.maxSpeed, 12.5)
        } catch {
            XCTFail("Failed to fetch session: \(error)")
        }
    }
    
    // MARK: - Test Adding Waves to Session
    
    func testAddWavesToSession() {
        // Create a session
        let session = NSEntityDescription.insertNewObject(forEntityName: "SurfSession", into: context) as! SurfSessionEntity
        session.id = UUID()
        session.startDate = Date()
        session.location = "Wave Test Beach"
        session.totalWaves = 0
        
        // Add waves to the session
        for i in 1...3 {
            let wave = NSEntityDescription.insertNewObject(forEntityName: "Wave", into: context) as! WaveEntity
            wave.id = UUID()
            wave.startTime = Date().addingTimeInterval(Double(i) * 300)
            wave.endTime = Date().addingTimeInterval(Double(i) * 300 + 30)
            wave.distance = Double(i) * 100
            wave.duration = 30.0
            wave.maxSpeed = Double(i) * 5
            wave.coordinates = Data()
            wave.confidence = 0.9
            wave.session = session
            
            // Update session totalWaves
            session.totalWaves += 1
        }
        
        // Save the context
        XCTAssertNoThrow(try context.save(), "Should save context without throwing")
        
        // Fetch the session with waves
        let fetchRequest = NSFetchRequest<SurfSessionEntity>(entityName: "SurfSession")
        fetchRequest.predicate = NSPredicate(format: "id == %@", session.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1, "Should fetch exactly one session")
            
            let fetchedSession = results.first!
            XCTAssertEqual(fetchedSession.totalWaves, 3, "Session should have 3 waves")
            XCTAssertEqual(fetchedSession.waves?.count, 3, "Session waves relationship should contain 3 waves")
            
            // Test the waves array computed property
            XCTAssertEqual(fetchedSession.wavesArray.count, 3, "wavesArray should return 3 waves")
            
            // Verify waves are sorted by startTime
            let sortedWaves = fetchedSession.wavesArray
            for i in 0..<sortedWaves.count-1 {
                XCTAssertLessThanOrEqual(sortedWaves[i].startTime, sortedWaves[i+1].startTime, "Waves should be sorted by startTime")
            }
        } catch {
            XCTFail("Failed to fetch session with waves: \(error)")
        }
    }
    
    // MARK: - Test Fetching Sessions with Waves
    
    func testFetchSessionsWithWaves() {
        // Create sample sessions
        for i in 1...3 {
            let session = NSEntityDescription.insertNewObject(forEntityName: "SurfSession", into: context) as! SurfSessionEntity
            session.id = UUID()
            session.startDate = Date().addingTimeInterval(-Double(i) * 86400) // i days ago
            session.endDate = Date().addingTimeInterval(-Double(i) * 86400 + 7200) // i days ago + 2 hours
            session.location = "Beach \(i)"
            session.totalWaves = Int32(i * 5) // 5, 10, 15 waves
            
            // Add waves to the session
            for j in 1...Int(session.totalWaves) {
                let wave = NSEntityDescription.insertNewObject(forEntityName: "Wave", into: context) as! WaveEntity
                wave.id = UUID()
                wave.startTime = session.startDate.addingTimeInterval(Double(j) * 300)
                wave.endTime = wave.startTime.addingTimeInterval(30)
                wave.session = session
            }
        }
        
        // Save the context
        XCTAssertNoThrow(try context.save(), "Should save context without throwing")
        
        // Fetch all sessions
        let fetchRequest = NSFetchRequest<SurfSessionEntity>(entityName: "SurfSession")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \SurfSessionEntity.startDate, ascending: false)]
        
        do {
            let sessions = try context.fetch(fetchRequest)
            XCTAssertEqual(sessions.count, 3, "Should fetch 3 sample sessions")
            
            // Check each session has the correct number of waves
            XCTAssertEqual(sessions[0].totalWaves, 5, "Session 1 should have 5 waves")
            XCTAssertEqual(sessions[1].totalWaves, 10, "Session 2 should have 10 waves")
            XCTAssertEqual(sessions[2].totalWaves, 15, "Session 3 should have 15 waves")
            
            // Check waves relationship
            XCTAssertEqual(sessions[0].waves?.count, 5, "Session 1 should have 5 waves in relationship")
            XCTAssertEqual(sessions[1].waves?.count, 10, "Session 2 should have 10 waves in relationship")
            XCTAssertEqual(sessions[2].waves?.count, 15, "Session 3 should have 15 waves in relationship")
        } catch {
            XCTFail("Failed to fetch sessions with waves: \(error)")
        }
    }
    
    // MARK: - Test Deleting Session and Cascade Delete Waves
    
    func testDeleteSessionCascadeDeleteWaves() {
        // Create a session with waves
        let session = NSEntityDescription.insertNewObject(forEntityName: "SurfSession", into: context) as! SurfSessionEntity
        session.id = UUID()
        session.startDate = Date()
        session.location = "Delete Test Beach"
        
        // Add waves to the session
        var waveIds: [UUID] = []
        for _ in 1...5 {
            let wave = NSEntityDescription.insertNewObject(forEntityName: "Wave", into: context) as! WaveEntity
            let waveId = UUID()
            wave.id = waveId
            wave.startTime = Date()
            wave.endTime = Date().addingTimeInterval(30)
            wave.session = session
            waveIds.append(waveId)
        }
        
        // Save the context
        do {
            try context.save()
        } catch {
            XCTFail("Failed to save context: \(error)")
            return
        }
        
        // Verify waves were created
        let initialWaveFetchRequest = NSFetchRequest<WaveEntity>(entityName: "Wave")
        do {
            let initialWaves = try context.fetch(initialWaveFetchRequest)
            XCTAssertEqual(initialWaves.count, 5, "Should have 5 waves before deletion")
        } catch {
            XCTFail("Failed to fetch initial waves: \(error)")
            return
        }
        
        // Delete the session
        context.delete(session)
        
        // Save the context after deletion
        do {
            try context.save()
        } catch {
            XCTFail("Failed to save context after deletion: \(error)")
            return
        }
        
        // Verify session is deleted
        let sessionFetchRequest = NSFetchRequest<SurfSessionEntity>(entityName: "SurfSession")
        do {
            let sessionResults = try context.fetch(sessionFetchRequest)
            XCTAssertEqual(sessionResults.count, 0, "Session should be deleted")
        } catch {
            XCTFail("Failed to verify session deletion: \(error)")
            return
        }
        
        // Verify waves are deleted (cascade delete)
        let waveFetchRequest = NSFetchRequest<WaveEntity>(entityName: "Wave")
        do {
            let waveResults = try context.fetch(waveFetchRequest)
            XCTAssertEqual(waveResults.count, 0, "All waves should be deleted with cascade delete")
        } catch {
            XCTFail("Failed to verify wave deletion: \(error)")
        }
    }
} 