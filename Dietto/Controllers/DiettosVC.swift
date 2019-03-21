import UIKit

class DiettosVC: UIViewController {
    
    // Declare  outlets as referrable variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    // Declare variables for easy reuse
    let diettoCellId = "DiettoCell"
    
    // Declare user defaults key
    let localDiettoKey = "localDietto"
    
    // Declare Dietto data model
    var diettos: [Dietto]  = [Dietto]() {
        didSet {
            // Save diettos to user defaults
            UserDefaults.standard.set(try? PropertyListEncoder().encode(diettos), forKey:localDiettoKey)
            print("Dietto saved to user defaults.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assign the table's data source and delegate.
        tableView.dataSource = self
        tableView.delegate = self
        // Register a custom Dietto table cell identifier.
        tableView.register(UINib(nibName: diettoCellId, bundle: nil), forCellReuseIdentifier: diettoCellId)
        // Add an empty view in the bottom of the table (a trick to make list finite).
        tableView.tableFooterView = UIView()
        // Update user interface stuff
        updateButtonStyle()
        updateDiettos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDietto" {
            if let vc = segue.destination as? AddDiettoVC {
                vc.delegate = self
            }
        }
    }
    
    func updateButtonStyle() {
        // Give button rounded corners.
        addButton.layer.cornerRadius = addButton.frame.height / 2
        // Inset button content (text in label) to be centered-ish.
        addButton.contentEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0);
    }
    
    func updateDiettos() {
        if diettos.isEmpty {
            // Try to get data from user defaults
            if let data = UserDefaults.standard.value(forKey:localDiettoKey) as? Data {
                if let diettos = try? PropertyListDecoder().decode(Array<Dietto>.self, from: data) {
                    self.diettos = diettos
                }
                tableView.reloadData()
                print("Diettos reloaded from user defaults.")
            }
        }
    }
    
    func createNewDietto() {
        // Update table view.
        tableView.beginUpdates()
        // Add dietto at first row.
        tableView.insertRows(at: [IndexPath(row: diettos.count-1, section: 0)], with: .automatic)
        // Stop updating table view.
        tableView.endUpdates()
    }
    
    func addDietto(_ dietto: Dietto) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "(yyyy-MM-dd HH:mm)"
        let todaysDate = dateFormatter.string(from: date)
        diettos.append(Dietto(title: dietto.title,
                              createdDate: todaysDate,
                              monday: dietto.monday,
                              tuesday: dietto.tuesday,
                              wednesday: dietto.wednesday,
                              thursday: dietto.thursday,
                              friday: dietto.friday,
                              saturday: dietto.saturday,
                              sunday: dietto.sunday))
    }
    
    func countDiettos() {
        print(diettos.count)
    }
    
    func removeDietto(number: Int) {
        diettos.remove(at: number)
        tableView.reloadData()
        print("Dietto removed.")
        countDiettos()
    }
}

extension DiettosVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diettos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: diettoCellId) as! DiettoCell
        if let titleLabel = cell.titleLabel {
            titleLabel.text = "Helo"
        }
        let lastItem = diettos[indexPath.row]
        cell.dietto = lastItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set custom row height.
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: diettoCellId) as! DiettoTableViewCell
        // Do something awesome.
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Allow user to edit rows.
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // Delete Dietto when user taps Delete.
            removeDietto(number: indexPath.row)
        }
    }
}

extension DiettosVC: AddDiettoVCDelegate {
    func close(_ addDiettoVC: AddDiettoVC) {
        dismiss(animated: true)
    }
    
    func saveDietto(_ dietto: Dietto) {
        addDietto(dietto)
        tableView.reloadData()
        countDiettos()
        dismiss(animated: true)
    }
}
