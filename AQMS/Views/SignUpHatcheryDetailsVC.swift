//
//  RegistrationHatcheryDetailsVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/3/22.
//

import Foundation
import UIKit

class SignUpHatcheryDetailsVC: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    func updateUI() {
        claimOwnershipBtn.titleLabel?.addCharacterSpacing()
        let hatcheryDetails = viewModel?.getSelectedHatcheryDetails()
        nameTitleLbl.text = "Name"
        regDateTitleLbl.text = "CAA Registration Date"
        issueDateTitleLbl.text = "Issuing Date"
        expiryDateTitleLbl.text = "Expiry Date"
        permittedSpcciesTitleLbl.text = "Permitted Species"
        
        nameValueLbl.text = hatcheryDetails?.name
        regDateValueLbl.text = hatcheryDetails?.license?.validFrom
        issueDateValueLbl.text = hatcheryDetails?.license?.issuingDate
        expiryDateValueLbl.text = hatcheryDetails?.license?.validTo
        permittedSpcciesValueLbl.text = hatcheryDetails?.permittedSpeciesID?.name
    }
    
    
    @IBAction func claimOwnershipAction(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: MAIN_STORYOARD, bundle: nil)
        let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: REGISTRATION_PAGE_IDENTIFIER) as! RegistrationVC
        signUpVC.viewModel = viewModel
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}



