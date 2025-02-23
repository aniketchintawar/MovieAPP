//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Aniket Chintawar on 22/02/25.
//

import Foundation
import Alamofire

class MovieDetailViewModel: ObservableObject {
    @Published var movie: MovieDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let movieService = MovieService()
    
    func getMovieDetailUsingid(movieId: Int) {
        isLoading = true
        errorMessage = nil  // Reset error message before new request
        
        movieService.fetchMovieDetails(movieId: movieId) { movies in
            DispatchQueue.main.async {
                if let movies = movies {
                    self.movie = movies
                } else {
                    self.errorMessage = "Failed to load movies."  //error message on failure
                }
                self.isLoading = false
            }
        }
    }
}
