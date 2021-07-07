//
//  TableVC.swift
//  Students Llst
//
//  Created by Всеволод on 06.07.2021.
//

import UIKit

class TableVC: UITableViewController {
    
    var students = [ Students(name: "Vsevolod", surname: "Pushin", averageScore: "5") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindSegue( segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveSegue" else { return }
        let vc = segue.source as! ViewController
        let studVC = vc.studentsVC
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            students[selectedRow.row] = studVC
            tableView.reloadRows(at: [selectedRow], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: students.count, section: 0)
            students.append(studVC)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editInfo" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let pupils = students[indexPath.row]
        let nvc = segue.destination as! UINavigationController
        let newvc = nvc.topViewController as! ViewController
        newvc.studentsVC = pupils
        newvc.title = "Edit"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let person = students[indexPath.row]
        cell.set(person: person)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }    
    }
}
