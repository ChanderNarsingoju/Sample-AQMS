//
//  SignUpVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/3/22.
//

import Foundation
import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var selectPermitTF: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var detailLbl: UILabel!
    
    let viewModel: SignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        viewModel.getUnregisteredHatcheries { success in
            
        } onError: { error in
            
        }

    }

    func updateUI() {
        submitBtn.titleLabel?.addCharacterSpacing()
        
        detailLbl.text = "COASTAL AQUACULTURE AUTHORITY \n Department of fisheries \n Ministry of fisheries \n\n\n Animal husbandry and Dairying \n Government of India \n\n\n Chennai-600 035. Tamilnadu, India. \n Phone : 044-24353502 \n\n\n Web : www.caa.gov.in \n\n\n Email : aquaauth@vsnl.net \n                  aquaauth@gmail.com"
    }
    
    @IBAction func submitActon(_ sender: Any) {
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


