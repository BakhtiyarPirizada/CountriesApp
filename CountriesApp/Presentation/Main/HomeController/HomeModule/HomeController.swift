//
//  HomeController .swift
//  CountryApp
//
//  Created by Bakhtiyar Pirizada on 07.12.24.
//


import UIKit

class HomeController: CoreViewController {
    
    private let viewModule: HomeViewModel
    
    init(viewModule: HomeViewModel) {
        self.viewModule = viewModule
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var countryTable: UITableView = {
        let t = UITableView()
        t.refreshControl = refreshController
        t.backgroundColor = .clear
        t.register(cell: CountryCell.self)
        t.delegate = self
        t.dataSource = self
        t.rowHeight = 48
        return t
    }()
    
    private lazy var searchField = ReusableText(title: "Search")
    
    private lazy var sortLabel = ReusableLabel(title: "Sort based on your preference ", size: 16)
    
    private lazy var sortButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        b.tintColor = .tabBar
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return b
    }()
    
    private lazy var refreshButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        b.tintColor = .tabBar
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(reloadPage), for: .touchUpInside)
        return b
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .large)
        v.tintColor = .red
        return v
    }()
    private lazy var refreshController: UIRefreshControl = {
        let r = UIRefreshControl()
        r.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        return r
    }()
     
//MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModule()
        viewModule.countryListRequest()
    }
//MARK: Fileprivate Functions
    override func configureUI(){
        super.configureUI()
        view.addViews(view: [countryTable,searchField,loadingView,sortButton,refreshButton,sortLabel])
        configureLabel()
        searchField.delegate = self
        searchField.layer.borderWidth = 0
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        loadingView.fillSuperview()
        searchField.anchorSize(.init(width: 0, height: 40))
        sortButton.anchorSize(.init(width: 24, height: 24))
        countryTable.anchor(
            top: sortButton.bottomAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            padding: .init(top: 6, left: 20, bottom: 0, right: -20)
        )
       
        searchField.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: -20)
        )
     
        sortButton.anchor(
            top: searchField.bottomAnchor,
            bottom: countryTable.topAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            padding: .init(top: 6, left: 0, bottom: -6, right: -20)
        )
        refreshButton.centerToYView(to: sortButton)
        sortLabel.centerToYView(to: refreshButton)
        
        refreshButton.anchor(
            leading: sortLabel.trailingAnchor,
            trailing: sortButton.leadingAnchor,
            padding: .init(top: 0, left: 12, bottom: 0, right: -12)
        )
        sortLabel.anchor(
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            trailing: refreshButton.leadingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: -12)
        )
        
    }
    fileprivate func configureLabel() {
        sortLabel.backgroundColor = .tabBar
        sortLabel.textColor = .BG
        sortLabel.layer.cornerRadius = 4
        sortLabel.layer.masksToBounds = true
        sortLabel.setLeftPaddingForLabel(padding: 1)
    }
    fileprivate func configureViewModule () {
        viewModule.listener = { [weak self] state in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch state {
                    case .loading:
                        self.loadingView.startAnimating()
                    case .loaded:
                        self.loadingView.stopAnimating()
                    self.refreshController.endRefreshing()
                    case .success:
                    self.countryTable.reloadData()
                    case .error(let message):
                        self.showMessage(title: "Error", message: message)
                }
            }
        }
    }
//MARK: @OBJC Functions
    
    @objc private func buttonClicked() {
        let controller = SortController()
        controller.modalPresentationStyle = .pageSheet
        if let sheet = controller.sheetPresentationController {
        sheet.detents = [.medium(),.large()]
        sheet.prefersGrabberVisible = true }
        present(controller, animated: true)
        
        controller.callback = {[weak self] sortType in
            guard let _ = self else {return}
            switch sortType {
            case .AZ:
                self?.viewModule.sortAZ()
            case .ZA:
                self?.viewModule.sortZA()
            case .GL:
                self?.viewModule.sortGL()
            case .LG:
                self?.viewModule.sortLG()
            }
        }
    }
    @objc
    private func reloadPage() {
        viewModule.countryListRequest()
    }
}

//MARK: UITableViewDelegate,UITableViewDataSource

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModule.getItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModule.getList(index: indexPath.row) else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(for: CountryCell.self, for: indexPath)
        cell.configureCell(model: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MapController()
//        controller.modalPresentationStyle = .pageSheet
//        if let sheet = controller.sheetPresentationController {
//        sheet.detents = [.medium(),.large()]
//        sheet.prefersGrabberVisible = true }
//        present(controller, animated: true)
        navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: UITextFieldDelegate

extension HomeController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        viewModule.searcText(text: text)
 
    }
}
