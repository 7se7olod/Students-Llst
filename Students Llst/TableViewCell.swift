
import UIKit
import CoreData


class TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLabelOfStudent.layer.cornerRadius = 15
    }

    @IBOutlet var imageLabelOfStudent: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var averageScore: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    
    
    //метод добаляет значения в лэйблы
    func set(person: Student) {
        nameLabel.text = person.nameEntity
        surnameLabel.text = person.surnameEntity
        averageScore.text = person.averageScoreEntity
        imageLabelOfStudent.image = UIImage(data: (person.imageStudentEntity ?? imageSt?.pngData())!)
    }
    
}
