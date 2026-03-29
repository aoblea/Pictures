# Pictures App

A SwiftUI-based iOS application that demonstrates modern iOS development patterns and best practices for building a photo gallery app using the Unsplash API.

## Overview

This project showcases a well-structured iOS application that fetches and displays photos from the Picsum Photos API (a free, open-source photo API). The app features three main views: a paginated gallery, a daily photo view, and a random photo generator.

## Features

### 🖼️ Gallery View
- **Infinite Scrolling**: Paginated photo loading with lazy grid layout
- **Responsive Design**: Adaptive grid that adjusts to different screen sizes
- **Loading States**: Progress indicators during photo loading
- **Error Handling**: User-friendly error messages for failed requests

### 📅 Daily Photo View
- **Daily Featured Photo**: Displays a curated photo for the current day
- **Photo Details**: Shows author information, dimensions, and links
- **Loading States**: Progress view during photo retrieval

### 🎲 Random Photo View
- **Random Photo Generator**: Fetches random photos on demand
- **Interactive UI**: Button to load new random photos
- **Photo Details**: Complete photo information display

## Architecture

### MVVM Pattern
The application follows the Model-View-ViewModel (MVVM) architectural pattern:

- **Models**: Data structures representing photos and identifiers
- **Views**: SwiftUI views responsible for UI presentation
- **ViewModels**: Business logic and state management

### Key Components

#### Models
- `Photo`: Core data model representing a photo with ID, author, dimensions, and URLs
- `PhotoID` & `SeedID`: Type-safe identifiers for photos
- `PagingRequest`: Request model for paginated API calls

#### Services
- `PhotosAPI`: Protocol defining photo fetching operations
- `NetworkClient`: Concrete implementation using URLSession
- `NetworkSession`: Protocol for network operations and error handling

#### ViewModels
- `GalleryViewModel`: Manages gallery state, pagination, and photo loading
- `DailyPhotoViewModel`: Handles daily photo fetching and display
- `RandomPhotoViewModel`: Manages random photo generation

#### Views
- `GalleryView`: Main gallery with infinite scrolling
- `DailyPhotoView`: Daily featured photo display
- `RandomPhotoView`: Random photo generator
- `ThumbnailView` & `ImageDetailView`: Reusable photo components

## Technical Highlights

### Modern Swift Features
- **Async/Await**: Modern concurrency for network operations
- **Protocol-Oriented Design**: Clean separation of concerns through protocols
- **Type Safety**: Custom types for IDs and string values
- **Combine Framework**: Reactive state management

### SwiftUI Best Practices
- **State Management**: Proper use of `@StateObject`, `@Published`, and `@MainActor`
- **Lazy Loading**: `LazyVGrid` for efficient rendering of large photo collections
- **AsyncImage**: Built-in support for asynchronous image loading
- **NavigationStack**: Modern navigation with deep linking support

### Error Handling
- **Network Errors**: Comprehensive error handling for network failures
- **User Feedback**: Clear error messages and loading states
- **Graceful Degradation**: App continues to function even when some requests fail

### Code Organization
- **Feature-Based Structure**: Organized by feature (Gallery, Daily, Random)
- **Separation of Concerns**: Clear boundaries between models, views, and view models
- **Protocol Abstraction**: Easy to test and mock network dependencies

## Dependencies

- **SwiftUI**: Native UI framework
- **Combine**: Reactive programming framework
- **Foundation**: Core networking and data handling

## API Integration

The app integrates with the [Picsum Photos API](https://picsum.photos/), a free, open-source photo API that provides:

- High-quality placeholder images
- Various image sizes and formats
- Seed-based image generation for consistent results
- No authentication required

## Installation

This is a standard Xcode project that can be opened directly in Xcode:

1. Clone the repository
2. Open `Pictures.xcodeproj` in Xcode
3. Build and run on a simulator or physical device

## Code Quality

The project demonstrates several code quality practices:

- **Comprehensive Documentation**: Clear comments and documentation
- **Error Handling**: Robust error handling throughout
- **Type Safety**: Custom types prevent common bugs
- **Protocol Design**: Clean abstractions for testing and extensibility
- **Modern Concurrency**: Proper use of async/await patterns

## Testing

The project includes test targets:
- `PicturesTests`: Unit tests for business logic
- `PicturesUITests`: UI tests for user interactions

## Future Enhancements

Potential improvements that could be made:
- Image caching for better performance
- Offline support with local storage
- Photo search functionality
- User preferences and settings
- Dark mode support
- Photo sharing capabilities

## Contributing

This project serves as an excellent reference for iOS development best practices. Contributions to improve documentation, add features, or enhance code quality are welcome.

## License

This project is intended as a demonstration of iOS development patterns and best practices.