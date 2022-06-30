import CoreLocation

internal class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {

    // MARK: Internal Initializers

    internal init(authorizationStatusChanged: @escaping (CLAuthorizationStatus) -> Void,
                  locationChanged: @escaping (CLLocation) -> Void,
                  failed: @escaping (Error) -> Void) {
        self.authorizationStatusChanged = authorizationStatusChanged
        self.failed = failed
        self.locationChanged = locationChanged
    }

    // MARK: Internal Instance Methods

    internal func locationManager(_ manager: CLLocationManager,
                                  didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatusChanged(status)
    }

    internal func locationManager(_ manager: CLLocationManager,
                                  didFailWithError error: Error) {
        failed(error)
    }

    internal func locationManager(_ manager: CLLocationManager,
                                  didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last
        else { return }

        locationChanged(location)
    }

    // MARK: Private Instance Properties

    private let authorizationStatusChanged: (CLAuthorizationStatus) -> Void
    private let failed: (Error) -> Void
    private let locationChanged: (CLLocation) -> Void
}
