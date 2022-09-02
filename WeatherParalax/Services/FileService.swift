//
//  FileService.swift
//  WeatherParalax
//
//  Created by skarev on 03.09.2022.
//

import Foundation

protocol FileServiceProtocol {
    func getCitiesFrom(file: String, completion: @escaping (Result<[City]?, Error>) -> Void)
}

final class FileService: FileServiceProtocol {
    func getCitiesFrom(file: String, completion: @escaping (Result<[City]?, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            let cities = try JSONDecoder().decode([City].self, from: jsonData)
            completion(.success(cities))
        } catch {
            completion(.failure(error))
            debugPrint("Error: \(error.localizedDescription)")
        }
    }
}
