# Prompt Plan

## Prompt 1: Project Setup

Create a new SwiftUI project for a Surf Tracking Apple Watch app with the following specifications:

1. Project name: SurfTracker
2. Include both watchOS and iOS targets
3. Set up a shared framework for code that will be used by both targets
4. Configure the project with SwiftUI as the UI framework
5. Set minimum OS versions to iOS 16.0 and watchOS 9.0
6. Set up a basic project structure with folders for:
   - Models
   - Views
   - ViewModels
   - Services
   - Utilities
   - Extensions
7. Create a shared Assets catalog with a basic color palette:
   - Primary background: #0A1A2A
   - Accent color: #F89B45
   - Text color (light): #FFFFFF
   - Text color (dark): #222222
8. Create a simple app icon placeholder
9. Add a basic Info.plist with required permissions:
   - Location usage description
   - Health sharing description
   - Motion usage description

For testing:
1. Set up a basic XCTest structure
2. Create a simple test case to verify the project builds correctly

Provide the full project structure and all necessary configuration files.

## Prompt 2: Core Data Models

Building on our SurfTracker project, implement the Core Data models needed for storing surf session data. Create the following models and relationships:

1. Create a CoreDataManager class responsible for handling the persistent container and context
2. Create the SurfSession entity with the following attributes:
   - id: UUID
   - startDate: Date
   - endDate: Date (optional)
   - location: String
   - latitude: Double
   - longitude: Double
   - totalWaves: Int32
   - maxSpeed: Double
   - avgHeartRate: Double
   - distanceSurfed: Double
   - distancePaddled: Double
   - strokeCount: Int32
   - notes: String (optional)
   - isUploaded: Boolean (default: false)

3. Create the Wave entity with the following attributes:
   - id: UUID
   - startTime: Date
   - endTime: Date
   - distance: Double
   - duration: Double
   - maxSpeed: Double
   - coordinates: Binary Data (to store GPS coordinates)
   - confidence: Double (detection confidence score)

4. Set up a one-to-many relationship between SurfSession and Wave
5. Create preview sample data for testing

6. Write unit tests for:
   - Creation and saving of a SurfSession
   - Adding waves to a session
   - Fetching sessions with waves
   - Deleting a session and ensuring waves are cascaded

Ensure all models conform to Identifiable and provide computed properties for derived metrics.

## Prompt 3: Basic UI Navigation Structure

Now that we have our Core Data models set up, let's create the basic UI navigation structure for both the watchOS and iOS apps.

For watchOS:
1. Create a MainView as the entry point with:
   - A "Start Session" button
   - Navigation link to "History" view
   - Navigation link to "Settings" view
2. Create a SessionHistoryView that displays a list of past sessions
3. Create a SettingsView placeholder
4. Set up a TabView for the session view that will display:
   - Wave count
   - Duration
   - Heart rate
   - Distance

For iOS:
1. Create a TabView with the following tabs:
   - Sessions (list of all surf sessions)
   - Stats (placeholder for future statistics)
   - Settings (placeholder)
2. Create a SessionListView that displays sessions with:
   - Date
   - Location
   - Duration
   - Wave count
3. Create a SessionDetailView placeholder
4. Add navigation from the SessionListView to the SessionDetailView

For both platforms:
1. Create a shared ViewModifier for consistent styling
2. Implement a common color scheme
3. Set up preview providers for all views

Include unit tests for:
1. Navigation flow
2. Correct data passing between views
3. UI rendering tests for main components

Make sure all UI elements follow accessibility best practices and support Dynamic Type.

## Prompt 4: Local Storage Implementation
Building on our Core Data models and UI structure, implement the local storage functionality for the SurfTracker app:

1. Create a PersistenceController singleton class that:
   - Manages the Core Data stack
   - Provides access to the viewContext
   - Includes methods for background context operations
   - Handles migrations if needed
   - Provides preview context with sample data

2. Implement CRUD operations for SurfSession:
   - fetchSessions(limit: Int? = nil, predicate: NSPredicate? = nil) -> [SurfSession]
   - saveSession(_ session: SurfSession) -> Bool
   - deleteSession(_ session: SurfSession) -> Bool
   - updateSession(_ session: SurfSession) -> Bool

3. Implement CRUD operations for Wave:
   - fetchWaves(forSession session: SurfSession) -> [Wave]
   - saveWave(_ wave: Wave, toSession session: SurfSession) -> Bool
   - deleteWave(_ wave: Wave) -> Bool

4. Create a StorageManager protocol that abstracts the persistence operations:
   - Define protocol methods matching the CRUD operations
   - Create a CoreDataStorageManager implementation
   - Add ability to easily swap persistence mechanisms

5. Implement error handling:
   - Create custom StorageError enum cases
   - Add result types to return success/failure with error details

6. Create the following unit tests:
   - Test creating, reading, updating, and deleting sessions
   - Test wave relationship management
   - Test error handling for invalid operations
   - Test concurrent access and potential race conditions
   - Test sample data generation for previews

7. Create integration tests that:
   - Verify UI components correctly fetch and display stored data
   - Test the full cycle of creating, viewing, and deleting sessions

Ensure thread safety when accessing Core Data and provide methods for both synchronous and asynchronous operations.

## Prompt 5: Location Services
Now, let's implement location services for the SurfTracker app to track GPS data during surf sessions:

1. Create a LocationManager class that:
   - Conforms to NSObject and implements CLLocationManagerDelegate
   - Provides location authorization management
   - Handles location updates with configurable accuracy
   - Filters out inaccurate readings
   - Provides computed properties for current location, speed, and course
   - Uses Combine publishers for reactive updates

2. Implement GPS coordinate storage:
   - Create a GPSCoordinate struct with latitude, longitude, timestamp, speed, accuracy
   - Implement methods to convert between GPSCoordinate and CLLocation
   - Create an efficient storage format for arrays of coordinates (for Wave entity)

3. Create a LocationPermissionService:
   - Handles requesting appropriate permissions
   - Provides UI for explaining permission requirements
   - Manages "When In Use" vs "Always" permission states
   - Handles degraded location accuracy scenarios

4. Implement background location updates:
   - Configure proper Info.plist settings
   - Add code to manage background location updates
   - Handle suspension and resumption of location services

5. Add location helper utilities:
   - Distance calculation between coordinates
   - Speed calculation
   - Heading/bearing calculation
   - Location accuracy filtering

6. Create the following unit tests:
   - Test location permission workflows
   - Test GPS coordinate conversion and storage
   - Test distance and speed calculations
   - Test filtering of inaccurate readings

7. Create mock implementation for testing:
   - MockLocationManager that provides simulated coordinates
   - Test data generator for simulated surf sessions

8. Update the UI to:
   - Show current location information in the session view
   - Display permission status in settings
   - Provide a way to request permissions

All location services should be battery-efficient, as is possible.

## Prompt 6: Motion Sensor Framework

Let's implement the motion sensor framework that will be crucial for wave detection in our SurfTracker app:

1. Create a MotionManager class that:
   - Manages access to device motion sensors (accelerometer, gyroscope)
   - Uses CMMotionManager for data collection
   - Configures appropriate update intervals for battery efficiency
   - Provides Combine publishers for motion data updates
   - Filters noise from raw sensor data

2. Implement motion data structures:
   - Create a MotionSample struct to hold acceleration and rotation data with timestamp
   - Add methods to calculate orientation changes from gyroscope data
   - Add methods to detect significant motion events

3. Create a motion recording service:
   - Enable starting/stopping motion data recording
   - Store motion samples efficiently (considering memory usage)
   - Provide functions to analyze recorded motion patterns
   - Use appropriate sampling rates for different activities

4. Implement motion data processing utilities:
   - Low-pass filtering for smoothing accelerometer data
   - Peak detection for identifying paddle strokes
   - Orientation change detection for stand-up moments
   - Motion pattern classification (paddling, riding, idle)

5. Add power management:
   - Adaptive sampling rates based on activity
   - Pause collection during periods of inactivity
   - Resume collection when motion is detected

6. Create unit tests for:
   - Motion data processing algorithms
   - Filtering utilities
   - Pattern recognition functions
   - Battery usage optimization

7. Create mock implementations for testing:
   - MockMotionManager providing simulated data
   - Test data sets for different surf scenarios

8. Update the ViewModel to:
   - Connect motion data to session recording
   - Store relevant motion samples with waves
   - Provide motion state to the UI

Ensure the implementation is optimized for watchOS battery life while maintaining sufficient data for accurate wave detection.

## Prompt 7: Heart Rate Monitoring

Now, let's implement heart rate monitoring for the SurfTracker app to track physical exertion during surf sessions:

1. Create a HeartRateManager class that:
   - Uses HKHealthStore to access heart rate data
   - Configures heart rate queries with appropriate filters
   - Provides real-time heart rate updates via Combine publishers
   - Calculates rolling averages and zones
   - Handles background reading continuation

2. Implement heart rate data structures:
   - Create a HeartRateSample struct with value, timestamp, and metadata
   - Implement heart rate zone calculation (rest, fat burn, cardio, peak)
   - Add methods for statistical analysis (min, max, avg, variability)

3. Create heart rate visualization components:
   - Implement a HeartRateView that shows current BPM
   - Create a zone indicator with color coding
   - Add a heart rate graph for session summary

4. Implement HealthKit authorization handling:
   - Request appropriate permissions
   - Handle authorization state changes
   - Gracefully degrade functionality if permissions denied

5. Add heart rate data analysis:
   - Calculate calories burned based on heart rate
   - Identify exertion periods during session
   - Correlate heart rate with wave riding

6. Create unit tests for:
   - Heart rate data processing
   - Zone calculations
   - Energy expenditure estimations
   - Permission handling flows

7. Create mock implementations for testing:
   - MockHeartRateManager providing simulated data
   - Test data generator for various intensity profiles

8. Update the UI to:
   - Display current heart rate during sessions
   - Show heart rate zones with visual indicators
   - Include heart rate statistics in session summary

Ensure heart rate monitoring is battery-efficient and continues reliably throughout surf sessions. 

## Prompt 8: Sensor Data Integration

Let's integrate all our sensor components (location, motion, heart rate) into a unified SensorManager for the SurfTracker app:

1. Create a SensorDataManager protocol that defines:
   - Methods to start/stop all sensors
   - Access to latest sensor values
   - Configuration options for sampling rates
   - Battery optimization settings

2. Implement a concrete SensorDataManagerImpl class that:
   - Composes LocationManager, MotionManager, and HeartRateManager
   - Coordinates startup and shutdown sequences
   - Manages sensor state (active, background, inactive)
   - Handles sensor failures gracefully

3. Create a SensorDataSample struct that combines:
   - Location data (coordinates, speed, course)
   - Motion data (acceleration, rotation)
   - Heart rate data
   - Timestamp and metadata

4. Implement sensor data fusion algorithms:
   - Correlate data from multiple sensors by timestamp
   - Implement a sensor fusion pipeline
   - Apply Kalman filtering for improved accuracy
   - Handle missing data from any sensor

5. Create a SensorDataRecorder service that:
   - Efficiently records integrated sensor data during sessions
   - Uses appropriate data structures for storage
   - Implements data compression for long sessions
   - Provides methods to extract relevant segments

6. Add diagnostic and calibration features:
   - Sensor accuracy assessment
   - Calibration workflows if needed
   - Diagnostic data logging for debugging

7. Create unit tests for:
   - Sensor integration and coordination
   - Data fusion algorithms
   - Recording and retrieval efficiency
   - Error handling and recovery

8. Create integration tests that:
   - Verify all sensors work together
   - Test performance under various conditions
   - Validate battery usage

9. Update the SessionViewModel to:
   - Initialize and manage the SensorDataManager
   - Record and store sensor data with sessions
   - Use sensor data for real-time UI updates

Ensure the integrated solution is resilient to sensor failures and optimizes for both accuracy and battery life.

## Prompt 9: Session Controller

Let's implement the session management functionality for the SurfTracker app:

1. Create a SessionController class responsible for:
   - Starting a new surf session
   - Pausing/resuming a session
   - Ending a session
   - Managing the session lifecycle
   - Handling app state changes (background/foreground)

2. Implement a SessionState enum:
   - NotStarted
   - Active
   - Paused
   - Finished
   - Error (with associated error)

3. Create a SessionViewModel that:
   - Observes the SessionController
   - Provides session state to the UI
   - Formats session data for display
   - Handles user interactions

4. Implement Apple Watch Water Lock integration:
   - Enable Water Lock when session starts
   - Handle Water Lock exit gracefully
   - Resume session appropriately after Water Lock

5. Add Action Button support for Apple Watch Ultra:
   - Map Action Button to session start/stop
   - Create configurator for system settings
   - Handle button press events

6. Create background session continuation:
   - Implement watchOS background workout session
   - Handle app termination and relaunch
   - Recover session state after relaunch

7. Create session persistence:
   - Save session state periodically
   - Implement auto-save on app transitions
   - Create recovery mechanism for interrupted sessions

8. Create unit tests for:
   - Session state transitions
   - Background handling
   - Water Lock integration
   - Action Button handling

9. Create UI components for session control:
   - Start session button
   - In-progress session controls
   - End session confirmation
   - Session resumption prompt

10. Update the CoreData integration to:
    - Create session entity on start
    - Update entity throughout session
    - Finalize entity on session end

Ensure that session management is robust against app termination, device reboots, and other edge cases.

## Prompt 10: Basic Session UI

Now, let's create the basic session UI components for the SurfTracker app:

1. For the watchOS app, create the following views:
   - SessionStartView with:
     - Large "Start Session" button
     - Current conditions display (placeholder)
     - Quick access to settings
   - ActiveSessionView with:
     - Time elapsed (HH:MM:SS)
     - Wave count with icon
     - Current heart rate
     - Distance surfed
     - Swipeable pages for additional metrics
   - SessionEndView with:
     - Session summary
     - Save/discard options
     - Quick note entry

2. For the iOS app, create:
   - SessionSummaryView showing:
     - Map with session location
     - Session duration and date
     - Wave count and statistics
     - Heart rate graph
     - Distance metrics

3. Implement common UI components:
   - MetricCard for displaying individual metrics
   - WaveCounter for visualizing wave count
   - SessionTimer for elapsed time
   - HeartRateDisplay with zone indicators

4. Create animations and transitions:
   - Smooth transition between session states
   - Celebrations for achievements (like best wave)
   - Subtle loading indicators for background operations

5. Implement accessibility:
   - VoiceOver support for all metrics
   - Dynamic Type for text elements
   - Appropriate contrast ratios
   - Haptic feedback for important events

6. Create watch-specific UI adaptations:
   - Simplified layouts for different watch sizes
   - Optimized touch targets for wet fingers
   - Always-on display support for active sessions

7. Add UI tests for:
   - Session start workflow
   - Metric display accuracy
   - Navigation between session phases
   - Accessibility compliance

8. Connect the UI to the SessionViewModel:
   - Bind UI elements to view model properties
   - Handle UI events with view model methods
   - Update displays based on session state changes

Ensure the UI is clean, focused, and highly readable in outdoor conditions.

## Prompt 11: Session Storage

Let's enhance our session functionality with robust storage capabilities:

1. Expand the SessionStore service to:
   - Save ongoing session data at regular intervals
   - Provide recovery for interrupted sessions
   - Handle session draft vs. complete sessions
   - Implement batch operations for efficiency

2. Create a SessionRepository protocol with:
   - func createSession() -> SurfSession
   - func saveSession(_ session: SurfSession) -> Result<SurfSession, Error>
   - func loadSession(id: UUID) -> Result<SurfSession, Error>
   - func loadRecentSessions(limit: Int) -> Result<[SurfSession], Error>
   - func updateSession(_ session: SurfSession) -> Result<SurfSession, Error>
   - func deleteSession(_ session: SurfSession) -> Result<Void, Error>

3. Implement a CoreDataSessionRepository conforming to the protocol:
   - Use our existing CoreData stack
   - Add efficient query methods with NSPredicates
   - Implement proper error handling
   - Support background thread operations

4. Create models for session filtering and sorting:
   - SessionFilter with date range, location, metrics filters
   - SessionSortOption enum (date, duration, waves, etc.)
   - Filtering and sorting extension methods

5. Implement a SessionHistoryViewModel:
   - Load sessions with pagination
   - Apply filters and sorting
   - Track session selection
   - Handle deletion and updates

6. Create a SessionHistoryView for iOS:
   - List of sessions with summary information
   - Filter and sort controls
   - Pull-to-refresh functionality
   - Swipe actions for common operations

7. Create a SessionHistoryView for watchOS:
   - Simplified list optimized for watch display
   - Quick actions for session selection
   - Clear loading indicators

8. Implement session export functionality:
   - Generate session summary as shareable image
   - Create JSON export format
   - Add export options to session detail view

9. Add unit tests for:
   - Repository CRUD operations
   - Filtering and sorting logic
   - Data integrity during interruptions
   - Export functionality

Ensure the storage implementation is robust, with proper error handling and recovery mechanisms.

## Prompt 12: Session Metrics Calculation

Let's implement the session metrics calculation functionality for the SurfTracker app:

1. Create a MetricsCalculator protocol with methods for:
   - calculateDistance(from coordinates: [GPSCoordinate]) -> Double
   - calculateSpeed(from coordinates: [GPSCoordinate]) -> Double
   - calculateMaxSpeed(from coordinates: [GPSCoordinate]) -> Double
   - calculatePaddleDistance(from motionData: [MotionSample]) -> Double
   - calculateStrokeCount(from motionData: [MotionSample]) -> Int
   - calculateHeartRateZones(from heartRateData: [HeartRateSample]) -> HeartRateZones

2. Implement a DefaultMetricsCalculator conforming to the protocol:
   - Use Haversine formula for accurate distance calculation
   - Apply smoothing algorithms for speed calculation
   - Implement stroke detection algorithm for paddle counts
   - Calculate energy expenditure based on heart rate

3. Create data models for metrics:
   - SessionMetrics struct containing all calculated metrics
   - WaveMetrics struct for individual wave statistics
   - HeartRateZones struct with time spent in each zone
   - ActivityMetrics for overall activity (paddling, riding, waiting)

4. Implement real-time metrics calculation:
   - Create a LiveMetricsService that updates as new data arrives
   - Use efficient algorithms suitable for real-time computation
   - Provide Combine publishers for metric updates

5. Create summary metrics calculation:
   - Implement algorithms for session-end summary statistics
   - Add trending and comparison to previous sessions
   - Calculate personal records and achievements

6. Add visualization components:
   - MetricsChart for displaying time-series data
   - HeartRateZoneView showing time in zones
   - ActivityBreakdownView showing time allocation
   - SpeedGraph for wave speed visualization

7. Create unit tests for:
   - Distance calculation accuracy
   - Speed calculation with various sampling rates
   - Stroke counting algorithm
   - Heart rate zone calculation

8. Create benchmarks for performance:
   - Test calculation speed for various session lengths
   - Measure memory usage during calculation
   - Verify battery impact of real-time calculations

Ensure all calculations are accurate, efficient, and handle edge cases appropriately.

## Prompt 13: Motion Pattern Recognition
Now, let's implement motion pattern recognition for detecting paddle, stand-up, and wave riding motions in the SurfTracker app:

1. Create a MotionPatternRecognizer protocol defining:
   - func detectPaddleMotion(in samples: [MotionSample]) -> [TimeRange]
   - func detectStandUpMotion(in samples: [MotionSample]) -> [TimePoint]
   - func detectRidingMotion(in samples: [MotionSample], with location: [LocationSample]) -> [TimeRange]
   - func detectWaitingMotion(in samples: [MotionSample]) -> [TimeRange]

2. Implement a MachineLearningMotionRecognizer that:
   - Uses Core ML for pattern recognition
   - Processes batches of motion samples
   - Identifies key surfing motion patterns
   - Returns time ranges/points for each pattern

3. Create a simpler HeuristicMotionRecognizer that:
   - Uses threshold-based algorithms for detection
   - Analyzes acceleration patterns for paddling
   - Detects orientation changes for stand-up
   - Combines with speed data for riding confirmation
   - Can be used as fallback or for devices without ML capabilities

4. Implement motion pattern data structures:
   - Create MotionPattern enum (paddling, standUp, riding, waiting)
   - Create MotionEvent struct with pattern type, start/end time, confidence
   - Add methods to correlate events with location data

5. Create preprocessing pipeline for motion data:
   - Implement signal filtering (low-pass, high-pass)
   - Add gravity removal from acceleration
   - Create feature extraction for ML model
   - Implement data normalization

6. Add motion pattern visualization:
   - Create SessionActivityView showing activity timeline
   - Implement color-coding for different activities
   - Add detailed motion analysis view

7. Implement sensitivity settings:
   - Create configurable detection thresholds
   - Implement sensitivity presets (low, medium, high)
   - Add custom sensitivity configuration

8. Write comprehensive unit tests:
   - Test detection accuracy with known patterns
   - Verify integration with location data
   - Test sensitivity configuration
   - Benchmark performance

Create test data sets covering various surfing scenarios for algorithm validation.

## Prompt 14: Wave Detection Service

Let's implement the core wave detection service that will combine motion patterns with GPS data:

1. Create a WaveDetectionService protocol defining:
   - func startDetection()
   - func stopDetection()
   - func getDetectedWaves() -> [Wave]
   - var waveDetected: PassthroughSubject<Wave, Never> { get }
   - var settings: WaveDetectionSettings { get set }

2. Implement a DefaultWaveDetectionService that:
   - Uses MotionPatternRecognizer for motion patterns
   - Combines with LocationManager for speed validation
   - Implements real-time wave detection algorithm
   - Publishes wave detection events
   - Stores detected waves for the session

3. Create a WaveDetectionSettings struct with:
   - sensitivity: DetectionSensitivity (low, medium, high, custom)
   - minWaveDuration: TimeInterval
   - minWaveDistance: Double
   - minWaveSpeed: Double
   - paddleToStandThreshold: Double
   - orientationChangeThreshold: Double
   - Custom thresholds for advanced configuration

4. Implement the wave detection algorithm:
   1. Monitor for paddle motion patterns
   2. Detect sudden orientation change (stand up)
   3. Verify with speed increase from GPS
   4. Track continuation of riding motion
   5. Detect end of wave when speed drops
   6. Calculate wave metrics and confidence score

5. Create a wave validation system:
   - Implement confidence scoring for detected waves
   - Create validation rules based on physics
   - Add options for manual review of low-confidence waves

6. Add wave detection visualization:
   - Create ActiveWaveIndicator for current wave
   - Implement WaveListView for detected waves
   - Add wave playback visualization

7. Implement wave storage:
   - Store wave data with start/end times
   - Save GPS track for each wave
   - Include motion data samples for each wave
   - Calculate and store wave metrics

8. Create comprehensive testing:
   - Unit tests for detection algorithm components
   - Integration tests with simulated sensor data
   - Performance tests for real-time detection
   - Accuracy validation with recorded sessions

Ensure the implementation is efficient enough for real-time use on the Apple Watch while maintaining high detection accuracy.

## Prompt 15: Wave Storage and Retrieval

Now, let's enhance our wave storage and retrieval capabilities for the SurfTracker app:

1. Create a WaveRepository protocol defining:
   - func saveWave(_ wave: Wave, for session: SurfSession) -> Result<Wave, Error>
   - func loadWaves(for session: SurfSession) -> Result<[Wave], Error>
   - func loadWave(id: UUID) -> Result<Wave, Error>
   - func updateWave(_ wave: Wave) -> Result<Wave, Error>
   - func deleteWave(_ wave: Wave) -> Result<Void, Error>

2. Implement a CoreDataWaveRepository conforming to the protocol:
   - Use our existing CoreData stack
   - Add efficient query methods with NSPredicates
   - Implement proper error handling
   - Support background thread operations

3. Create optimized storage for GPS tracks:
   - Implement a coordinate compression algorithm for efficient storage
   - Create a binary format for storing coordinates in Core Data
   - Add methods to convert between compressed storage and usable formats
   - Include metadata with compression details

4. Implement a WaveViewModel that:
   - Loads wave data from the repository
   - Provides formatted wave metrics for display
   - Handles wave selection and navigation
   - Tracks state for wave detail view

5. Create wave visualization components:
   - WaveTrackView showing GPS track on map
   - WaveMetricsView displaying stats (speed, distance, duration)
   - WaveTimelineView showing waves in session context
   - WaveComparisonView for comparing multiple waves

6. Add batch operations for efficiency:
   - Implement bulk load/save for waves
   - Add caching for frequently accessed waves
   - Create background fetching for wave lists

7. Implement wave data analysis:
   - Calculate wave quality score based on metrics
   - Add classification for wave types
   - Implement trending to compare waves over time
   - Create data visualizations for wave patterns

8. Create the UI for wave management:
   - WaveListView showing waves for a session
   - WaveDetailView with map and metrics
   - WaveEditorView for adjusting wave data
   - WaveFilterView for sorting and filtering

9. Write unit tests for:
   - Repository CRUD operations
   - Coordinate compression/decompression
   - Wave metric calculations
   - Model conversions

Ensure all operations are optimized for watchOS performance and battery life.

## Prompt 16: Wave Detection Refinement

Let's refine our wave detection algorithm to improve accuracy and add configurability:

1. Enhance the WaveDetectionSettings with:
   - Add a TuningProfile struct for storing named configurations
   - Create presets for different surf styles (shortboard, longboard, SUP)
   - Add advanced parameters for fine-tuning detection
   - Implement profile saving and loading

2. Refine the motion pattern detection:
   - Implement multi-stage detection pipeline
   - Add confidence scoring for each pattern
   - Create heuristics to reduce false positives
   - Implement adaptive thresholds based on conditions

3. Create a wave detection debug mode:
   - Add detailed logging of detection events
   - Create a visual timeline of detection stages
   - Save raw sensor data for problematic detections
   - Implement on-device debugging views

4. Add manual wave editing:
   - Create interface for adding missed waves
   - Implement tools to adjust wave start/end points
   - Add wave merging/splitting functionality
   - Create a simple review system for low-confidence waves

5. Implement calibration workflows:
   - Create a session calibration mode
   - Add automated threshold adjustment
   - Implement learning from user corrections
   - Save calibration profiles per board/conditions

6. Enhance noise filtering:
   - Add advanced signal processing filters
   - Implement outlier detection and removal
   - Create adaptive filtering based on conditions
   - Optimize for different motion patterns

7. Improve GPS integration:
   - Implement smarter GPS sampling during wave rides
   - Add fallback detection when GPS is unreliable
   - Create specialized noise filtering for ocean environment
   - Optimize GPS/motion data fusion

8. Create comprehensive test suite:
   - Add tests for edge cases (short waves, wipeouts)
   - Create validation against manually tagged sessions
   - Implement performance benchmarking
   - Add battery usage measurements

Ensure all refinements maintain backwards compatibility with existing data.

## Prompt 17: HealthKit Authorization

Let's implement HealthKit integration for the SurfTracker app, starting with authorization:

1. Create a HealthKitManager class responsible for:
   - Requesting necessary HealthKit permissions
   - Checking authorization status
   - Managing authorization state changes
   - Providing access to health data types

2. Implement the following HealthKit permissions:
   - Read access to heart rate data
   - Read/write access for workout data
   - Read access to active energy burned
   - Write access for surfing workout type

3. Create a HealthKitAuthorizationView:
   - Clear explanation of benefits
   - Visual representation of requested data types
   - Simple permission request buttons
   - Alternative flows if permissions denied

4. Implement a HealthKitViewModel:
   - Track authorization status
   - Handle permission requests
   - Provide UI state for authorization views
   - Implement error handling for authorization failures

5. Create authorization utilities:
   - Granular permission requests
   - Permission request retry logic
   - Limited functionality mode for partial permissions
   - Clear user messaging about missing permissions

6. Add integration with app settings:
   - Health integration toggle in settings
   - Permission management section
   - Data sharing preferences
   - Privacy explanation screen

7. Implement graceful degradation:
   - Fallback heart rate calculation if not available
   - Alternative calorie estimation methods
   - Clear UI indicators for unavailable data
   - Prompts to enable permissions when relevant

8. Write unit tests for:
   - Authorization request workflows
   - Status change handling
   - UI state management
   - Error scenarios

Ensure all HealthKit usage complies with Apple's privacy guidelines and provide clear user communication about data usage.

## Prompt 18: Workout Session Recording

Now, let's implement workout session recording with HealthKit for the SurfTracker app:

1. Create a WorkoutSessionManager class that:
   - Creates and manages HKWorkoutSession
   - Handles workout lifecycle (start, pause, resume, end)
   - Manages workout state during app lifecycle events
   - Saves completed workouts to HealthKit

2. Implement a WorkoutConfiguration:
   - Set location type to outdoor
   - Configure for surfing activity type
   - Set appropriate display settings
   - Configure for swimming mode when available

3. Create a LiveWorkoutDataStore that:
   - Collects heart rate during workout
   - Tracks active and resting energy
   - Records distance metrics
   - Handles sensor data collection

4. Implement workout builders:
   - Create HKWorkoutBuilder configuration
   - Add appropriate workout events
   - Include route data for waves
   - Set correct metadata and workout type

5. Add HealthKit sample generators:
   - Create heart rate samples from recorded data
   - Generate distance samples for paddling/riding
   - Create energy burned samples
   - Add swim stroke count samples

6. Implement workout summary creation:
   - Calculate total statistics for the session
   - Generate workout summary view
   - Create sharing options for workout data
   - Add comparison with previous workouts

7. Create workout state synchronization:
   - Sync SurfSession state with HKWorkoutSession
   - Handle transitions between states
   - Manage recovery from interruptions
   - Ensure data consistency between systems

8. Write comprehensive tests:
   - Test workout lifecycle management
   - Verify sample generation accuracy
   - Test state synchronization
   - Validate summary calculation

Ensure the implementation follows Apple's best practices for HealthKit workout sessions.

## Prompt 19: Health Data Integration

Let's integrate health data more deeply into the SurfTracker app:

1. Create a HealthDataIntegrator class that:
   - Retrieves relevant health data for context
   - Correlates health metrics with surf performance
   - Provides insights based on health trends
   - Calculates surfing-specific fitness metrics

2. Implement health data retrieval for:
   - Recent cardio fitness level (VO2 max)
   - Resting heart rate trends
   - Recovery heart rate patterns
   - Overall activity levels

3. Create health-based insights:
   - Generate fatigue level estimates
   - Calculate optimal session duration based on fitness
   - Identify performance trends correlated with health metrics
   - Provide recovery recommendations

4. Implement a HealthInsightsView:
   - Visualize health data relevant to surfing
   - Show performance correlations
   - Display recovery status
   - Provide actionable insights

5. Add health data visualization components:
   - HeartRateVariabilityChart for recovery tracking
   - FitnessLevelView for cardio fitness trends
   - RecoveryIndicator for session readiness
   - PerformanceTrendView correlating health and surfing

6. Create a health data dashboard:
   - Summary of surf-relevant health metrics
   - Recent trends visualization
   - Session readiness indicator
   - Performance predictions

7. Implement health data export:
   - Export surf workout data to third-party fitness apps
   - Create shareable health and performance reports
   - Generate progress tracking visualizations
   - Add health data to session summaries

8. Write tests for:
   - Health data retrieval accuracy
   - Insight generation algorithms
   - Data privacy and permissions
   - UI rendering with various health data states

Ensure all health integrations respect user privacy and provide actionable, relevant information for surfers.

## Prompt 20: Session List View

Let's create a comprehensive session list view for the iOS app:

1. Create a SessionListViewModel that:
   - Loads sessions from the repository
   - Handles filtering and sorting
   - Manages selection and navigation
   - Provides formatted data for display

2. Implement a SessionListView with:
   - Clean, card-based layout for sessions
   - Summary information (date, location, waves, duration)
   - Visual indicators for session quality
   - Pull-to-refresh and infinite scrolling
   - Sticky headers for date grouping

3. Add filtering and sorting:
   - Create a FilterBarView with common filters
   - Implement an advanced FilterSheetView
   - Add sorting options (date, waves, duration, location)
   - Create filter persistence between app launches

4. Implement list organization:
   - Group sessions by month/year
   - Add location grouping option
   - Create favorites system
   - Implement tags/categories for sessions

5. Add list interactions:
   - Swipe actions for common operations
   - Long-press context menu
   - Multi-select mode for batch operations
   - Drag and drop for manual ordering

6. Create visual enhancements:
   - Session thumbnail maps
   - Wave count visualization
   - Performance indicator icons
   - Weather condition icons

7. Implement search functionality:
   - Full-text search across sessions
   - Search by date, location, tags
   - Recent searches storage
   - Search suggestions

8. Add list customization:
   - Configurable display density
   - Custom sort/filter presets
   - Display preferences (metrics to show)
   - List view vs. grid view toggle

9. Write tests for:
   - List loading and pagination
   - Filtering and sorting logic
   - Search functionality
   - UI interactions

Ensure the list view is performant even with hundreds of sessions and implements all iOS list view best practices.

## Prompt 21: Session Detail View

Now, let's implement a comprehensive session detail view for the iOS app:

1. Create a SessionDetailViewModel that:
   - Loads complete session data with waves
   - Calculates detailed session metrics
   - Manages view state and navigation
   - Handles user interactions

2. Implement a SessionDetailView with a tabbed interface:
   - Overview tab with key metrics and map
   - Waves tab with wave list and details
   - Insights tab with performance analysis
   - Health tab with heart rate and exertion data

3. Create the Overview tab with:
   - Header with location, date, and duration
   - Map view showing session area and wave tracks
   - Key metrics cards (waves, distance, speed)
   - Weather/conditions summary
   - Session notes section

4. Implement the Waves tab with:
   - Wave list sorted by time
   - Wave metrics for each entry
   - Wave selection for detailed view
   - Wave comparison tool
   - Wave track visualization

5. Create the Insights tab with:
   - Performance trends visualization
   - Session comparison with average/best
   - Activity breakdown chart
   - Suggested improvements

6. Implement the Health tab with:
   - Heart rate graph with zones
   - Calories burned metrics
   - Exertion level visualization
   - Recovery recommendation

7. Add sharing functionality:
   - Generate shareable session summary
   - Export session data options
   - Share individual waves
   - Create custom share layouts

8. Implement editing capabilities:
   - Session metadata editor
   - Wave management tools
   - Note taking interface
   - Tag/categorization system

9. Write tests for:
   - Detail view loading and display
   - Tab navigation and state preservation
   - Metric calculations
   - Sharing functionality

Ensure the detail view provides comprehensive information while maintaining a clean, intuitive interface.

## Prompt 22: Map Visualization

Let's implement advanced map visualization for the SurfTracker app:

1. Create a SessionMapViewModel that:
   - Manages map state and configuration
   - Loads and processes GPS data for display
   - Handles user interactions with the map
   - Controls visualization options

2. Implement a SessionMapView using MapKit:
   - Display session location with custom annotation
   - Show wave tracks with distinct styling
   - Implement paddle path visualization
   - Add heat map for activity intensity

3. Create specialized map annotations:
   - SessionLocationAnnotation with session info
   - WaveStartAnnotation for wave takeoff points
   - WaveEndAnnotation for wave end points
   - Custom annotation clusters for dense sessions

4. Implement track visualization:
   - Create colored polylines for waves based on speed
   - Style paddle paths differently from wave rides
   - Add animation options for playback
   - Implement time-based track filtering

5. Add map control UI:
   - Layer toggle controls (waves, paddle paths, heatmap)
   - Time slider for session playback
   - Wave selection tools
   - Map style options (standard, satellite, hybrid)

6. Create a wave playback system:
   - Step-by-step wave ride visualization
   - Speed indicator during playback
   - Timeline marker for current position
   - Playback controls (play, pause, speed)

7. Implement map optimization:
   - Efficient rendering for long sessions
   - Level-of-detail management for tracks
   - Memory optimization for large datasets
   - Caching strategy for map data

8. Add interactive features:
   - Tap on track for details
   - Wave selection and highlighting
   - Pinch-to-zoom on waves
   - Measurement tools

9. Write tests for:
   - Map rendering performance
   - Track visualization accuracy
   - User interaction handling
   - Memory usage optimization

Ensure the map visualization is performant even with complex sessions and provides meaningful insights into the surf session. Prefer Non-Google map services like Mapbox.

## Prompt 23: Insights and Analytics
Let's implement an insights and analytics system for the SurfTracker app:

1. Create an AnalyticsEngine class that:
   - Processes historical session data
   - Calculates trends and patterns
   - Identifies performance insights
   - Generates recommendations

2. Implement data analysis algorithms:
   - Session performance scoring
   - Wave quality assessment
   - Progress tracking over time
   - Pattern recognition for surf style

3. Create an InsightsViewModel that:
   - Provides formatted insights data
   - Manages insight categories and filtering
   - Handles user interaction with insights
   - Updates as new sessions are added

4. Implement visualization components:
   - TrendChartView for metrics over time
   - PerformanceRadarView for skill breakdown
   - ProgressBarView for goal tracking
   - ComparisonChartView for benchmarking

5. Create insight categories:
   - Performance insights (speed, wave count, etc.)
   - Activity insights (paddle efficiency, wait time)
   - Location insights (spot performance comparison)
   - Health insights (exertion, recovery patterns)

6. Implement a recommendation engine:
   - Generate actionable recommendations
   - Provide personalized surf tips
   - Suggest optimal conditions based on history
   - Identify areas for improvement

7. Create an InsightsView with:
   - Dashboard of key insights
   - Categorized insight browsing
   - Detailed insight expansion
   - Interactive data exploration

8. Add goal tracking:
   - Custom goal setting interface
   - Progress visualization
   - Achievement celebration
   - Goal recommendation based on performance

9. Write tests for:
   - Analysis algorithm accuracy
   - Insight generation logic
   - Visualization rendering
   - Recommendation relevance

Ensure the insights are actionable, relevant to surfers, and presented in an intuitive, visually appealing way.

## Prompt 24: iCloud Setup

Let's implement iCloud integration for the SurfTracker app to enable cross-device synchronization:

1. Create a CloudKitManager class responsible for:
   - Setting up CloudKit container and database
   - Managing public vs. private database access
   - Handling account status changes
   - Implementing retry and error handling logic

2. Define CloudKit record types:
   - CKSessionRecord with session attributes
   - CKWaveRecord with wave data
   - CKUserSettingsRecord for app settings
   - CKSyncMetadataRecord for tracking sync state

3. Implement record conversion utilities:
   - Convert between Core Data entities and CK records
   - Handle relationship mapping
   - Implement efficient binary data conversion
   - Add metadata for sync conflict resolution

4. Create a sync token management system:
   - Track last sync timestamps
   - Store and retrieve server change tokens
   - Implement incremental sync for efficiency
   - Handle token invalidation scenarios

5. Set up CloudKit subscriptions:
   - Register for remote change notifications
   - Create subscription for each record type
   - Implement notification processing
   - Add background refresh capabilities

6. Create a CloudKitSyncCoordinator:
   - Manage overall sync process
   - Handle push operations (local to cloud)
   - Process pull operations (cloud to local)
   - Implement conflict resolution strategies

7. Add sync UI components:
   - SyncStatusView showing current state
   - SyncControlsView for manual sync
   - CloudAccountView for account info
   - SyncErrorView for troubleshooting

8. Implement sync privacy controls:
   - Selective sync options (which data to sync)
   - Privacy settings for location data
   - Data retention policies
   - Local-only mode option

9. Write comprehensive tests:
   - Record conversion accuracy
   - Sync coordinator workflows
   - Conflict resolution scenarios
   - Network failure handling

Ensure the iCloud implementation follows Apple's best practices and provides a seamless experience across devices.

## Prompt 25: Sync Service

Let's build a comprehensive sync service that manages data synchronization between devices:

1. Create a SyncService protocol defining:
   - func startSync() -> AnyPublisher<SyncProgress, Error>
   - func cancelSync()
   - func scheduleBackgroundSync()
   - var syncStatus: CurrentValueSubject<SyncStatus, Never> { get }
   - var lastSyncDate: Date? { get }

2. Implement a CloudKitSyncService conforming to the protocol:
   - Use CloudKitManager for iCloud operations
   - Implement bi-directional sync algorithm
   - Handle background fetch scheduling
   - Manage sync state persistence

3. Create data models for sync:
   - SyncStatus enum (idle, syncing, failed, completed)
   - SyncProgress struct with percent and current operation
   - SyncError enum with detailed error cases
   - SyncMetadata for tracking sync state

4. Implement a multi-stage sync process:
   1. Push local changes to cloud
   2. Fetch remote changes
   3. Apply remote changes locally
   4. Resolve conflicts
   5. Update local metadata

5. Create a conflict resolution system:
   - Define conflict resolution strategies (newest wins, manual merge)
   - Implement three-way merge for compatible changes
   - Create conflict presentation UI
   - Store and apply resolution decisions

6. Add background sync capabilities:
   - Register for background refresh
   - Implement silent push notification handling
   - Create energy-efficient sync scheduling
   - Handle background task completion

7. Implement error recovery:
   - Create automatic retry for transient errors
   - Implement exponential backoff strategy
   - Add partial sync completion handling
   - Create sync repair mechanisms

8. Create sync monitoring and debugging:
   - Add detailed sync logging
   - Create sync history tracking
   - Implement sync diagnostics tools
   - Add performance monitoring

9. Write tests for:
   - Full sync cycle operations
   - Conflict detection and resolution
   - Background sync scheduling
   - Error handling and recovery

Ensure the sync service is reliable, efficient with network and battery usage, and provides clear feedback to the user.

## Prompt 26: Cross-device Experience

Let's enhance the SurfTracker app with a seamless cross-device experience:

1. Implement Handoff support:
   - Enable session continuation between devices
   - Create NSUserActivity for current app state
   - Handle activity restoration
   - Add deep linking to specific content

2. Create a shared UI component library:
   - Implement consistent styling across platforms
   - Create adaptive layouts for different screen sizes
   - Design shared navigation patterns
   - Ensure consistent terminology and iconography

3. Implement settings synchronization:
   - Sync user preferences across devices
   - Create a SettingsStore with CloudKit backing
   - Handle settings conflicts
   - Provide per-device override options

4. Add Watch-to-Phone communication:
   - Implement WCSession for direct device communication
   - Create a MessageService for reliable transfers
   - Handle app state synchronization
   - Implement file transfers for sensor data

5. Create Continuity features:
   - Add Universal Clipboard support for session data
   - Implement Continuity Camera for adding photos
   - Create shared credentials handling
   - Add proximity-based device switching

6. Implement a unified notification system:
   - Synchronize notifications across devices
   - Create rich notification content
   - Handle notification actions consistently
   - Implement notification muting per device

7. Add shared state management:
   - Create a StateCoordinator for cross-device state
   - Implement real-time state synchronization
   - Handle offline state divergence
   - Create state reconciliation algorithms

8. Implement cross-device authentication:
   - Create seamless sign-in across devices
   - Implement secure credential sharing
   - Add biometric authentication on supported devices
   - Create account management interface

9. Write tests for:
   - Handoff functionality
   - Settings synchronization
   - Inter-device communication
   - State consistency across devices

Ensure the cross-device experience feels natural and consistent, with appropriate adaptations for each platform's capabilities.

## Prompt 27: Weather/Conditions API

Let's implement weather and surf conditions integration for the SurfTracker app:

1. Create a WeatherService protocol defining:
   - func getCurrentConditions(at location: CLLocation) -> AnyPublisher<WeatherConditions, Error>
   - func getForecast(at location: CLLocation, days: Int) -> AnyPublisher<[ForecastDay], Error>
   - func getHistoricalConditions(at location: CLLocation, date: Date) -> AnyPublisher<WeatherConditions, Error>

2. Research and implement API clients for potential providers:
   - Create a WeatherKitService using Apple's WeatherKit API
   - Implement a SurflineService for surf-specific data (if API available)
   - Create a NOAAService for tide and marine data
   - Add a StormglassService as another option

3. Create data models for weather and conditions:
   - WeatherConditions with temperature, wind, precipitation
   - SwellConditions with height, period, direction
   - TideConditions with current level, next high/low
   - ForecastDay with hourly predictions

4. Implement data visualization components:
   - WeatherSummaryView with current conditions
   - SwellChartView showing swell components
   - TideGraphView with tide curve
   - WindCompassView showing wind direction and speed

5. Create a ConditionsViewModel that:
   - Manages data loading from services
   - Combines data from multiple sources
   - Handles caching and refresh policies
   - Provides formatted data for UI

6. Add location-based condition loading:
   - Automatically load conditions for session location
   - Implement location favorites for quick checking
   - Add geofencing for nearby spot alerts
   - Create location search for checking other spots

7. Implement forecast integration:
   - Add forecast view for upcoming days
   - Create optimal conditions highlighting
   - Implement conditions comparison with historical data
   - Add surf quality prediction based on conditions

8. Create offline capabilities:
   - Cache recent conditions data
   - Implement tide prediction for offline use
   - Add historical data persistence
   - Create data prefetching for favorite locations

9. Write tests for:
   - API client functionality
   - Data model conversions
   - Caching and persistence
   - UI rendering with various data states

Ensure the weather integration is battery and network efficient, with appropriate caching and update frequencies.

## Prompt 28: Tide Information

Let's implement comprehensive tide information integration for the SurfTracker app:

1. Create a TideService protocol defining:
   - func getCurrentTide(at location: CLLocation) -> AnyPublisher<TideInfo, Error>
   - func getTidePredictions(at location: CLLocation, start: Date, end: Date) -> AnyPublisher<[TidePrediction], Error>
   - func getNextHighLow(at location: CLLocation) -> AnyPublisher<TideExtreme, Error>
   - func getTideStations(near location: CLLocation) -> AnyPublisher<[TideStation], Error>

2. Implement a NOAATideService conforming to the protocol:
   - Access NOAA CO-OPS API for US tide data
   - Handle API authentication and rate limiting
   - Implement data parsing and validation
   - Add error handling and recovery

3. Create alternative tide data sources:
   - Implement a WorldTidesService for global coverage
   - Create a TideCalculator for offline predictions
   - Add a UserReportedTideService for community data
   - Implement provider selection based on location

4. Create tide data models:
   - TideInfo with current height, status, and reference levels
   - TidePrediction with height and timestamp
   - TideExtreme with high/low type, height, and time
   - TideStation with location, name, and metadata

5. Implement tide visualization components:
   - TideGraphView showing curve with current position
   - TideClockView showing time to next extreme
   - TideTableView with tabular data
   - TideStatusView for quick reference

6. Create a TideViewModel that:
   - Manages tide data loading and caching
   - Calculates derived tide metrics
   - Schedules updates at appropriate intervals
   - Provides formatted data for UI components

7. Add session-specific tide integration:
   - Automatically load tide data for session location
   - Associate tide information with sessions
   - Correlate wave performance with tide state
   - Create tide recommendations based on history

8. Implement tide complications for Apple Watch:
   - Create tide graph complication
   - Add high/low tide time complication
   - Implement tide direction indicator
   - Create tide height complication

9. Write tests for:
   - Tide data retrieval and parsing
   - Prediction algorithm accuracy
   - UI rendering with various tide states
   - Offline capability fallbacks

Ensure tide information is accurate, visually intuitive, and relevant to surfing conditions assessment.

## Prompt 29: Spot Identification

Let's implement surf spot identification and management for the SurfTracker app:

1. Create a SpotService protocol defining:
   - func identifySpot(at location: CLLocation) -> AnyPublisher<SurfSpot?, Error>
   - func getNearbySpots(near location: CLLocation, radius: Double) -> AnyPublisher<[SurfSpot], Error>
   - func searchSpots(query: String) -> AnyPublisher<[SurfSpot], Error>
   - func saveUserSpot(_ spot: SurfSpot) -> AnyPublisher<SurfSpot, Error>

2. Implement a spot database:
   - Create a bundled database of known surf spots
   - Implement efficient spatial indexing
   - Add metadata like spot type, difficulty, and features
   - Include region-specific spot information

3. Create a SpotIdentificationService that:
   - Uses GPS coordinates to identify known spots
   - Implements proximity matching algorithm
   - Falls back to reverse geocoding for unknown locations
   - Handles ambiguous location resolution

4. Implement user-defined spots:
   - Create interface for adding custom spots
   - Allow editing of spot metadata
   - Implement spot favoriting
   - Add custom notes for spots

5. Create data models for spots:
   - SurfSpot with name, coordinates, and metadata
   - SpotCategory enum (beach break, reef, point, etc.)
   - SpotDifficulty enum (beginner, intermediate, advanced)
   - SpotFeatures struct with characteristics

6. Implement spot visualization:
   - SpotMapView showing spot location with details
   - SpotListView for browsing nearby spots
   - SpotDetailView with comprehensive information
   - SpotConditionsView showing current conditions

7. Create a SpotViewModel that:
   - Manages spot identification and loading
   - Provides formatted spot data for UI
   - Handles user interaction with spots
   - Manages spot history and favorites

8. Add spot analytics:
   - Track performance at different spots
   - Create spot comparison tools
   - Implement spot recommendations based on conditions
   - Add spot statistics for session planning

9. Write tests for:
   - Spot identification accuracy
   - Database query performance
   - Custom spot management
   - UI rendering with various spot data

Ensure the spot identification is accurate, provides valuable context for sessions, and enhances the overall app experience.

## Prompt 30: UI Polish

Let's implement UI polish and refinement for the SurfTracker app:

1. Create a comprehensive design system:
   - Define a complete color palette with semantic naming
   - Create typography styles with proper scaling
   - Implement consistent spacing system
   - Design component library with reusable elements

2. Refine typography and text rendering:
   - Implement proper Dynamic Type support
   - Create custom fonts with efficient loading
   - Add text styles for different contexts
   - Ensure legibility in outdoor conditions

3. Implement animations and transitions:
   - Create custom transitions between screens
   - Add micro-interactions for feedback
   - Implement data visualization animations
   - Create celebration animations for achievements

4. Polish watch-specific UI:
   - Optimize for different watch sizes
   - Implement Digital Crown interactions
   - Create Always-On display optimizations
   - Design water-friendly touch targets

5. Enhance visual feedback:
   - Implement haptic feedback patterns
   - Create sound design for key interactions
   - Add visual state indicators
   - Design progress visualizations

6. Refine data visualization:
   - Create custom chart styles
   - Implement interactive data exploration
   - Add visual hierarchy to complex data
   - Design intuitive visualizations for surf metrics

7. Improve loading states:
   - Design skeleton loading screens
   - Implement progressive loading patterns
   - Create custom loading animations
   - Add data preview during loading

8. Polish layout and composition:
   - Ensure consistent margins and alignment
   - Implement proper landscape support on iOS
   - Create responsive layouts for all screens
   - Design consistent card and list styles

9. Write UI tests:
   - Test rendering on different device sizes
   - Verify dynamic type scaling
   - Test animations and transitions
   - Validate visual consistency across the app

Ensure the UI feels polished, cohesive, and purpose-built for surfers using the app in challenging outdoor conditions.

## Prompt 31: Performance Optimization

Let's optimize the performance of the SurfTracker app, with a particular focus on battery efficiency:

1. Implement intelligent sensor usage:
   - Create adaptive sensor sampling rates based on activity
   - Implement sensor coalescing for efficiency
   - Add motion-based activation/deactivation
   - Create power states with different sensor profiles

2. Optimize GPS usage:
   - Implement smart GPS sampling strategies
   - Create geofencing-based GPS activation
   - Add accuracy-based power management
   - Implement batch processing of location updates

3. Refine background processing:
   - Create efficient background task scheduling
   - Implement work batching for power efficiency
   - Add background task prioritization
   - Create power-aware processing pipeline

4. Optimize UI rendering:
   - Implement view recycling for lists
   - Add image caching and optimization
   - Create efficient drawing techniques for visualizations
   - Implement lazy loading for complex views

5. Improve data handling:
   - Implement efficient serialization techniques
   - Create tiered storage strategy
   - Add data prefetching and precomputation
   - Optimize database queries and indexing

6. Create a performance monitoring system:
   - Track battery usage per component
   - Measure and log processing time for key operations
   - Implement memory usage monitoring
   - Create performance regression tests

7. Add power saving modes:
   - Implement user-selectable power profiles
   - Create automatic power saving based on battery level
   - Add session-duration-aware power management
   - Implement critical battery handling

8. Optimize network usage:
   - Implement efficient data compression
   - Create background transfer scheduling
   - Add connection-aware sync strategies
   - Implement data prioritization for limited connectivity

9. Write performance tests:
   - Benchmark key algorithms
   - Measure battery impact of core features
   - Test performance on older devices
   - Create scalability tests for large datasets

Ensure all optimizations maintain the core functionality and accuracy while extending battery life for longer surf sessions.

## Prompt 32: Error Handling

Let's implement comprehensive error handling and recovery mechanisms for the SurfTracker app:

1. Create a unified error system:
   - Define domain-specific error enums (NetworkError, StorageError, SensorError, etc.)
   - Implement error categorization (recoverable, warning, critical)
   - Create an ErrorManager for centralized handling
   - Add error logging and reporting infrastructure

2. Implement user-facing error presentation:
   - Create contextual error messages with clear actions
   - Design error states for different UI components
   - Implement progressive disclosure of error details
   - Add visual differentiation by error severity

3. Create recovery mechanisms:
   - Implement automatic retry logic for transient errors
   - Add manual recovery workflows for user-resolvable issues
   - Create data repair tools for corruption scenarios
   - Implement session recovery after crashes

4. Handle device-specific errors:
   - Create watchOS-specific error handling
   - Implement recovery for watch connectivity issues
   - Add low battery contingency workflows
   - Handle thermal throttling gracefully

5. Implement sensor error management:
   - Create fallback mechanisms for sensor failures
   - Implement degraded operation modes
   - Add sensor calibration and recovery tools
   - Design clear messaging for sensor permission issues

6. Create network error handling:
   - Implement offline mode with clear indicators
   - Add connectivity recovery procedures
   - Create queuing system for pending operations
   - Implement partial data handling for incomplete responses

7. Add background error management:
   - Create mechanisms to surface background errors
   - Implement state reconciliation after failures
   - Add critical error notifications
   - Design background retry strategies

8. Implement diagnostic tools:
   - Create error logs viewer for troubleshooting
   - Add device state reporting for support
   - Implement diagnostic data collection
   - Create self-healing mechanisms where possible

9. Write comprehensive tests:
   - Test error detection and handling
   - Validate recovery mechanisms
   - Verify error message clarity
   - Test edge cases and failure scenarios

Ensure the error handling system is comprehensive but non-intrusive, with a focus on maintaining user trust through transparency and recovery options.

## Prompt 33: Accessibility

Let's implement comprehensive accessibility features for the SurfTracker app:

1. Implement VoiceOver support:
   - Add proper accessibility labels and hints
   - Create meaningful accessibility traits
   - Implement custom rotors for navigation
   - Design custom accessibility announcements

2. Enhance Dynamic Type support:
   - Ensure all text scales appropriately
   - Test layout with largest content sizes
   - Implement custom scaling for graphical elements
   - Create responsive layouts for different text sizes

3. Add additional vision accommodations:
   - Implement high contrast mode
   - Support system contrast settings
   - Add color blind friendly visualizations
   - Create alternative text representations of visual data

4. Implement motion accessibility:
   - Honor Reduce Motion system setting
   - Create alternative non-animated transitions
   - Add static alternatives to animations
   - Implement reduced motion data visualizations

5. Add hearing and speech accommodations:
   - Create visual alternatives for audio feedback
   - Implement closed captioning for any audio
   - Add customizable haptic feedback
   - Support system audio accommodations

6. Enhance motor control accessibility:
   - Implement larger touch targets
   - Add alternative input methods
   - Create assistive touch support
   - Implement dwell control compatibility

7. Design cognitive accessibility features:
   - Create consistent and predictable interfaces
   - Implement progress indicators for complex tasks
   - Add memory aids for multi-step processes
   - Support text-to-speech for all content

8. Create an accessibility settings panel:
   - Add app-specific accessibility options
   - Implement accessibility profiles
   - Create direct access to system settings
   - Add accessibility feedback mechanism

9. Write accessibility tests:
   - Test with VoiceOver enabled
   - Validate UI with different text sizes
   - Verify color contrast compliance
   - Test alternative input methods

Ensure the app is fully accessible to users with diverse abilities and preferences, following WCAG guidelines and Apple's accessibility best practices.

## Prompt 34: Testing Infrastructure

Let's create a comprehensive testing infrastructure for the SurfTracker app:

1. Implement unit testing framework:
   - Set up XCTest for both targets
   - Create test plans for different scenarios
   - Implement code coverage reporting
   - Add continuous integration configuration

2. Create a mock system for testing:
   - Implement protocol-based dependency injection
   - Create mock implementations of all services
   - Add configurable test data generators
   - Implement predictable randomization for testing

3. Implement UI testing:
   - Set up XCUITest for interface testing
   - Create page objects for test structure
   - Implement screenshot-based testing
   - Add accessibility audit tests

4. Create integration tests:
   - Test communication between components
   - Implement end-to-end workflow tests
   - Add cross-device interaction tests
   - Create background processing tests

5. Implement performance testing:
   - Create benchmarks for critical algorithms
   - Add memory leak detection
   - Implement battery usage tests
   - Create load testing for data handling

6. Add sensor simulation:
   - Implement simulated motion data playback
   - Create GPS track simulation
   - Add heart rate data simulation
   - Design sensor error simulation

7. Create test data sets:
   - Generate realistic surf session data
   - Create edge case test scenarios
   - Implement progressive test complexity
   - Add internationalization test data

8. Implement test automation:
   - Create test pipeline configuration
   - Add automated regression testing
   - Implement test reporting
   - Create notification system for test failures

9. Add specialized testing tools:
   - Implement wave detection algorithm testing
   - Create GPS accuracy validation
   - Add database performance testing
   - Implement sync conflict testing

Ensure the testing infrastructure is comprehensive, maintainable, and provides quick feedback during development.

## Prompt 35: Documentation

Let's create comprehensive documentation for the SurfTracker app:

1. Implement code documentation:
   - Add inline comments for complex algorithms
   - Create method documentation with parameter descriptions
   - Implement class/protocol overview documentation
   - Add code examples for key components

2. Create architecture documentation:
   - Document high-level app architecture
   - Create component relationship diagrams
   - Add data flow documentation
   - Implement state management overview

3. Create API documentation:
   - Document all public interfaces
   - Create usage examples for key APIs
   - Add parameter validation details
   - Implement error handling documentation

4. Write developer guides:
   - Create onboarding documentation for new developers
   - Implement coding standards guide
   - Add troubleshooting guides
   - Create performance optimization guidelines

5. Create user documentation:
   - Implement in-app help system
   - Create user guide with key features
   - Add tutorial content for new users
   - Create FAQ documentation

6. Implement technical diagrams:
   - Create class diagrams for key subsystems
   - Add sequence diagrams for complex workflows
   - Implement state machine diagrams
   - Create data model visualization

7. Add build and deployment documentation:
   - Document build configuration
   - Create deployment checklist
   - Add App Store submission guide
   - Implement version management documentation

8. Create testing documentation:
   - Document test coverage strategy
   - Add test data generation guidelines
   - Create test case writing guide
   - Document CI/CD integration

9. Implement documentation automation:
   - Set up automated documentation generation
   - Create documentation validation tools
   - Implement documentation versioning
   - Add documentation search capabilities

Ensure all documentation is clear, accurate, and maintained alongside code changes.

## Prompt 36: TestFlight Preparation

Let's prepare the SurfTracker app for TestFlight beta testing:

1. Configure app metadata:
   - Set proper bundle identifier
   - Create marketing version and build number scheme
   - Add privacy policy URL
   - Configure age rating information

2. Prepare beta testing assets:
   - Create TestFlight app description
   - Add beta app icon (if different from release)
   - Implement beta watermark on UI
   - Create beta splash screen with version info

3. Implement beta user management:
   - Create internal testing group
   - Set up external testing groups by user type
   - Add testing distribution rules
   - Create tester onboarding documentation

4. Add beta feedback mechanisms:
   - Implement in-app feedback form
   - Create screenshot annotation tools
   - Add crash reporting with context
   - Implement beta-specific logging

5. Create beta testing instructions:
   - Write clear test scenarios
   - Create guided testing workflows
   - Add known issues documentation
   - Implement survey questions for testers

6. Configure build settings:
   - Set up proper signing for TestFlight
   - Create beta-specific build configurations
   - Add debug information for beta builds
   - Implement beta feature flags

7. Prepare analytics for beta:
   - Configure analytics specifically for beta
   - Implement session recording (with consent)
   - Add usage metrics collection
   - Create beta user cohort tracking

8. Create beta release process:
   - Document build and submission workflow
   - Implement changelog generation
   - Create release notes template
   - Add version history tracking

9. Set up beta testing infrastructure:
   - Create feedback collection system
   - Implement issue tracking integration
   - Add automated build distribution
   - Create beta testing dashboard

Ensure the TestFlight preparation creates a seamless experience for testers while providing valuable feedback for development.

## Prompt 37: App Store Submission

Let's prepare the SurfTracker app for App Store submission:

1. Create App Store assets:
   - Design App Store icon (1024x1024)
   - Create app preview videos for each device
   - Design App Store screenshots for all devices
   - Prepare promotional artwork

2. Write App Store metadata:
   - Create compelling app description
   - Write keyword-optimized subtitle
   - Craft concise promotional text
   - Create keyword list for search optimization

3. Configure app submission settings:
   - Set pricing and availability
   - Configure app rating information
   - Add copyright information
   - Set up territories and localization

4. Prepare legal documentation:
   - Create comprehensive privacy policy
   - Write terms of service
   - Add attribution for third-party components
   - Create GDPR compliance documentation

5. Implement App Store requirements:
   - Add proper data collection disclosure
   - Create App Tracking Transparency implementation
   - Implement required system permissions handling
   - Add accessibility compliance

6. Configure in-app purchases (if applicable):
   - Create IAP products
   - Implement purchase flow with receipt validation
   - Add restore purchases functionality
   - Create subscription management interface

7. Prepare for App Review:
   - Create demo account for reviewers
   - Write review notes with testing instructions
   - Document edge cases and special features
   - Create content demonstrating app functionality

8. Implement App Store optimization:
   - Research competitive keywords
   - Create localized metadata for key markets
   - Optimize screenshots for conversion
   - Design preview video to showcase key features

9. Create release management:
   - Implement phased release strategy
   - Create post-launch monitoring plan
   - Design user feedback collection
   - Prepare for rapid fixes if needed

Ensure all App Store requirements are met while creating a compelling presentation that effectively communicates the app's value.


