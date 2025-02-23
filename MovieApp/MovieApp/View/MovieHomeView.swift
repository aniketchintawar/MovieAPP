import SwiftUI

struct MovieHomeView: View {
    @State private var selectedCategory = "Now playing"
    let categories = ["Now playing", "Upcoming", "Top rated", "Popular"]
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 16) {
                    // **Show Loader While Fetching Data**
                    if viewModel.isLoading {
                        ProgressView("Loading movies...")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black.opacity(0.8)) // Slight background dimming
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    } else {
                        Text("What do you want to watch?")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        // Trending Movies Section
                        Text("Trending")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(viewModel.trendingMovies.prefix(5)) { movie in
                                    NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                        AsyncImage(url: URL(string: movie.posterURL)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.25)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Category Tabs with API Call on Change
                        CategoryTabView(selectedCategory: $selectedCategory, categories: categories, onCategorySelected: { category in
                            viewModel.isLoading = true  // Show loader immediately
                            viewModel.loadMovies(category: category)
                        })
                        
                        // Movies Grid
                        ScrollView {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                                ForEach(viewModel.selectedMovies) { movie in
                                    NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                        AsyncImage(url: URL(string: movie.posterURL)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(height: geometry.size.height * 0.258)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: geometry.size.height * 0.6) // Restrict scrollable height
                    }
                }
                .padding(.top)
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                viewModel.loadMovies(category: selectedCategory)
                viewModel.loadTrendingMovies()
            }
        }
    }
}




// Preview
struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
