//
//  ViewController.swift
//  Java Programming app
//
//  Created by Jon Snow on 10/01/24.
//


import UIKit

struct UIimages : Codable{
    var image : String
    var name : String
}

class ViewController: UIViewController {
    
    let ImageArray : [UIimages] =
    [
        UIimages(image: "online-learning", name: "Tutorialss"),
        UIimages(image: "coding", name: "Programs"),
        UIimages(image: "interview", name: "Interview Questions"),
        UIimages(image: "quiz", name: "Quiz")
        
    ]

    @IBOutlet weak var Headimg: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "UICVC", bundle: .main), forCellWithReuseIdentifier: "UICVC")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICVC", for: indexPath) as! UICVC
        cell.Imgui.image = UIImage(named: ImageArray[indexPath.row].image)
        cell.nameLabel.text = ImageArray[indexPath.row].name
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 1 :
            let vc = storyboard?.instantiateViewController(identifier: "ProgramVC") as! ProgramVC
            self.navigationController?.pushViewController(vc, animated: true)
            
//        case 2 :
//            let vc = storyboard?.instantiateViewController(identifier: "InterviewVC") as! InterviewVC
//            self.navigationController?.pushViewController(vc, animated: true)
            
        case 3 :
            let vc = storyboard?.instantiateViewController(identifier: "QuizVC") as! QuizVC
            self.navigationController?.pushViewController(vc, animated: true)
    
        default:
            print("Error")
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 45)/2)
        let height = width / 1.5
        return CGSize(width: width, height: height)
    }
    
}




