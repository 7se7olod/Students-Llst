import UIKit
import CoreData

class EditStudentTVC: UITableViewController {
    
    var students = Student()
    var messageOne = "Пожалуйста, введите средний балл от 1 до 5"
    var messageTwo = "Допустимы только русские или английскте буквы"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        surnameTF.delegate = self
        scoreTF.delegate = self
        hideSaveButton()
        updateUI()
        title = "Редактировать"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editSegue" else { return }
        let name = nameTF.text ?? ""
        let surname = surnameTF.text ?? ""
        let averageScore = scoreTF.text ?? ""
        updateStudent(student: students, name: name, surname: surname, averageScore: averageScore)
    }
    
    func updateStudent(student: Student,name: String, surname: String, averageScore: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        student.nameEntity = name
        student.surnameEntity = surname
        student.averageScoreEntity = averageScore
        
        do {
            try context.save()
            students = student
            print("Edited student in CoreData!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func alertController(message: String) {
        let alertController = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    private func hideSaveButton() {
        let name = nameTF.text ?? ""
        let surname = surnameTF.text ?? ""
        let score = scoreTF.text ?? ""
        saveButtonOutlet.isEnabled = !name.isEmpty && !surname.isEmpty && !score.isEmpty
    }
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var surnameTF: UITextField!
    @IBOutlet var scoreTF: UITextField!
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    
    @IBAction func onlyEngAndRus(_ sender: UITextField) {
        guard let lastChar = sender.text?.last?.description.lowercased() else { return }
        let ruCharacters = "йцукенгшщзхъфывапролджэёячсмитьбю"
        let engCharacters = "qwertyuiopasdfghjklzxcvbnm"
        guard ruCharacters.contains(lastChar) || engCharacters.contains(lastChar) else {
            alertController(message: messageTwo)
            sender.text?.removeLast()
            return
        }
    }
    
    @IBAction func hideSaveButton(_ sender: UITextField) {
        hideSaveButton()
    }
    
    @IBAction func onlyNumber(_ sender: UITextField) {
        guard let lastChar = sender.text?.last?.description.lowercased() else { return }
        let numbers = "12345"
        guard numbers.contains(lastChar) else {
            alertController(message: messageOne)
            sender.text?.removeLast()
            return
        }
    }
    
    private func updateUI() {
        nameTF.text = students.nameEntity
        surnameTF.text = students.surnameEntity
        scoreTF.text = students.averageScoreEntity
        print("Update view in EditTVC")
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}


extension EditStudentTVC: UITextFieldDelegate {
    
    //скрытие клавиатуры по нажатию на область вне клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //переход на следующий TF по кнопке next/далее
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scoreTF.resignFirstResponder()
        
        if textField == nameTF {
            textField.resignFirstResponder()
            surnameTF.becomeFirstResponder()
        } else if textField == surnameTF {
            textField.resignFirstResponder()
            scoreTF.becomeFirstResponder()
        }
        return true
    }
    
    //ограничение ввода символов до 1
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == scoreTF {
            
            let length = !string.isEmpty ? scoreTF.text!.count + 1 : scoreTF.text!.count - 1
            
            if length > 1 {
                alertController(message: messageOne)
                return false
            }
        }
        return true
    }
}
