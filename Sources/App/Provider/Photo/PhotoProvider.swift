import UIKit
import UniformTypeIdentifiers

public class PhotoProvider: Provider {

    // MARK: Public Instance Methods

    public func choosePhoto(completion: @escaping (UIImage?) -> Void) {
        choosePhotoCompletion = completion

        delegate.present(picker)
    }

    // MARK: Private Instance Properties

    private let picker: UIImagePickerController

    private var choosePhotoCompletion: ((UIImage?) -> Void)?

    private lazy var ipcDelegate = ImagePickerControllerDelegate(finished: self._ipcFinished,
                                                                 canceled: self._ipcCanceled)

    // MARK: Private Instance Methods

    private func _ipcCanceled() {
        if let completion = choosePhotoCompletion {
            choosePhotoCompletion = nil

            completion(nil)

            delegate.dismiss(picker)
        }
    }

    private func _ipcFinished(_ info: [UIImagePickerController.InfoKey: Any]) {
        if let completion = choosePhotoCompletion {
            choosePhotoCompletion = nil

            if let image = info[.editedImage] as? UIImage {
                completion(image)
            } else if let image = info[.originalImage] as? UIImage {
                completion(image)
            } else {
                completion(nil)
            }

            delegate.dismiss(picker)
        }
    }

    // MARK: Overridden Provider Initializers

    override internal init(delegate: ProviderDelegate) {
        self.picker = UIImagePickerController()

        super.init(delegate: delegate)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.picker.sourceType = .camera        // MUST be set first
            self.picker.cameraCaptureMode = .photo
            self.picker.cameraDevice = .rear
        } else {
            self.picker.sourceType = .photoLibrary
        }

        self.picker.delegate = self.ipcDelegate

        if #available(iOS 14.0, *) {
            self.picker.mediaTypes = [UTType.image.identifier]
        } else {
            self.picker.mediaTypes = ["public.image"]
        }
    }
}
