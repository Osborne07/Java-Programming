//
//  TutorialVC.swift
//  Java Programming app
//
//  Created by Jon Snow on 10/01/24.
//

import UIKit

struct DataModel : Codable{
    let chapter : [ChapterModel]?
    let topic : [TopicModel]?
}
struct ChapterModel : Codable{
    let chapter_id : String?
    let chapter_name : String?
}

struct TopicModel : Codable{
    let topic_id : String?
    let topic_name : String?
    let topic_content : String?
}

class TutorialVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var TutorialArray = [DataModel]()
    var hiddenSections = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TutorialTVC", bundle: .main), forCellReuseIdentifier: "TutorialTVC")
        tableView.register(UINib(nibName: "HeadTVC", bundle: .main), forCellReuseIdentifier: "HeadTVC")
        tableView.dataSource = self
        tableView.delegate = self
        
        TutorialsAPI()
        
    }
    
    func TutorialsAPI(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/javapro/chapters_list") else { return }
        let request = URLRequest (url: url)
        
        URLSession.shared.dataTask(with: request){data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let data = try JSONDecoder().decode([DataModel].self, from: data)
//                    print (data)
                    self.TutorialArray = data
                    
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
    

   


extension TutorialVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TutorialArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hiddenSections.contains(section) ? 0 : TutorialArray[section].topic?.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = createHeaderView(section: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func createHeaderView(section: Int) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44))
        headerView.backgroundColor = UIColor.lightGray
        
        let button = UIButton(type: .custom)
        button.frame = headerView.bounds
        button.tag = section
        button.addTarget(self, action: #selector(headButtonTapped(_:)), for: .touchUpInside)
        headerView.addSubview(button)

        if let chapterInSection = TutorialArray[section].chapter, !chapterInSection.isEmpty {
            button.setTitle(chapterInSection[0].chapter_name, for: .normal)
        }

        return headerView
    }

    @objc func headButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        if hiddenSections.contains(section) {
            hiddenSections.remove(section)
        } else {
            hiddenSections.insert(section)
        }
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TutorialTVC", for: indexPath) as! TutorialTVC
            
            if indexPath.row == 0 {
                // Hide namelabel for the first row in each section
                cell.namelabel.isHidden = true
            } else {
                cell.namelabel.isHidden = hiddenSections.contains(indexPath.section)
                
                if let topicsInSection = TutorialArray[indexPath.section].topic {
                    if indexPath.row < topicsInSection.count {
                        cell.namelabel.text = topicsInSection[indexPath.row].topic_name
                    } else {
                        cell.namelabel.text = "No Topic Name"
                    }
                } else {
                    cell.namelabel.text = "No Topic Available"
                }
            }
            
            return cell
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
