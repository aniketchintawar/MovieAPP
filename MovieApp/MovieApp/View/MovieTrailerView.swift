//
//  MovieTrailerView.swift
//  MovieApp
//
//  Created by Aniket Chintawar on 22/02/25.
//

import SwiftUI
import YouTubePlayerKit

struct MovieTrailerView: View {
    @StateObject var viewModel = TrailerViewModel()
    let movieID: Int
    
    var body: some View {
        VStack {
            if viewModel.trailerIDs.isEmpty && viewModel.isLoading {
                ProgressView("Loading Trailers...")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.8))
                
            } else if !viewModel.trailerIDs.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.trailerIDs, id: \.self) { trailerID in
                            YouTubePlayerView(
                                YouTubePlayer(source: .video(id: trailerID))
                            )
                            .id(trailerID)
                            .frame(height: 250)
                            .clipped()
                        }
                    }
                    .padding()
                    
                }
                
            } else {
                Text(viewModel.errorMessage ?? "No trailers available")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .frame(height: 250)
            }
            
            Spacer()
        }
        .padding(.top)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Trailers", displayMode: .inline)
        .onAppear {
            viewModel.fetchTrailers(movieID: movieID)
        }
        
    }
    
}





