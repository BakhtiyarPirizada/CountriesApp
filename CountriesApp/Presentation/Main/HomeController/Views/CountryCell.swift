//
//  CountryCell.swift
//  CountryApp
//
//  Created by Bakhtiyar Pirizada on 18.11.24.
//
//
import UIKit

final class CountryCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel = ReusableLabel(title: "Country", size: 16)
    
    private lazy var subtitleLabel = ReusableLabel(title: "Capital", size: 14)
    
    private lazy var flagImage = ReusableImage(img:  .actions)
    
    private lazy var view: UIView = {
        let v = UIView()
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.layer.cornerRadius = 8
        v.backgroundColor = .tabBar
        return v
    }()
    
    private lazy var titleStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        s.axis = .vertical
        s.spacing = 4
        s.alignment = .fill
        s.distribution = .fill
        return s
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [flagImage, titleStackView])
        s.axis = .horizontal
        s.spacing = 12
        s.alignment = .center
        s.distribution = .fill
        return s
    }()
   
    func configureConstraints() {
        view.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 2, left: 0, bottom: -2, right: 0)
        )
        flagImage.anchorSize(.init(width: 40, height: 40))
        flagImage.layer.cornerRadius = 20
        stackView.fillSuperview()
        

    }
    fileprivate func configureUI() {
        backgroundColor = .clear
        view.addSubview(stackView)
        addSubview(view)
    }
    
    func configureCell(model:TitleSubtitleProtocol) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtite
        flagImage.loadImageURL(url: model.iconURL)
    }
}
