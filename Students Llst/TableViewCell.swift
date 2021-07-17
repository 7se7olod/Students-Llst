//
//  TableViewCell.swift
//  Students Llst
//
//  Created by Всеволод on 06.07.2021.
//

import UIKit
import CoreData

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var averageScore: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    
    //метод добаляет значения в лэйблы
    func set(person: Student) {
        nameLabel.text = person.nameEntity
        surnameLabel.text = person.surnameEntity
        averageScore.text = person.averageScoreEntity
    }
    
}
