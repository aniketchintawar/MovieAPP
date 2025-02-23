//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Aniket Chintawar on 22/02/25.
//
import Foundation

struct MovieResponse: Decodable {
    let dates: MovieDates?
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Date Range
struct MovieDates: Decodable {
    let maximum: String
    let minimum: String
}

// MARK: - Movie Model
struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let genreIDs: [Int]
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let video: Bool
    
    var posterURL: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
    
    var backdropURL: String {
        return "https://image.tmdb.org/t/p/w780\(backdropPath ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, adult, video, popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
