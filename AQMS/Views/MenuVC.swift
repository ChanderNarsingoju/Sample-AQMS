//
//  MenuVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/3/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class MenuVC: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var firstIdentifierLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel : MenuViewModel = MenuViewModel()
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func dataBinding() {
        firstNameLbl.text = Defaults.name
        firstIdentifierLbl.text = Defaults.userName
    }
    
}

extension MenuVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        viewModel.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
}

