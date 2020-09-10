//
//  ViewController.swift
//  AdvanceTableViewDemo
//
//  Created by Sailendra on 7/28/20.
//  Copyright © 2020 SailendraMac. All rights reserved.
//

import UIKit

extension ViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ inter: UIContextMenuInteraction,
        configurationForMenuAtLocation loc: CGPoint) -> UIContextMenuConfiguration? {
        let vc = PreviewController()
        if let indexPath = tableView.indexPathForRow(at: loc) {
            let section = sections[indexPath.section]
            let sectionData = section.data[indexPath.row]
            vc.cellData = sectionData
        }
                
        let config = UIContextMenuConfiguration(identifier: "PreviewController" as NSString,
            previewProvider: { vc }, actionProvider: nil)
        return config
    }
        
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        if let vc = animator.previewViewController {
                        animator.addCompletion {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

class ViewController: UITableViewController {
    
    fileprivate let CELL_ID = "cell_id"
    
    fileprivate var sections: [SectionData] = [
        SectionData(
            open: false,
            data: [
                   CellData(title: "IOS", desc: "An iOS developer is responsible for developing applications for mobile devices powered by Apple's iOS operating system. Ideally, a good iOS developer is proficient with one of the two programming languages for this platform: Objective-C or Swift.", featureImage: UIImage(named: "4")!),
                   CellData(title: "Android", desc: "Android software development is the process by which applications are created for devices running the Android operating system.", featureImage: UIImage(named: "0")!),
                   CellData(title: "Kotlin", desc: "Kotlin is a general purpose, free, open source, statically typed “pragmatic” programming language initially designed for the JVM (Java Virtual Machine) and Android that combines object-oriented and functional programming features.", featureImage: UIImage(named: "2")!)
        ]),
        SectionData(
            open: false,
            data: [
                   CellData(title: "Cordova", desc: "Cordova is a platform that is used for building mobile apps using HTML, CSS and JS. It offers a bridge for connection between web app and mobile device.", featureImage: UIImage(named: "3")!),
                   CellData(title: "Xamarin", desc: "Xamarin is an open-source platform for building modern and performant applications for iOS, Android, and Windows.", featureImage: UIImage(named: "1")!),
                   CellData(title: "Flutter", desc: "Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia and the web from a single codebase.", featureImage: UIImage(named: "5")!),
                   CellData(title: "React Native", desc: "React Native is an open-source mobile application framework created by Facebook, Inc. It is used to develop applications for Android, iOS, Web and UWP by enabling developers to use React along with native platform capabilities.", featureImage: UIImage(named: "6")!)
        ]),
        SectionData(
            open: true,
            data: [
                   CellData(title: ".Net", desc: "NET is a software development framework and ecosystem designed and supported by Microsoft to allow for easy desktop and web application engineering.", featureImage: UIImage(named: "7")!),
                   CellData(title: "Java", desc: "Java is a general-purpose programming language that is class-based, object-oriented, and designed to have as few implementation dependencies as possible.", featureImage: UIImage(named: "8")!)
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.init(red: 228/255, green: 230/255, blue: 234/255, alpha: 1.0)
        navigationItem.title = "Advance TableView"
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            let inter = UIContextMenuInteraction(delegate: self)
            view.addInteraction(inter)
        }
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(ExpandTableCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
//        tableView.estimatedRowHeight = 240
//        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc fileprivate func openSection(button: UIButton) {
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in sections[section].data.indices {
            let indexPathTodelete = IndexPath(row: row, section: section)
            indexPaths.append(indexPathTodelete)
        }
        
        let isOpen = sections[section].open
        sections[section].open = !isOpen
        
        button.setTitle(isOpen ? "Expand" : "Colapse", for: .normal)
        
        if isOpen {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
}


extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].open {
            return 0
        }
        return sections[section].data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! ExpandTableCell
        let section = sections[indexPath.section]
        let sectionData = section.data[indexPath.row]
        cell.cellData = sectionData
        cell.animate()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let isOpen = sections[section].open
        let button = UIButton()
        button.tag = section
        button.setTitle(isOpen ? "Colapse" : "Expand", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return button
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
