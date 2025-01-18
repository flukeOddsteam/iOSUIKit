//
//  FileManagerService.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/5/2567 BE.
//

import Foundation
import PDFKit
import CoreGraphics

private enum Constants {
    static let schemePDF = "data:application/pdf;base64,"
    static let extensionPDF = ".pdf"
    static let pdfDirectory = "com.designsystem.previewfile"
}

protocol PDFPreviewUseCaseInterface {
    func retrieve(
        _ resource: DSPreviewFileResource,
        completion: @escaping (PDFPreviewUseCaseResults.TemporaryPersistentStore) -> Void
    )
    
    func unlockPDFPassword(
        filePath: URL,
        password: String,
        completion: @escaping (PDFPreviewUseCaseResults.UnlockPassword) -> Void
    )
    
    func flushUpTemporaryFile()
    
    func writePDFFromBase64(
        _ resource: DSPreviewFileResource,
        completion: @escaping (PDFPreviewUseCaseResults.WritePDF) -> Void
    )
}

struct PDFPreviewUseCase {
    private let fileManagerService: FileManagerServiceInterface
    private let networkService: NetworkServiceInterface
    
    private let directoryPath: URL
    
    init(
        fileManagerService: FileManagerServiceInterface,
        networkService: NetworkServiceInterface
    ) {
        self.fileManagerService = fileManagerService
        self.networkService = networkService
        self.directoryPath = FileManager.default.temporaryDirectory.appendingPathComponent(Constants.pdfDirectory)
    }
}

extension PDFPreviewUseCase: PDFPreviewUseCaseInterface {
    func retrieve(
        _ resource: DSPreviewFileResource,
        completion: @escaping (PDFPreviewUseCaseResults.TemporaryPersistentStore) -> Void
    ) {
        guard let url = resource.request.url else {
            completion(.error)
            return
        }
        
        let absoluteString = url.absoluteString
            .removingPercentEncoding?
            .removeSchemePDF()
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? url.absoluteString
        
        let newFilename = [UUID().uuidString, Constants.extensionPDF].joined()
        let filenameCreated = [resource.fileName, Constants.extensionPDF].joined()

        if let filePath = getFilePathInTemporaryDirectory(filenameCreated), fileManagerService.isFileExists(atPath: filePath),
           let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            performWriteFile(
                data: data,
                filename: filenameCreated,
                completion: completion
            )
        } else {
            if absoluteString.isBase64() {
                guard let data = Data(base64Encoded: absoluteString) else {
                    completion(.error)
                    return
                }
                self.performWriteFile(
                    data: data,
                    filename: newFilename,
                    completion: completion
                )
            } else {
                retriveDataFromNetwork(resource, fileName: newFilename, completion: completion)
            }
        }
    }
    
    func unlockPDFPassword(
        filePath: URL,
        password: String,
        completion: @escaping (PDFPreviewUseCaseResults.UnlockPassword) -> Void
    ) {
        let fileName = [UUID().uuidString, Constants.extensionPDF].joined()
        let outputPath = directoryPath.appendingPathComponent(fileName)
        
        UIGraphicsBeginPDFContextToFile(outputPath.path, .zero, nil)
        
        guard
            let cfData = filePath.toCFData(),
            let dataProvider = CGDataProvider(data: cfData),
            let pdfDocument = CGPDFDocument(dataProvider)
        else {
            completion(.error)
            return
        }
        
        if pdfDocument.isEncrypted {
            let unlockSuccess = pdfDocument.unlockWithPassword(password)
            if !unlockSuccess {
                completion(.wrongPassword)
                return
            }
        }
        
        let numberOfPages = pdfDocument.numberOfPages
        for pageIndex in 1...numberOfPages {
            guard let page = pdfDocument.page(at: pageIndex) else {
                continue
            }
            
            let mediaBox = page.getBoxRect(.mediaBox)
            UIGraphicsBeginPDFPageWithInfo(mediaBox, nil)
            
            if let context = UIGraphicsGetCurrentContext() {
                context.saveGState()
                context.translateBy(x: 0, y: mediaBox.size.height)
                context.scaleBy(x: 1.0, y: -1.0)
                context.drawPDFPage(page)
                context.restoreGState()
            }
        }
        
        UIGraphicsEndPDFContext()
        
        completion(.success(outputPath))
    }
    
    func flushUpTemporaryFile() {
        fileManagerService.cleanupFile(directory: directoryPath)
    }
    
    func writePDFFromBase64(
        _ resource: DSPreviewFileResource,
        completion: @escaping (PDFPreviewUseCaseResults.WritePDF) -> Void
    ) {
        guard let url = resource.request.url else {
            completion(.error)
            return
        }
        
        let imageData: Data
        let screenSize: CGRect = UIScreen.main.bounds
        
        do {
            imageData = try Data(contentsOf: url)
        } catch {
            completion(.error)
            return
        }
        
        guard let image = UIImage(data: imageData) else {
            completion(.error)
            return
        }
        
        let pdfData = NSMutableData()
        
        let oldWidth = image.size.width
        let scaleFactor = (screenSize.size.width - 16) / oldWidth

        let newHeight = image.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        let pdfPageBounds = CGRect(origin: .zero, size: CGSize(width: newWidth, height: newHeight))
        
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        
        image.draw(in: pdfPageBounds)
        UIGraphicsEndPDFContext()

        let fileName = [resource.fileName, Constants.extensionPDF].joined()

        performWriteFile(data: pdfData as Data, filename: fileName) { result in
            switch result {
            case .success(let url):
                completion(
                    .success(
                        URLRequest(url: url)
                    )
                )
            case .error:
                completion(.error)
            }
        }
    }
}

// MARK: - Private
private extension PDFPreviewUseCase {
    func performWriteFile(data: Data, filename: String, completion: @escaping (PDFPreviewUseCaseResults.TemporaryPersistentStore) -> Void) {
        fileManagerService.writeFile(
            data: data,
            fileName: filename,
            directory: directoryPath
        ) { result in
            switch result {
            case .success(let url):
                print("URL : \(url.absoluteString)")
                completion(.success(url))
            case .failure:
                completion(.error)
            }
        }
    }
    
    func retriveDataFromNetwork(
        _ resource: DSPreviewFileResource,
        fileName: String,
        completion: @escaping (PDFPreviewUseCaseResults.TemporaryPersistentStore) -> Void
    ) {
        networkService.request(resource.request) { result in
            switch result {
            case .success(let data):
                self.performWriteFile(
                    data: data,
                    filename: fileName,
                    completion: completion
                )
            case .failure:
                completion(.error)
            }
        }
    }
    
    func getFilePathInTemporaryDirectory(_ fileName: String) -> String? {
        let documentsDirectory = FileManager
            .default
            .temporaryDirectory
            .appendingPathComponent(Constants.pdfDirectory)
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        return fileURL.path
    }
}

// MARK: - Private String
private extension String {
    func isBase64() -> Bool {
        return Data(base64Encoded: self).isNotNull
    }
    
    func removeSchemePDF() -> String {
        return self.replacingOccurrences(of: Constants.schemePDF, with: "")
    }
}
