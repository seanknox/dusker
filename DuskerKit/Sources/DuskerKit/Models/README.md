# Dusker Core Data Models

This directory contains the Core Data models for the Dusker app, which are used to store surf session data.

## Model Structure

### SurfSession Entity
- Represents a surf session with attributes like start/end time, location, and performance metrics
- Has a one-to-many relationship with Wave entities
- Includes computed properties for derived metrics like duration

### Wave Entity
- Represents an individual wave ridden during a surf session
- Stores data like start/end time, distance, speed, and GPS coordinates
- Has a many-to-one relationship with SurfSession

## Usage Examples

### Initialize Core Data
```swift
// Access the shared CoreDataManager
let coreDataManager = CoreDataManager.shared

// Get the view context
let context = coreDataManager.viewContext
```

### Create and Save a Surf Session
```swift
// Using SurfSessionStore
let sessionStore = SurfSessionStore()
let newSession = sessionStore.createSession(
    startDate: Date(),
    location: "Malibu Beach",
    latitude: 34.0259,
    longitude: -118.7798
)

// Or manually
let session = SurfSessionEntity(context: context)
session.id = UUID()
session.startDate = Date()
session.location = "Malibu Beach"
// Set other properties...
try? context.save()
```

### Add Waves to a Session
```swift
// Using SurfSessionStore
let wave = sessionStore.addWave(
    toSession: session,
    startTime: Date(),
    endTime: Date().addingTimeInterval(30),
    distance: 150.0,
    duration: 30.0,
    maxSpeed: 15.0,
    coordinates: coordinatesData,
    confidence: 0.95
)

// Or manually
let wave = WaveEntity(context: context)
wave.id = UUID()
wave.startTime = Date()
wave.endTime = Date().addingTimeInterval(30)
wave.session = session
// Set other properties...
try? context.save()
```

### Fetch Sessions and Waves
```swift
// Get all sessions
let allSessions = sessionStore.getAllSessions()

// Get a specific session
if let session = sessionStore.getSession(withId: sessionId) {
    // Access session properties
    print(session.location)
    print(session.formattedDuration)
    
    // Access waves
    for wave in session.wavesArray {
        print(wave.maxSpeed)
    }
}

// Get waves for a session
let waves = sessionStore.getWavesForSession(withId: sessionId)
```

### Delete a Session
```swift
// This will also delete all associated waves due to cascade delete rule
sessionStore.deleteSession(session)
```

## Preview Data

For SwiftUI previews and testing, use the PreviewData class:

```swift
// Create a preview context with sample data
let previewContext = PreviewData.createPreviewContext()
PreviewData.createSampleData(in: previewContext)

// Use in SwiftUI previews
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PreviewData.createPreviewContext()
        PreviewData.createSampleData(in: context)
        return MyView().environment(\.managedObjectContext, context)
    }
}
``` 