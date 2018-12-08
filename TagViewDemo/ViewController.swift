//
//  ViewController.swift
//  TagViewDemo
//
//  Created by Kondya on 08/12/18.
//  Copyright © 2018 Kondya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var tagCollection: UICollectionView!
    

    var tagArray : [String] = []
    @IBOutlet weak var inputeTag: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagCollection.delegate = self
        self.tagCollection.dataSource = self
       

        self.inputeTag.delegate = self
        
        
        self.tagArray.append("#Sachin")
        self.tagArray.append("#Mumbai")
        self.tagArray.append("#Kondiram")
        self.tagCollection.reloadData()
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.inputeTag{
            
            if !((self.inputeTag.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){
                
               textField.resignFirstResponder()
                self.tagArray.append("#"+self.inputeTag.text!)
                self.tagCollection.reloadData()
                
            }
            
            
            
            return true
        }
        
        
        return true
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let tagCollectionCell = self.tagCollection.dequeueReusableCell(withReuseIdentifier: "TagCollectionCell", for: indexPath) as? TagCollectionCell{
            
            tagCollectionCell.backView.layer.cornerRadius = tagCollectionCell.backView.frame.height  / 2
            tagCollectionCell.tagLbl.text = self.tagArray[indexPath.item]
            tagCollectionCell.removeBtn.tag = indexPath.row
            tagCollectionCell.removeBtn.addTarget(self, action: #selector(sayAction(_:)), for: .touchUpInside)
            
            return tagCollectionCell
        }
        
        return UICollectionViewCell()
        
    }
    @objc private func sayAction(_ sender: UIButton?) {
        
        let index = sender?.tag
        self.tagArray.remove(at: index!)
        self.tagCollection.reloadData()
        
        
    }

 

}

extension String{
    
    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat? {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.tagArray[indexPath.item].widthWithConstrainedHeight(self.tagCollection.frame.height, font: UIFont.boldSystemFont(ofSize: 16.5))+50, height: collectionView.frame.height)
    }
}
class TagCollectionCell: UICollectionViewCell {
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    
}
