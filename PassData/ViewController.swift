//
//  ViewController.swift
//  PassData
//
//  Created by mark me on 5/26/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var array = [AddModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyTableViewCell
        
        cell.profileImage.image = array[indexPath.row].image
        cell.profileName1.text = array[indexPath.row].field1
        cell.profileName2.text = array[indexPath.row].field2
        cell.profileName3.text = array[indexPath.row].field3
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 221
    }
    
    @IBAction func addItem(_ sender: Any)
    {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let nextViewController = segue.destination as? ProfileViewController {
                nextViewController.delegate = self
            }
        }
    }
    
}


extension ViewController:AddModelProtocol {
    func didAddToArray(didAdd: AddModel) {
        
        array.append(didAdd)
        self.tableView.reloadData()
        
        
    }

}
