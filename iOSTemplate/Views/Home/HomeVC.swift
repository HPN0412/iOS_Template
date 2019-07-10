//
//  HomeVC.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/7/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import UIKit

final class HomeVC: UIViewController {

    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var exampleXibloclabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        exampleLabel.text = R.string.localizable.example()
//        print((Bundle.main.infoDictionary?["API End Point"] as? String)?.replacingOccurrences(of: "\\", with: ""))
    }
}
