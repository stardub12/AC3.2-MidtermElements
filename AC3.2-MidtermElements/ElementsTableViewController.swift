//
//  ElementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Simone on 12/8/16.
//  Copyright © 2016 Simone. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {
    let baseURL = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    
    var elements = [Elements]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    
    }
    
    //MARK: - Loading function
    func loadData () {
        APIRequestManager.manager.getData(endPoint: baseURL) { (data) in
            if let validData = data {
                if let elementList = Elements.getElements(data: validData) {
                    print("Got \(elementList.count) elements!")
                    self.elements = elementList
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
       // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementsCell", for: indexPath)
        let info = elements[indexPath.row]
        cell.textLabel?.text = "\(info.name)"
        cell.detailTextLabel?.text = "\(info.symbol) \(info.weight)"
        
        // Cell Image
        let thumbbaseURL = "https://s3.amazonaws.com/ac3.2-elements/\(info.symbol)_200.png"
        APIRequestManager.manager.getData(endPoint: thumbbaseURL) { (data) in
            if let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.imageView?.image = validImage
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? UITableViewCell {
            if segue.identifier == "elementSegue" {
                let details = segue.destination as! ViewController
                let cellPath = self.tableView.indexPath(for: selectedCell)
                let selectedElement = elements[(cellPath?.row)!]
                details.elementDetails = selectedElement
            }
        }
     }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
}
