import UIKit

internal class ImagePickerControllerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Internal Initializers

    internal init(finished: @escaping ([UIImagePickerController.InfoKey: Any]) -> Void,
                  canceled: @escaping () -> Void) {
        self.canceled = canceled
        self.finished = finished
    }

    // MARK: Internal Instance Methods

    internal func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        finished(info)
    }

    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        canceled()
    }

    // MARK: Private Instance Properties

    private let canceled: () -> Void
    private let finished: ([UIImagePickerController.InfoKey: Any]) -> Void
}
