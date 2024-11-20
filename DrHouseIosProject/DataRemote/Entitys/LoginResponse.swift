struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let userId: String
}
