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
        case invalidURL
        case invalidData
        case httpError(Int)
        case unknown
    }

    public func request<T: Codable>(path: String, httpMethod: HttpMethod, body: Data? = nil) async throws -> T {
        guard let url = ClusttrAPIs.baseURL?.appending(path: path) else {
            throw APIError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(ClusttrAPIs.getAccessToken())", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = body

        do {
            let (data, urlResponse) = try await data(for: urlRequest)
            try manageHttpResponse(urlResponse)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result

        } catch DecodingError.dataCorrupted {
            throw APIError.invalidData
        } catch {
            throw error
        }
    }

    func manageHttpResponse(_ urlResponse: URLResponse) throws {
        guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else { throw APIError.unknown }
        guard statusCode >= 200 && statusCode<300 else { throw APIError.httpError(statusCode) }
    }
}
