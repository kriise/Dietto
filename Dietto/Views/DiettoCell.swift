import UIKit

class DiettoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var dietto: Dietto? {
        didSet {
            titleLabel.text = dietto?.title
            dateLabel.text = dietto?.createdDate
            mondayLabel.text = dietto?.monday
            tuesdayLabel.text = dietto?.tuesday
            wednesdayLabel.text = dietto?.wednesday
            thursdayLabel.text = dietto?.thursday
            fridayLabel.text = dietto?.friday
            saturdayLabel.text = dietto?.saturday
            sundayLabel.text = dietto?.sunday
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
