//
//  MemeCollectionController.swift
//  MemeMe
//
//  Created by Justin Priday on 2017/09/25.
//  Copyright © 2017 Justin Priday. All rights reserved.
//

import UIKit

class MemeCollectionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let reuseIdentifier = "MemeItemCollectionCell"

    var memes: [MemeImage] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var memeCollection: UICollectionView!
    
    //MARK: IBActions
    
    @IBAction func createExit(segue: UIStoryboardSegue) {
        //Create Meme Exit Segue Action for reloading list data
        memeCollection.reloadData()
        print("Exit to Collection")
    }

    
    //MARK: UIViewController Delegates

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeCollection.reloadData()
    }
    
    //MARK: UICollectionView all Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeItemCollectionCell

        cell.memeImage.image = memes[indexPath.row].getMemedImage()

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateMemeController") as! CreateMemeController
        controller.memeItem = memes[indexPath.row]
        self.present(controller, animated: true, completion: nil)
    }
}
