//
//  ViewController.swift
//  Students Llst
//
//  Created by Всеволод on 06.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var studentsVC = Students(name: "", surname: "", averageScore: "")
    var messageOne = "Please, enter a number from 1 to 5"
    var messageTwo = "Please, enter only English or Russian letters"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        surnameTextField.delegate = self
        averageScoreTextField.delegate = self
        hideSaveButton()
        updateUI()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let averageScore = averageScoreTextField.text ?? ""
        self.studentsVC = Students(name: name, surname: surname, averageScore: averageScore)
    }
    
    private func updateUI() {
        nameTextField.text = studentsVC.name
        surnameTextField.text = studentsVC.surname
        averageScoreTextField.text = String(studentsVC.averageScore)
    }
    
    func alertController(message: String) {
        let alertController = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    private func hideSaveButton() {
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let score = averageScoreTextField.text ?? ""
        
        saveOutlet.isEnabled = !name.isEmpty && !surname.isEmpty && !score.isEmpty
    }

    
    @IBAction func followTheText(_ sender: UITextField!) {
        hideSaveButton()
    }
    
    @IBAction func enterNameTF(_ sender: UITextField!) {
        
        guard let lastChar = sender.text?.last?.description.lowercased() else { return }
        let ruCharacters = "йцукенгшщзхъфывапролджэёячсмитьбю"
        let engCharacters = "qwertyuiopasdfghjklzxcvbnm"
        guard ruCharacters.contains(lastChar) || engCharacters.contains(lastChar) else {
            alertController(message: messageTwo)
            sender.text?.removeLast()
            return
        }
    }
    
    @IBAction func averageAction(_ sender: UITextField) {
        guard let lastChar = sender.text?.last?.description.lowercased() else { return }
        let numbers = "12345"
        guard numbers.contains(lastChar) else {
            alertController(message: messageOne)
            sender.text?.removeLast()
            return
        }
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var averageScoreTextField: UITextField!
    
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
    
    //ограничение ввода символов до 1
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == averageScoreTextField {
            
            let length = !string.isEmpty ? averageScoreTextField.text!.count + 1 : averageScoreTextField.text!.count - 1
            
            if length > 1 {
                alertController(message: messageOne)
                return false
            }
        }
        return true
    }
}
