//
//  SortController.swift
//  CountriesApp
//
//  Created by Bakhtiyar Pirizada on 12.12.24.
//

import UIKit


class SortController: UIViewController {

    enum SortType {
        case AZ
        case ZA
        case GL
        case LG
    }
    var callback:((SortType)->Void)?
    private lazy var sortAlphabetAZ = ReusableLabel(title: "Sort countries A to Z", size: 16)
    private lazy var sortAreaGL = ReusableLabel(title: "Sort countries Great to Little", size: 16)
    private lazy var sortAlphabetZA = ReusableLabel(title: "Sort countries Z to A", size: 16)
    private lazy var sortAreaLG = ReusableLabel(title: "Sort countries Little to Great", size: 16)
    private lazy var sortArray = [sortAlphabetAZ,sortAlphabetZA,sortAreaGL,sortAreaLG]
   
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [sortAlphabetAZ, sortAlphabetZA,sortAreaGL,sortAreaLG])
        s.axis = .vertical
        s.spacing = 12
        s.distribution = .fill
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        gestureRecognizer()
    }
    
    fileprivate func configureUI() {
        view.backgroundColor = .tabBar
        view.addSubview(stackView)
        configureLabel()
        configureConstraints()
    }
    fileprivate func configureConstraints() {
        stackView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 24, left: 20, bottom: 0, right: -20)
        )
    }
    fileprivate func configureLabel() {
        sortArray.forEach{$0.backgroundColor = .BG}
        sortArray.forEach{$0.anchorSize(.init(width: 0, height: 48))}
        sortArray.forEach{$0.layer.cornerRadius = 12}
        sortArray.forEach{$0.layer.masksToBounds = true}
        sortArray.forEach{$0.setLeftPaddingForLabel(padding: 2)}
        sortArray.forEach{$0.textColor = .tabBar}
    }
    fileprivate func gestureRecognizer() {
        gestureRecognizer(to: sortAlphabetAZ, action: #selector(sortAZ))
        gestureRecognizer(to: sortAlphabetZA, action: #selector(sortZA))
        gestureRecognizer(to: sortAreaGL, action: #selector(sortGL))
        gestureRecognizer(to: sortAreaLG, action: #selector(sortLG))
    }
    @objc fileprivate func sortAZ () {
        callback?(.AZ)
        dismiss(animated: true)
    }
    @objc fileprivate func sortZA () {
        callback?(.ZA)
        dismiss(animated: true)
    }
    @objc fileprivate func sortGL () {
        callback?(.GL)
        dismiss(animated: true)
    }
    @objc fileprivate func sortLG () {
        callback?(.LG)
        dismiss(animated: true)
    }
}

//extension SortController:UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}

//    private lazy var sortTable: UITableView = {
//        let t = UITableView()
//        t.backgroundColor = .clear
//        t.register(cell: CountryCell.self)
//        t.delegate = self
//        t.dataSource = self
//        t.rowHeight = 48
//        return t
//    }()
