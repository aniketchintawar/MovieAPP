# MovieApp

## Overview

MovieApp is a SwiftUI-based iOS application that allows users to browse trending movies, view movie details, watch trailers, and see cast information. The app fetches data from The Movie Database (TMDB) API and integrates features like Kingfisher for image caching, YouTubePlayerKit for video playback, and Alamofire for API calls.

## Features

- **Trending & Popular Movies**: Displays a list of trending movies using TMDB API.
- **Movie Details**: Shows movie description, genres, release date, runtime, and cast.
- **Trailer Support**: Fetches and plays trailers using YouTubePlayerKit (Version 1.0.0).
- **Horizontal & Grid Scroll Views**: Displays movies in horizontal and grid views.
- **Dark Mode UI**: A black-themed interface for a cinematic feel.
- **Navigation & Segues**: Allows seamless transitions between screens.

## Technologies Used

- **SwiftUI**: UI Development
- **Alamofire**: API Networking
- **Kingfisher**: Image Caching
- **YouTubePlayerKit (1.0.0)**: Trailer Playback
- **TMDB API**: Fetching movie data

## API Endpoints Used

1. **Trending Movies**
   - Endpoint: `/trending/movie/{time_window}`
   - Parameters: `time_window (day/week)`, `api_key`, `language`, `page`
2. **Movie Details**
   - Endpoint: `/movie/{movie_id}`
   - Parameters: `api_key`, `append_to_response=credits,videos`
3. **Movie Trailers**
   - Endpoint: `/movie/{movie_id}/videos`
   - Parameters: `api_key`

## Setup & Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourrepo/MovieApp.git
   cd MovieApp
   ```
2. Install dependencies via Swift Package Manager:
   - Alamofire
   - Kingfisher
   - YouTubePlayerKit (1.0.0)
3. Add your TMDB API Key in `MovieService.swift`
   ```swift
   private let apiKey = "YOUR_API_KEY"
   ```
4. Run the app on Xcode 15+.

## Future Enhancements

- Implement search functionality.
- Add offline caching for movies.
- Improve UI animations.

## Screenshots

Below are some screenshots of the MovieApp:

![Simulator Screenshot - iPhone 15 Pro - 2025-02-23 at 20 05 56](https://github.com/user-attachments/assets/14aa7c7c-8bca-405d-9aab-19d57f79bbcb)
![Simulator Screenshot - iPhone 15 Pro - 2025-02-23 at 20 13 00](https://github.com/user-attachments/assets/545504cc-dc57-4216-a3ae-2925830eae6f)
![Simulator Screenshot - iPhone 15 Pro - 2025-02-23 at 20 13 05](https://github.com/user-attachments/assets/6daea6e6-0bbe-4141-ad8f-f3fe897dfa5b)
![Simulator Screenshot - iPhone 15 Pro - 2025-02-23 at 20 13 13](https://github.com/user-attachments/assets/fa9a8ca7-86e8-4d4a-a2f8-854f5e2d1cc6)
![Simulator Screenshot - iPhone 15 Pro - 2025-02-23 at 20 13 31](https://github.com/user-attachments/assets/0515db6f-1b66-4ece-a064-cbdc4a1594f9)

## Author

**Aniket Chintawar** - iOS Developer

