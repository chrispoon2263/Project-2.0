//
//  SettingsViewController.swift
//  IOSProject
//
//  Created by Christopher Poon on 10/21/22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var settingList: [String] = ["Audio", "Dark Mode", "Font"]
    var textCellIdentifier: String = "TextCell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // set background image
        let backgroundImage = UIImage(named: "BG4")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
    }

    // MARK: - TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    // Displays the tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        cell.textLabel?.text = settingList[row]
        
        // Add font to each cell
        if #available(iOS 15.0, *) {
            cell.textLabel?.font = UIFont(name: "Futura Medium", size: 16.0)
        } else{
            // default to system font
        }
        return cell
    }
    // Animates the deselect row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settingList[indexPath.row] == "Audio"{
            if let navController = self.navigationController{
                // Push the BackgroundMusicVC to the stack
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BackgroundMusicViewController") as! BackgroundMusicViewController
                navController.pushViewController(vc, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
}
