import UIKit

protocol AddDiettoVCDelegate {
    func close(_ addDiettoVC: AddDiettoVC)
    func saveDietto(_ dietto: Dietto)
}

class AddDiettoVC: UIViewController {

    @IBOutlet weak var addDiettoButton: UIButton!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldMonday: UITextField!
    @IBOutlet weak var textFieldTuesday: UITextField!
    @IBOutlet weak var textFieldWednesday: UITextField!
    @IBOutlet weak var textFieldThursday: UITextField!
    @IBOutlet weak var textFieldFriday: UITextField!
    @IBOutlet weak var textFieldSaturday: UITextField!
    @IBOutlet weak var textFieldSunday: UITextField!
    
    var delegate: AddDiettoVCDelegate?
    var textFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonStyle()
        prepareTextFields()
    }
    
    // Hide keyboard when user taps around.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func prepareTextFields() {
        textFieldTitle.delegate = self
        textFieldMonday.delegate = self
        textFieldTuesday.delegate = self
        textFieldWednesday.delegate = self
        textFieldThursday.delegate = self
        textFieldFriday.delegate = self
        textFieldSaturday.delegate = self
        textFieldSunday.delegate = self
        textFields = [textFieldTitle, textFieldMonday, textFieldTuesday, textFieldWednesday, textFieldThursday, textFieldFriday, textFieldSaturday, textFieldSunday]
    }
    
    func updateButtonStyle() {
        // Give button rounded corners.
        addDiettoButton.layer.cornerRadius = addDiettoButton.frame.height / 2
    }
    
    func prepareDietto() -> Dietto {
        let newDietto = Dietto(title: textFieldTitle.text ?? "",
                               createdDate: "",
                               monday: textFieldMonday.text ?? "",
                               tuesday: textFieldTuesday.text ?? "",
                               wednesday: textFieldWednesday.text ?? "",
                               thursday: textFieldThursday.text ?? "",
                               friday: textFieldFriday.text ?? "",
                               saturday: textFieldSaturday.text ?? "",
                               sunday: textFieldSunday.text ?? "")
        return newDietto
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure?", message: "The Dietto will not be added.", preferredStyle: .alert)
        let goBackAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        let exitAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.destructive) {
            UIAlertAction in self.delegate?.close(self)
        }
        alertController.view.tintColor = UIColor.black
        alertController.addAction(exitAction)
        alertController.addAction(goBackAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        for textField in textFields {
            print("Field: \(textField)")
            if textField.text == "" {
                print("Fuck: \(textField)")
                showAlert(withTitle: "Hold your horses!", message: "We need to fill in everything first.")
                return
            }
        }
        delegate?.saveDietto(prepareDietto())
    }
}

extension AddDiettoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldTitle:
            textFieldTitle.resignFirstResponder()
            textFieldMonday.becomeFirstResponder()
        case textFieldMonday:
            textFieldMonday.resignFirstResponder()
            textFieldTuesday.becomeFirstResponder()
        case textFieldTuesday:
            textFieldTuesday.resignFirstResponder()
            textFieldWednesday.becomeFirstResponder()
        case textFieldWednesday:
            textFieldWednesday.resignFirstResponder()
            textFieldThursday.becomeFirstResponder()
        case textFieldThursday:
            textFieldThursday.resignFirstResponder()
            textFieldFriday.becomeFirstResponder()
        case textFieldFriday:
            textFieldFriday.resignFirstResponder()
            textFieldSaturday.becomeFirstResponder()
        case textFieldSaturday:
            textFieldSaturday.resignFirstResponder()
            textFieldSunday.becomeFirstResponder()
        default:
            textFieldSunday.resignFirstResponder()
        }
        return true
    }
}
