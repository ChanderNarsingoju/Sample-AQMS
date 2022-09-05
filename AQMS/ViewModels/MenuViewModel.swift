//
//  MenuViewModel.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/3/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults

public enum MenuOptions: String {
    case DASHBOARD = "Dashboard"
    case BOOK_NOW = "Book Now"
    case MY_BOOKINGS = "My Bookings"
    case MY_HATCHERY_DETAILS = "My Hatchery Details"
    case ADDITIONAL_CHARGES = "Additional Charges"
    case TRANSACTIONS = "Transactions"
    case TEST_REPORTS = "Test Reports"
    case NOTIFICATIONS = "Notifications"
    case HOW_TO_USE = "How To Use"
    case LOGOUT = "Logout"
}

class MenuViewModel: BaseViewModel {
    //MARK: Variables
    
    let menuItems = [MenuOptions.DASHBOARD.rawValue,
                     MenuOptions.BOOK_NOW.rawValue,
                     MenuOptions.MY_BOOKINGS.rawValue,
                     MenuOptions.MY_HATCHERY_DETAILS.rawValue,
                     MenuOptions.ADDITIONAL_CHARGES.rawValue,
                     MenuOptions.TRANSACTIONS.rawValue,
                     MenuOptions.TEST_REPORTS.rawValue,
                     MenuOptions.NOTIFICATIONS.rawValue,
                     MenuOptions.HOW_TO_USE.rawValue,
                     MenuOptions.LOGOUT.rawValue]
    let menuIcons = [#imageLiteral(resourceName: "dashboard_icon"), #imageLiteral(resourceName: "book_now_icon"), #imageLiteral(resourceName: "my_booking_icon"), #imageLiteral(resourceName: "hatchery_icon"), #imageLiteral(resourceName: "hatchery_icon"), #imageLiteral(resourceName: "transactions_icon"), #imageLiteral(resourceName: "test_reports_icon"), #imageLiteral(resourceName: "notifications_icon"), #imageLiteral(resourceName: "test_reports_icon"), #imageLiteral(resourceName: "logout_icon")]
    
    //MARK: Collection view delegates methods
    /// Collection view size for cell at index path.
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - indexPath: Index
    /// - Returns: It returns the size of the cell
    func collectionView(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size : CGSize = CGSize(width: collectionView.frame.size.width - 10, height : 65)
        return size
    }
    
    /// Number of items for sections
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - section: section
    /// - Returns: It returns the number of items for section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    /// Collection view cell for item at index
    ///
    /// - Parameters:
    ///   - collectionView: collection view
    ///   - indexPath: index
    /// - Returns: It returns the collection view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCellIdentifier", for: indexPath) as! MenuCollectionViewCell
        let item = menuItems[indexPath.item]
        let icon = menuIcons[indexPath.item]
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
        let item = menuItems[indexPath.item]
        switch item {
        case MenuOptions.DASHBOARD.rawValue:
            self.gotoHomePage()
            break
        case MenuOptions.MY_BOOKINGS.rawValue:
            break
        case MenuOptions.BOOK_NOW.rawValue:
            break
        case MenuOptions.MY_HATCHERY_DETAILS.rawValue:
            break
        case MenuOptions.ADDITIONAL_CHARGES.rawValue:
            break
        case MenuOptions.TRANSACTIONS.rawValue:
            break
        case MenuOptions.TEST_REPORTS.rawValue:
            break
        case MenuOptions.NOTIFICATIONS.rawValue:
            break
        case MenuOptions.HOW_TO_USE.rawValue:
            break
        case MenuOptions.LOGOUT.rawValue:
            // create the alert
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: UIAlertController.Style.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                
                // do something like...
                Defaults.accessToken = ""
                self.gotoLoginPage()

            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
            
            // getting access to the window object from SceneDelegate
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate
            else {
                return
            }
           
            // show the alert
            sceneDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
}


/// HomeCollectionViewCell is a class for collection view cell.
class MenuCollectionViewCell: UICollectionViewCell {
    //MARK: Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    /// awakeFromNib will call while registering the cell.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
