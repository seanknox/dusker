# Dusker - Surf Tracking App

Dusker is a comprehensive surf tracking application for Apple Watch and iPhone that helps surfers track their sessions, analyze their performance, and improve their surfing.

## Features

- Track surf sessions with detailed metrics
- Automatic wave detection
- Heart rate monitoring during sessions
- GPS tracking for distance and speed
- Session history and statistics
- Cross-device synchronization

## Requirements

- iOS 16.0+
- watchOS 9.0+
- Xcode 14.0+
- Swift 5.7+

## Project Structure

The project is organized into the following components:

- **iOS**: iPhone app
- **watchOS**: Apple Watch app
- **DuskerKit**: Shared framework for common code
- **Tests**: Unit and integration tests

## Getting Started

1. Clone the repository
2. Open the project in Xcode
3. Build and run the app on your device or simulator

## Development

The project uses SwiftUI for the user interface and follows the MVVM architecture pattern.

### Key Components

- **Models**: Data structures for surf sessions, waves, etc.
- **Views**: SwiftUI views for the user interface
- **ViewModels**: Business logic and data processing
- **Services**: Core functionality like location tracking, motion detection, etc.
- **Utilities**: Helper functions and extensions

## Testing

The project uses fastlane to automate running tests across all platforms.

### Setup

1. Make sure you have Ruby 3.2.2 installed:
   ```bash
   # Check Ruby version
   ruby -v
   
   # If needed, install with rbenv
   rbenv install 3.2.2
   rbenv local 3.2.2
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

### Running Tests

cd into the fastlane directory:

```bash
cd fastlane
```

Run all tests (iOS, watchOS, and DuskerKit):
```bash
bundle exec fastlane test_all
```

Or run specific test suites:
```bash
# iOS tests only
bundle exec fastlane test_ios

# watchOS tests only
bundle exec fastlane test_watchos

# DuskerKit tests only
bundle exec fastlane test_kit
```

## License

This project is licensed under the MIT License - see the LICENSE file for details. 