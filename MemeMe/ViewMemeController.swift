//
//  ViewMemeController.swift
//  MemeMe
//
//  Created by Justin Priday on 2017/09/25.
//  Copyright © 2017 Justin Priday. All rights reserved.
//

import UIKit

class ViewMemeController: UIViewController {
    
    public var memeItem: MemeImage!
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeImageAspectConstraint: NSLayoutConstraint!
    
    //MARK: UIViewController Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImage.image = memeItem.getMemedImage()
        
        var aspect:CGFloat = 1.0
        if let imageSize = memeImage.image?.size {
            aspect = (imageSize.width) / (imageSize.height)
        }
        memeImageAspectConstraint = memeImageAspectConstraint.setMultiplier(multiplier: aspect)
        
        memeImage.setNeedsUpdateConstraints()
        memeImage.layoutIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! CreateMemeController
        dest.memeItem = self.memeItem
    }
}
