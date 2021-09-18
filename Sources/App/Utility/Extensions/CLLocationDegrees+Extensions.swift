import CoreLocation

public extension CLLocationDegrees {
    var degrees: Int {
        Int(rounded(.towardZero))
    }

    var minutes: Int {
        Int((abs(self) * 60)._modulo(60).rounded(.towardZero))
    }

    var seconds: Double {
        (abs(self) * 3_600)._modulo(60)
    }

    private func _modulo(_ mod: CLLocationDegrees) -> CLLocationDegrees {
        self - (mod * (self / mod).rounded(.towardZero))
    }
}
