//
//  CountryCell.swift
//  CountryApp
//
//  Created by Bakhtiyar Pirizada on 18.11.24.
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
        flagImage.anchorSize(.init(width: 40, height: 40))
        flagImage.layer.cornerRadius = 20
        stackView.fillSuperview(padding: .init(top: 12, left: 0, bottom: -12, right: 0))
        addSubview(stackView)

    }
    fileprivate func configureUI() {

    }
    func configureCell(model:TitleSubtitleProtocol) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtite
        flagImage.loadImageURL(url: model.iconURL)
    }
}
