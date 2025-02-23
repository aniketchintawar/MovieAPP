//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Aniket Chintawar on 22/02/25.
//

import Foundation
import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var trendingMovies: [Movie] = []
    @Published var selectedMovies: [Movie] = []
    @Published var selectedMovie: Movie?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let movieService = MovieService()
    // Fetch Trending Movies
    func loadTrendingMovies(timeWindow: String = "day") {
        isLoading = true
        errorMessage = nil
        movieService.fetchTrendingMovies(timeWindow: timeWindow) { movies in
            DispatchQueue.main.async {
                self.isLoading = false
                if let movies = movies {
                    self.trendingMovies = movies
                } else {
                    self.errorMessage = "Failed to load trending movies."
                }
            }
        }
    }
    func loadMovies(category: String) {
        isLoading = true
        errorMessage = nil  // Reset error message before new request
        
        let endpoint: String
        switch category {
        case "Now playing": endpoint = "now_playing"
        case "Upcoming": endpoint = "upcoming"
        case "Top rated": endpoint = "top_rated"
        case "Popular": endpoint = "popular"
        case "Tranding": endpoint = ""
        default: endpoint = "now_playing"
        }
        
        movieService.fetchMovies(endpoint: endpoint) { movies in
            DispatchQueue.main.async {
                if let movies = movies {
                    self.selectedMovies = movies
                } else {
                    self.errorMessage = "Failed to load movies."  // error message on failure
                }
                self.isLoading = false
            }
        }
    }
}
