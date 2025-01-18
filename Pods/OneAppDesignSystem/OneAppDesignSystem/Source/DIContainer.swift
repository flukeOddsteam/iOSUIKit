//
//  DIContainer.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/5/2567 BE.
//

import Foundation

struct DIContainer {

    static let shared: DIContainer = DIContainer()

    var networkSession: URLSession
    var networkResponseHandler: NetworkResponseHandlerInterface
    var networkService: NetworkServiceInterface
    var fileManagerService: FileManagerServiceInterface

    var pdfPreviewUseCase: PDFPreviewUseCaseInterface

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        networkSession = URLSession(configuration: configuration)
        networkResponseHandler = NetworkResponseHandler()
        networkService = NetworkService(
            networkSession: networkSession,
            networkResponseHandler: networkResponseHandler
        )

        fileManagerService = FileManagerService(fileManager: FileManager.default)
        pdfPreviewUseCase = PDFPreviewUseCase(
            fileManagerService: fileManagerService,
            networkService: networkService
        )
    }
}
