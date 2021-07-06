//
//  TableViewCell.swift
//  Students Llst
//
//  Created by Всеволод on 06.07.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var averageScore: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    
    //метод добаляет значения в лэйблы
    func set(person: Students) {
        nameLabel.text = person.name
        surnameLabel.text = person.surname
        averageScore.text = String(person.averageScore)
    }
    
}
