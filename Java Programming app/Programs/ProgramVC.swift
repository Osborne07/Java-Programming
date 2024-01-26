//
//  ProgramVC.swift
//  Java Programming app
//
//  Created by Jon Snow on 10/01/24.
//

import UIKit
struct Programs : Codable {
    var id : String?
    var program_name : String?
    var program_code : String?
    var output : String?
}

class ProgramVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var HeadLabel: UILabel!
    
    
    var ProgramsArray = [Programs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProgramsTVC", bundle: .main), forCellReuseIdentifier: "ProgramsTVC")
        tableView.delegate = self
        tableView.dataSource = self
        ProgramsAPI()
        
    }
    
    func ProgramsAPI(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/javapro/programs_list") else { return }
        let request = URLRequest (url: url)
        
        URLSession.shared.dataTask(with: request){data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let data = try JSONDecoder().decode([Programs].self, from: data)
                    print (data)
                    self.ProgramsArray = data
                    
                }catch{
                    print("Error in do Block")
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }.resume()
    }
}

extension ProgramVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProgramsArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramsTVC", for: indexPath) as! ProgramsTVC
        cell.NameLabel.text = ProgramsArray[indexPath.row].program_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProgramDisp", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProgramDispVC") as! ProgramDispVC
        vc.ProgramsData = ProgramsArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
