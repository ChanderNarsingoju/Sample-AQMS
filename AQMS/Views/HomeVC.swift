//
//  HomeVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/2/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class HomeVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var secondNameLbl: UILabel!
    @IBOutlet weak var thirdNameLbl: UILabel!
    @IBOutlet weak var firstIdentifierLbl: UILabel!
    @IBOutlet weak var secondIdentifierLbl: UILabel!
    @IBOutlet weak var thirdIdentifierLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel : HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
        updateUI()
        dataBinding()
    }

    func updateUI() {
        firstImageView.layer.cornerRadius = firstImageView.frame.height/2
        secondImageView.layer.cornerRadius = secondImageView.frame.height/2
        thirdImageView.layer.cornerRadius = thirdImageView.frame.height/2
        collectionView.delegate = self
        collectionView.dataSource = self
        
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func dataBinding() {
        let homeDetails = viewModel.getHomePageDetails()
        firstNameLbl.text = homeDetails.name
        firstIdentifierLbl.text = homeDetails.userName
        secondNameLbl.text = homeDetails.authOneName
        secondIdentifierLbl.text = homeDetails.authOneUserName
        thirdNameLbl.text = homeDetails.authTwoName
        thirdIdentifierLbl.text = homeDetails.authTwoUserName
        
        let userImageUrl = viewModel.generateImageUrlWith(path: homeDetails.userImage)
        firstImageView.imageFromUrl(urlString: userImageUrl)
        let authOneImageUrl = viewModel.generateImageUrlWith(path: homeDetails.authOneUserImage)
        secondImageView.imageFromUrl(urlString: authOneImageUrl)
        let authTwoImageUrl = viewModel.generateImageUrlWith(path: homeDetails.authTwoUserImage)
        thirdImageView.imageFromUrl(urlString: authTwoImageUrl)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: MAIN_STORYOARD, bundle: nil)
        let menuVC = mainStoryboard.instantiateViewController(withIdentifier: MENU_IDENTIFIER) as! MenuVC
        let navigationController = UINavigationController(rootViewController: menuVC)
        navigationController.isNavigationBarHidden = true
        
        // getting access to the window object from SceneDelegate
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        sceneDelegate.window?.rootViewController = navigationController
    }
    
    @IBAction func notificationAction(_ sender: Any) {
    }
    
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: Collection view delegate methods
    /// Collection view layout setting
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - collectionViewLayout: layout
    ///   - indexPath: index
    /// - Returns: It returns the size of the Item.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.collectionView(collectionView, sizeForItemAt: indexPath)
    }
    
    /// Number of items for sections
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - section: section
    /// - Returns: It returns the number of items for section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionView(collectionView, numberOfItemsInSection:section)
    }
    
    /// Collection view cell for item at index
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - indexPath: index
    /// - Returns: It returns the collection view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.collectionView(collectionView, cellForItemAt:indexPath)
    }
    
    /// Collection view did select item at index.
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - indexPath: index
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
