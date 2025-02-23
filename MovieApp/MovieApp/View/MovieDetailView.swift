//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Aniket Chintawar on 22/02/25.
//

import SwiftUI
import Kingfisher // For image caching

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel()
    @State private var selectedCategory = "About Movie"
    let categories = ["About Movie", "Cast"]
    let movieID: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 16) {
                
                // Movie Poster & Info
                if let movie = viewModel.movie {
                    NavigationLink(destination: MovieTrailerView(movieID: movie.id)) {
                        ZStack(alignment: .bottomLeading) {
                            
                            KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"))
                                .resizable()
                                .aspectRatio(contentMode: .fill) // Fills the frame while keeping the aspect ratio
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                                .clipped()
                                .padding(2)
                            
                            
                            HStack {
                                KFImage(URL(string: "https://image.tmdb.org/t/p/w500\( movie.posterPath ?? "")"))
                                    .resizable()
                                    .frame(width: 80, height: 100)
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    Text("\(movie.releaseDate ?? "Unknown") - \(movie.runtime.map { "\($0) min" } ?? "N/A")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                        }
                    }
                    // Movie Details (Icons and Info)
                    HStack(spacing: 16) {
                        Label(extractYear(from:movie.releaseDate ?? ""), systemImage: "calendar")
                        Spacer()
                        Label("\(movie.runtime ?? 0) Minutes", systemImage: "clock")
                    }
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    
                    // **Category Tabs**
                    CategoryTabView(selectedCategory: $selectedCategory, categories: categories, onCategorySelected: { _ in })
                        .padding(.horizontal)
                    
                    // **Dynamic Content Based on Selected Category**
                    ScrollView {
                        getSelectedView(movie: movie)
                    }
                    
                } else if viewModel.isLoading {
                    ProgressView("Loading...").foregroundColor(.white)
                } else {
                    Text("Failed to load movie details").foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding(.top)
            .frame(width: geometry.size.width, height: geometry.size.height) // Full screen size
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Details", displayMode: .inline)
        .onAppear {
            viewModel.getMovieDetailUsingid(movieId: movieID)
        }
    }
    
    // Switch between About Movie and Cast View
    @ViewBuilder
    private func getSelectedView(movie: MovieDetail) -> some View {
        if selectedCategory == "About Movie" {
            AboutMovieView(movie: movie)
        } else if selectedCategory == "Cast" {
            CastListView(cast: movie.credits?.cast ?? [])
        }
    }
    func extractYear(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Input format
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy" // Output format
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date" // Default value in case of error
        }
    }
}

// Movie Description Section
struct AboutMovieView: View {
    let movie: MovieDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.headline)
                .foregroundColor(.white)
            
            Text(movie.overview)
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

// Cast List View

struct CastListView: View {
    let cast: [Cast]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2) // 2 columns
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(cast, id: \.id) { actor in
                    VStack {
                        KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(actor.profilePath ?? "")"))
                            .resizable()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        
                        Text(actor.name)
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 130)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background
    }
}




// **Preview**
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieID: 550)
    }
}
