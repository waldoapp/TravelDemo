import Firebase

public class StorageProvider: Provider {

    // MARK: Public Instance Methods

    public func deleteFile(at path: String,
                           completion: @escaping (Result<Void, Error>) -> Void) {
        let ref = storage.reference(withPath: path)

        ref.delete {
            if let error = $0 {
                completion(.failure(Self._convertError(error)))
            } else {
                completion(.success(()))
            }
        }
    }

    public func downloadFile(at path: String,
                             maximumSize: Int = 16 * 1_024 * 1_024, // 10MB
                             completion: @escaping (Result<Data, Error>) -> Void) {
        let ref = storage.reference(withPath: path)

        ref.getData(maxSize: Int64(maximumSize)) {
            if let error = $1 {
                completion(.failure(Self._convertError(error)))
            } else {
                completion(.success($0 ?? Data()))
            }
        }
    }

    public func fetchMetadata(at path: String,
                              completion: @escaping (Result<[String: String], Error>) -> Void) {
        let ref = storage.reference(withPath: path)

        ref.getMetadata {
            if let error = $1 {
                completion(.failure(Self._convertError(error)))
            } else {
                completion(.success(Self._extractCustomMetadata($0)))
            }
        }
    }

    public func listFiles(at path: String,
                          completion: @escaping (Result<[String], Error>) -> Void) {
        let ref = storage.reference(withPath: path)

        ref.listAll {
            if let error = $1 {
                completion(.failure(Self._convertError(error)))
            } else {
                completion(.success($0.items.map { $0.fullPath }))
            }
        }
    }

    public func updateMetadata(at path: String,
                               customMetadata: [String: String],
                               completion: @escaping (Result<[String: String], Error>) -> Void) {
        let ref = storage.reference(withPath: path)

        ref.updateMetadata(Self._makeMetadata(customMetadata: customMetadata)) {
            if let error = $1 {
                completion(.failure(Self._convertError(error)))
            } else {
                completion(.success(Self._extractCustomMetadata($0)))
            }
        }
    }

    public func uploadFile(at path: String,
                           contentType: String,
                           data: Data,
                           customMetadata: [String: String]? = nil,
                           completion: @escaping (Result<[String: String], Error>) -> Void) {
        let ref = storage.reference(withPath: path)

        ref.putData(data,
                    metadata: Self._makeMetadata(contentType: contentType,
                                                 customMetadata: customMetadata)) {
            if let error = $1 {
                completion(.failure(Self._convertError(error)))
            } else {
                completion(.success(Self._extractCustomMetadata($0)))
            }
        }
    }

    // MARK: Private Type Methods

    private static func _convertError(_ error: Error) -> Error {
//        switch (error as NSError).code {
//        case StorageErrorCode.bucketNotFound.rawValue:
//            return TravelSpotError.duplicateCredentials
//
//        default:
//            return TravelSpotError.unknownCredentials
//        }

        error
    }

    private static func _extractCustomMetadata(_ metadata: StorageMetadata?) -> [String: String] {
        metadata?.customMetadata ?? [:]
    }

    private static func _makeMetadata(contentType: String? = nil,
                                      customMetadata: [String: String]? = nil) -> StorageMetadata {
        let metadata = StorageMetadata()

        if let contentType = contentType {
            metadata.contentType = contentType
        }

        if let customMetadata = customMetadata {
            metadata.customMetadata = customMetadata
        }

        return metadata
    }

    // MARK: Private Instance Properties

    private let storage: Storage

    // MARK: Overridden Provider Initializers

    override internal init(delegate: ProviderDelegate) {
        self.storage = FirebaseServices.shared.storage

        super.init(delegate: delegate)
    }
}
