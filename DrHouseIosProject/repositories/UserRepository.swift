import Alamofire
import Foundation

class UserRepository: ApiService {
    private let baseURL = "http://192.168.99.19:3000/"

    func createUser(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        let url = baseURL + "auth/signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .response { response in
                if let data = response.data {
                    // Log the raw response data for debugging
                    if let stringResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(stringResponse)")
                    }
                }
                
                // Proceed with decoding only if data exists
                switch response.result {
                case .success(let data):
                    do {
                        let createdUser = try JSONDecoder().decode(User.self, from: data!)
                        completion(.success(createdUser))
                    } catch let decodingError {
                        completion(.failure(decodingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
           let url = baseURL + "auth/login"
           AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
               .response { response in
                   if let data = response.data {
                       // Log the raw response data for debugging
                       if let stringResponse = String(data: data, encoding: .utf8) {
                           print("Raw Response: \(stringResponse)")
                       }
                   }

                   // Check for missing or empty response data
                   if response.data == nil {
                       completion(.failure(MyError.missingData))
                       return
                   }
                   
                   // Proceed with decoding the response
                   switch response.result {
                   case .success(let data):
                       do {
                           let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data!)
                           completion(.success(loginResponse))
                       } catch let decodingError {
                           completion(.failure(decodingError))
                       }
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
       }
}

// Define a custom error for missing data
enum MyError: Error {
    case missingData
}
