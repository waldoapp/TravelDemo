import CoreLocation

public class LocationProvider: Provider {

    // MARK: Public Instance Methods

    public func requestAccess(completion: @escaping (Result<Access, Error>) -> Void) {
        if let access = currentAccess {
            completion(.success(access))
        } else {
            requestAccessCompletion = completion

            manager.requestWhenInUseAuthorization()
        }
    }

    public func requestLocation(completion: @escaping (Result<Location, Error>) -> Void) {
        requestLocationCompletion = completion

        manager.requestLocation()
    }

    // MARK: Private Instance Properties

    private let manager: CLLocationManager

    private var requestAccessCompletion: ((Result<Access, Error>) -> Void)?
    private var requestLocationCompletion: ((Result<Location, Error>) -> Void)?

    private lazy var lmDelegate = LocationManagerDelegate(authorizationStatusChanged: self._lmAuthorizationStatusChanged,
                                                          locationChanged: self._lmLocationChanged,
                                                          failed: self._lmFailed)

    private var currentAccess: Access? {
        guard CLLocationManager.locationServicesEnabled()
        else { return .disabled }

        let status: CLAuthorizationStatus

        if #available(iOS 14.0, *) {
            status = manager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }

        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse:
            return .allowed

        case .denied,
             .restricted:
            return .notAllowed

        case .notDetermined:
            return nil

        @unknown default:
            return .unknown
        }
    }

    // MARK: Private Instance Methods

    private func _lmAuthorizationStatusChanged(_ status: CLAuthorizationStatus) {
        if let completion = requestAccessCompletion,
           let access = currentAccess {
            requestAccessCompletion = nil

            completion(.success(access))
        }
    }

    private func _lmFailed(_ error: Error) {
        if let completion = requestAccessCompletion {
            requestAccessCompletion = nil

            completion(.failure(error))
        } else if let completion = requestLocationCompletion {
            requestLocationCompletion = nil

            completion(.failure(error))
        }
    }

    private func _lmLocationChanged(_ location: CLLocation) {
        if let completion = requestLocationCompletion {
            requestLocationCompletion = nil

            let coord = location.coordinate

            completion(.success(Location(latitude: coord.latitude,
                                         longitude: coord.longitude)))
        }
    }

    // MARK: Overridden Provider Initializers

    override internal init(delegate: ProviderDelegate) {
        self.manager = CLLocationManager()

        super.init(delegate: delegate)

        self.manager.delegate = self.lmDelegate
    }
}
