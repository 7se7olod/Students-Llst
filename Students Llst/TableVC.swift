import UIKit
import CoreData

class TableVC: UITableViewController {
    
    var students: [Student] = []
    
    override func viewDidAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        
        do {
            students = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func unwindSegue( segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveSegue" else { return }
        let vc = segue.source as! SecondTableViewController
        let sTVC = vc.studentSTVC
        let newIndexPath = IndexPath(row: students.count, section: 0)
        students.append(sTVC)
        tableView.insertRows(at: [newIndexPath], with: .fade)
        print("Add student \(sTVC.nameEntity!), \(sTVC.surnameEntity!), \(sTVC.averageScoreEntity!)")
    }
    
    @IBAction func unwindEditSegue(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "editSegue" else { return }
        let etvc = segue.source as! EditStudentTVC
        let stud = etvc.students
        
        guard let selectedRow = tableView.indexPathForSelectedRow else {return}
        students[selectedRow.row] = stud
        tableView.reloadRows(at: [selectedRow], with: .fade)
        print("Edit student to \(stud.nameEntity!),\(stud.surnameEntity!),\(stud.averageScoreEntity!) ")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "editInfo" else { return }
        let nvc = segue.destination as! UINavigationController
        let newvc = nvc.topViewController as! EditStudentTVC
        let indexPath = tableView.indexPathForSelectedRow!
        let pupils = students[indexPath.row]
        newvc.students = pupils
        newvc.title = "Edit"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let studentDelete = students[indexPath.row]
            students.remove(at: indexPath.row)
            
            context.delete(studentDelete)
            print("Deleted student \(studentDelete.nameEntity!),\(studentDelete.surnameEntity!),\(studentDelete.averageScoreEntity!)")
            do {
                try context.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } catch let error as NSError {
                print("Error \(error), description \(error.userInfo)")
            }
        }
    }
}
