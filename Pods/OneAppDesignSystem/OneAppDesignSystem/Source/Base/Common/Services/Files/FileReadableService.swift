//
//  JSONFileService.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/5/2567 BE.
//

import Foundation

struct FileReadableService<T: Decodable> {

    func getFile(filename: String, extension: String) -> T? {
        guard let path = Bundle.dsBundle.path(forResource: filename, ofType: `extension`) else {
            return nil
        }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            return nil
        }
        
        let decoder = JSONDecoder()

        return try? decoder.decode(T.self, from: data)
    }
}
