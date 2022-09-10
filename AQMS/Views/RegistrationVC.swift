//
//  RegistrationVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/3/22.
//

import Foundation
import UIKit
import DropDown

class RegistrationVC: UIViewController {

    @IBOutlet weak var nameTitleLbl: UILabel!
    @IBOutlet weak var regDateTitleLbl: UILabel!
    @IBOutlet weak var issueDateTitleLbl: UILabel!
    @IBOutlet weak var expiryDateTitleLbl: UILabel!
    @IBOutlet weak var permittedSpcciesTitleLbl: UILabel!
    
    @IBOutlet weak var nameValueLbl: UILabel!
    @IBOutlet weak var regDateValueLbl: UILabel!
    @IBOutlet weak var issueDateValueLbl: UILabel!
    @IBOutlet weak var expiryDateValueLbl: UILabel!
    @IBOutlet weak var permittedSpcciesValueLbl: UILabel!
    
    @IBOutlet weak var claimOwnershipBtn: UIButton!
    
    var viewModel: SignUpViewModel?
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    func updateUI() {
        claimOwnershipBtn.titleLabel?.addCharacterSpacing()
        let hatcheryDetails = viewModel?.getSelectedHatcheryDetails()
        
    }
    
    @IBAction func selectPDFFileAction(_ sender: Any) {
        let docPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        //let picker = UIDocumentPickerViewController.init(documentTypes: [".pdf", ".png", ".jpeg", ".jpg"], in: .open)

        //let picker = UIDocumentPickerViewController(documentTypes: ["public.pdf"], in: .open)

        docPicker.delegate = self

        docPicker.modalPresentationStyle = .fullScreen

        self.present(docPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func claimOwnershipAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RegistrationVC: UIDocumentPickerDelegate {
    
}


