//
//  EditProfileVC.swift
//  ThePursuit
//
//  Created by Yaz Burrell on 3/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Kingfisher
import Toucan

class EditProfileVC: UIViewController,EditVCDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func willSaveInfo(_ editHeaderView: EditProfileView) {
        
    }
    
    func saveButtonPressed(_ editHeaderView: EditProfileView) {
        
    }
    
    func saveImagePressed(_ editHeaderView: EditProfileView) {
        var actionTitles = [String]()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionTitles = ["Photo Library", "Camera"]
        } else {
            actionTitles = ["Photo Library"]
        }
        present(imagePickerController, animated: true)
//        showAlert(message: nil,  cancelButtonTitle: actionTitles, destructiveButtonTitle: [{ [unowned self] photoLibraryAction in
//            self.imagePickerController.sourceType = .photoLibrary
//            self.present(self.imagePickerController, animated: true)
//            }, { cameraAction in
//                self.imagePickerController.sourceType = .camera
//                self.present(self.imagePickerController, animated: true)
//            }
//            ])
        
    }
    
    
    @IBOutlet weak var  editProfileView: EditProfileView!

    public var pursuitUser: PAUser?
    public lazy var editHeaderView: EditProfileView = {
        let headerView = EditProfileView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 270))
        return headerView
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    private let authServices = AppDelegate.authService

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func updateProfileUI() {
        editProfileView.nameTextField.text = pursuitUser?.firstName
        editProfileView.cohortTextField.text = pursuitUser?.lastName
        editProfileView.emailTextField.text = pursuitUser?.email
        editProfileView.bioTextField.text = pursuitUser?.bio
        editProfileView.userImage.kf.setImage(with: URL(string: pursuitUser?.photoURL ?? ""), for: .normal, placeholder: #imageLiteral(resourceName: "placeholder"))

    }
    
    
}
