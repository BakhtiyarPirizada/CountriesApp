//
//  HomeController .swift
//  CountryApp
//
//  Created by Bakhtiyar Pirizada on 07.12.24.
//


import UIKit

class HomeController: UIViewController {
    
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
        t.backgroundColor = .clear
        t.register(cell: CountryCell.self)
        t.delegate = self
        t.dataSource = self
        t.rowHeight = 48
        return t
    }()
    
    private lazy var searchField = ReusableText(title: "Search")
    
    
    private lazy var submitButton = ReusableButton(title: "Submit", action: buttonClicked)
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .large)
        v.tintColor = .red
        return v
    }()
     
//MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModule()
        viewModule.countryListRequest()
    }
//MARK: Fileprivate Functions
    fileprivate func configureUI(){
        view.addViews(view: [countryTable,searchField,loadingView,submitButton])
        configureConstraints()
        searchField.delegate = self
    }
    
    fileprivate func configureConstraints() {
        searchField.anchorSize(.init(width: 0, height: 48))
        submitButton.anchorSize(.init(width: 0, height: 48))
        countryTable.anchor(
            top: searchField.bottomAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor,
            padding: .init(top: 12, left: 24, bottom: 0, right: -24)
        )
        loadingView.fillSuperview()
        searchField.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: -20)
        )
     
        submitButton.anchor(
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,padding: .init(all: 30))
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
                    case .success:
                    self.countryTable.reloadData()
                    case .error(let message):
                        self.showMessage(title: "Error", message: message)
                }
            }
        }
    }
//MARK: @OBJC Functions
    
    @objc private func buttonClicked() {}
  
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
  
}
//MARK: UITextFieldDelegate

extension HomeController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        viewModule.sortAtoZ(text: text)
 
    }
}
