import Alamofire
import Foundation
class MovieService {
    private let apiKey = "YOUR_API_KEY" 
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchMovies(endpoint: String, completion: @escaping ([Movie]?) -> Void) {
        let url = "\(baseURL)/movie/\(endpoint)?api_key=\(apiKey)&language=en-US&page=1"
        
        AF.request(url).validate().responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    completion(movieResponse.results)
                }
            case .failure(let error):
                print("API Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (MovieDetail?) -> Void) {
        let url = "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)&append_to_response=credits,videos"
        
        AF.request(url).validate().responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case .success(let movie):
                DispatchQueue.main.async {
                    completion(movie)
                }
            case .failure(let error):
                print("Movie Detail API Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchTrailerDetails(movieId: Int, completion: @escaping (TrailerDetails?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: TrailerDetails.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let trailerResponse):
                        DispatchQueue.main.async {
                            completion(trailerResponse)
                        }
                    case .failure(let error):
                        print("Trailer Detail API Error: \(error.localizedDescription)")
                        completion(nil)
                    }
                }
            }
    }
    func fetchTrendingMovies(timeWindow: String = "week", completion: @escaping ([Movie]?) -> Void) {
        guard timeWindow == "day" || timeWindow == "week" else {
            print("Invalid time window. Use 'day' or 'week'.")
            completion(nil)
            return
        }
        
        let url = "\(baseURL)/trending/movie/\(timeWindow)?api_key=\(apiKey)&language=en-US&page=1"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: MovieResponse.self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let movieResponse):
                        completion(movieResponse.results)
                    case .failure(let error):
                        print("Trending Movies API Error: \(error.localizedDescription)")
                        completion(nil)
                    }
                }
            }
    }
    
}

