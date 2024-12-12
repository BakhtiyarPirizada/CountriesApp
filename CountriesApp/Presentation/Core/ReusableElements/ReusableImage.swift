//
//  ReusableImage.swift
//  CountryApp
//
//  Created by Bakhtiyar Pirizada on 09.12.24.
//

import UIKit
final class ReusableImage:UIImageView {
    private var img: UIImage
    init(img: UIImage) {
        self.img = img
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        image = img
        backgroundColor = .clear
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
}
