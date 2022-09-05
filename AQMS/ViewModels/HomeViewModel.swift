//
//  HomeViewModel.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/2/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults

public enum HomePageOptions: String {
    case TOTAL_BOOKINGS = "Total Bookings"
    case TEST_REPORTS = "Test Reports"
    case TOTAL_TRANSACTIONS = "Total Transactions"
    case ADDITIONAL_CHARGES = "Additional Charges"
}

class HomeViewModel: NSObject {
    //MARK: Variables
    let options = [HomePageOptions.TOTAL_BOOKINGS.rawValue,
                   HomePageOptions.TEST_REPORTS.rawValue,
                   HomePageOptions.TOTAL_TRANSACTIONS.rawValue,
                   HomePageOptions.ADDITIONAL_CHARGES.rawValue]
    let icons:[UIImage] = [#imageLiteral(resourceName: "aqmsbooking"), #imageLiteral(resourceName: "aqmsinvoices"), #imageLiteral(resourceName: "aqmstransaction"), #imageLiteral(resourceName: "aqmsinvoices")]
   
    func getHomePageDetails() -> HomePageDetails {
        var homePageDetails: HomePageDetails = HomePageDetails()
        homePageDetails.name = Defaults.name
        homePageDetails.userName = Defaults.userName
        homePageDetails.userImage = Defaults.userImage
        if let authOnePersion: AuthPerson = AuthPerson(JSONString: Defaults.authOnePersion, context: .none) {
            homePageDetails.authOneName = authOnePersion.name ?? ""
            homePageDetails.authOneUserName = authOnePersion.phoneNumber ?? ""
            homePageDetails.authOneUserImage = authOnePersion.picture ?? ""
        }
        
        if let authTwoPersion: AuthPerson = AuthPerson(JSONString: Defaults.authTwoPersion, context: .none) {
            homePageDetails.authTwoName = authTwoPersion.name ?? ""
            homePageDetails.authTwoUserName = authTwoPersion.phoneNumber ?? ""
            homePageDetails.authTwoUserImage = authTwoPersion.picture ?? ""
        }
        
        return homePageDetails
    }
    
    
    //MARK: Collection view delegates methods
    /// Collection view size for cell at index path.
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - indexPath: Index
    /// - Returns: It returns the size of the cell
    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size : CGSize = CGSize(width: collectionView.frame.size.width/2 - 20, height : 150)
        return size
    }
    
    /// Number of items for sections
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - section: section
    /// - Returns: It returns the number of items for section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    /// Collection view cell for item at index
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - indexPath: index
    /// - Returns: It returns the collection view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCellIdentifier", for: indexPath) as! HomeCollectionViewCell
        let item = options[indexPath.item]
        let icon = icons[indexPath.item]
        cell.titleLabel.text = item
        cell.imageView.image = icon
        return cell
    }
    
    
    /// Collection view did select item at index
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - indexPath: index.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

struct HomePageDetails {
    var name: String = ""
    var userName: String = ""
    var authOneName: String = ""
    var authOneUserName: String = ""
    var authTwoName: String = ""
    var authTwoUserName: String = ""
    var userImage: String = ""
    var authOneUserImage: String = ""
    var authTwoUserImage: String = ""
    var numberOfNotifications: Int = 0
}

/// HomeCollectionViewCell is a class for collection view cell.
class HomeCollectionViewCell: UICollectionViewCell {
    //MARK: Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    /// awakeFromNib will call while registering the cell.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
