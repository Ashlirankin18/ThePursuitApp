//
//  EditVC.swift
//  ThePursuit
//
//  Created by Yaz Burrell on 3/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

protocol EditVCDelegate: AnyObject {
func saveButtonPressed(_ editHeaderView: EditProfileView)
func saveImagePressed(_ editHeaderView: EditProfileView)

}

class EditProfileView: UIView {
    
    @IBOutlet weak var userImage: CircularButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cohortTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    weak var delegate: EditVCDelegate?
    public var pursuitUsers: PAUser?
    
    
    @IBAction func imageButtonPressed(_ sender: CircularButton){
        delegate?.saveImagePressed(self)
       
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let imageData = userImage.currentImage?.jpegData(compressionQuality: 1.0),             let firstname = nameTextField.text,
            let username = nicknameTextField.text,
            let bio = bioTextField.text, let pursuitUser = pursuitUsers, pursuitUser != nil else {
                print("missing fields")
                return
        }
        var profileImage = ""
        StorageService.postImage(imageData: imageData, imageName: pursuitUser.PAUserId) { [weak self] (error, imageUrl) in
            if let error = error {
                //                self?.showAlert(title:"Error Saving Photo", message: error.localizedDescription)
            } else if let imageUrl = imageUrl {
                profileImage = imageUrl.absoluteString
                DBService.firestoreDB
                    .collection(PAUserCollectionKeys.CollectionKey)
                    .document(pursuitUser.PAUserId)
                    .updateData([PAUserCollectionKeys.PhotoURLKey : profileImage])
            }
            
            DBService.firestoreDB
                .collection(PAUserCollectionKeys.CollectionKey)
                .document(pursuitUser.PAUserId)
                .updateData([
                    PAUserCollectionKeys.NicknameKey : self!.nameTextField,
                    PAUserCollectionKeys.FirstNameKey : firstname,
                    PAUserCollectionKeys.BioKey : bio
                    ], completion: { (error) in
                        if let error = error {
                            print(error)
                        } else {
                            //                            self?.showAlert(title: "Profile updated", message: nil)
                        }
                })
        }
        //performSegue(withIdentifier: "Edit Bio", sender: self)
        
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("EditVC", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }
}
