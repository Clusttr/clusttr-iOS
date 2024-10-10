//
//  URLSession+Extensions.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 01/09/2023.
//

import Foundation

extension URLSession {

    public enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    public enum APIError: Error {
        case clientError(String)
        case networkError(Error)
        case invalidResponse
        case invalidURL
        case invalidData
        case serverError(statusCode: Int)
    }

    public func request<T: Codable>(path: String, httpMethod: HttpMethod, body: Data? = nil, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var url = ClusttrAPIs.baseURL?.appending(path: path) else {
            throw APIError.invalidURL
        }
        url = url.appending(queryItems: queryItems)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(ClusttrAPIs.getAccessToken())", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = body
        //print("access token: \(ClusttrAPIs.getAccessToken())")

        let (data, urlResponse) = try await data(for: urlRequest)
        try manageHttpResponse(urlResponse, data: data)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result

    }

    func manageHttpResponse(_ urlResponse: URLResponse, data: Data) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        let statusCode = httpResponse.statusCode

        switch statusCode {
        case 200...299:
            return
        case 400...499:
            let errorMessage = try JSONDecoder().decode(ClusttrErrorDto.self, from: data)
            let firstMessage = errorMessage.message.first ?? "No error message found"
            throw APIError.clientError(firstMessage)
        case 500...599:
            throw APIError.serverError(statusCode: statusCode)

        default:
            throw APIError.invalidResponse
        }
    }
}

struct ClusttrErrorDto: Decodable {
    let message: [String]
    let error: String
    let statusCode: Int
}
