//
//  FileManagerService.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/5/2567 BE.
//

import Foundation

protocol FileManagerServiceInterface {
    func writeFile(
        data: Data,
        fileName: String,
        directory: URL,
        completion: @escaping (Result<URL, Error>) -> Void
    )

    func removeFile(
        fileName: String,
        directory: URL,
        completion: @escaping (Result<Bool, Error>) -> Void
    )

    @discardableResult
    func cleanupFile(directory: URL) -> Bool

    func isFileExists(atPath path: String) -> Bool
}

struct FileManagerService {

    let fileManager: FileManager
}

extension FileManagerService: FileManagerServiceInterface {
    func writeFile(
        data: Data,
        fileName: String,
        directory: URL,
        completion: @escaping (Result<URL, Error>) -> Void
    ) {
        let directoryURL = directory.appendingPathComponent(fileName)
        let isDirectoryIsNotExist = !fileManager.fileExists(atPath: directory.path)
        if isDirectoryIsNotExist {
            do {
                try fileManager.createDirectory(
                    at: directory,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                completion(.failure(error))
                return
            }
        }

        do {
            try data.write(to: directoryURL, options: .atomic)
            completion(.success(directoryURL))
        } catch {
            completion(.failure(error))
        }
    }

    func removeFile(
        fileName: String,
        directory: URL,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        let directoryURL = directory.appendingPathComponent(fileName)
        do {
            var isExecutable = false
            if fileManager.fileExists(atPath: directoryURL.path) {
                try fileManager.removeItem(at: directoryURL)
                isExecutable = true
            }

            completion(
                .success(isExecutable)
            )
        } catch {
            completion(
                .failure(error)
            )
        }
    }

    @discardableResult
    func cleanupFile(directory: URL) -> Bool {
        do {
            let files = try fileManager.contentsOfDirectory(
                at: directory,
                includingPropertiesForKeys: nil
            )
            
            try files.forEach {
                try fileManager.removeItem(at: $0)
            }
            return true
        } catch {
            return false
        }
    }

    func isFileExists(atPath path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }

}
