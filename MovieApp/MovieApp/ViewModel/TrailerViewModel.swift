//
//  TrailerViewModel.swift
//  MovieApp
//
//  Created by Aniket Chintawar on 23/02/25.
//

import SwiftUI
import Combine
import Alamofire

class TrailerViewModel: ObservableObject {
    @Published var trailerIDs: [String] = []
    @Published var selectedTrailerID: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let movieService = MovieService()
    
    func fetchTrailers(movieID: Int) {
        isLoading = true
        errorMessage = nil
        movieService.fetchTrailerDetails(movieId: movieID) { movies in
            DispatchQueue.main.async {
                if let movies = movies {
                    let youtubeVideos = movies.results.filter { $0.site == "YouTube" }
                    self.trailerIDs = youtubeVideos.map { $0.key }
                    self.selectedTrailerID = self.trailerIDs.first // Set the first trailer as default
                } else {
                    self.errorMessage = "Failed to load Trailer."  // error message on failure
                }
                self.isLoading = false
                
                
            }
        }
    }
}
