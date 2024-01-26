//
//  ProgramDispVC.swift
//  Java Programming app
//
//  Created by Jon Snow on 11/01/24.
//

import UIKit


class ProgramDispVC: UIViewController {

    @IBOutlet weak var LabelHead: UILabel!
    
    @IBOutlet weak var SubHeadLabel: UILabel!
    
   
    @IBOutlet weak var codeText: UITextView!
    
    @IBOutlet weak var AnsLabel: UILabel!
    
    var ProgramsData : Programs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: ProgramsData?.id ?? "")
        self.SubHeadLabel.text = ProgramsData?.program_name ?? ""
        self.codeText.text = ProgramsData?.program_code ?? ""
        self.AnsLabel.text = ProgramsData?.output ?? ""

        
    }

}
