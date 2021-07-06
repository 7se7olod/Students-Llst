//
//  ViewController.swift
//  Students Llst
//
//  Created by Всеволод on 06.07.2021.
//

import UIKit

class ViewController: UIViewController {

    var studentsVC = Students(name: "", surname: "", averageScore: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        surnameTextField.delegate = self
        averageScoreTextField.delegate = self
        updateUI()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let averageScore = averageScoreTextField.text ?? ""
        self.studentsVC = Students(name: name, surname: surname, averageScore: Int(averageScore)!)
    }
    
    private func updateUI() {
        nameTextField.text = studentsVC.name
        surnameTextField.text = studentsVC.surname
        averageScoreTextField.text = String(studentsVC.averageScore)
    }
    
    func alertController() {
        let alertController = UIAlertController(title: "Error", message: "enter a number from 1 to 5", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func enterNameTF(_ sender: Any) {
        
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var averageScoreTextField: UITextField!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var saveOutlet: UIBarButtonItem!
    

}

extension ViewController: UITextFieldDelegate {
    
    //скрытие клавиатуры по нажатию на область вне клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //переход на следующий TF по кнопке next/далее
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        averageScoreTextField.resignFirstResponder()
        
        if textField == nameTextField {
            textField.resignFirstResponder()
            surnameTextField.becomeFirstResponder()
        } else if textField == surnameTextField {
            textField.resignFirstResponder()
            averageScoreTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == averageScoreTextField {
            
            let allowedNumbers = CharacterSet(charactersIn:"12345")
            let characterSet = CharacterSet(charactersIn: string)
            
            let length = !string.isEmpty ? averageScoreTextField.text!.count + 1 : averageScoreTextField.text!.count - 1
            
            if length > 1 {
                alertController()
                return false
            }
            return allowedNumbers.isSuperset(of: characterSet)
        }
        return true
    }
}
