//
//  MapController.swift
//  CountriesApp
//
//  Created by Bakhtiyar Pirizada on 12.12.24.
//

import UIKit
import MapKit

class MapController: UIViewController {

    private lazy var mapView: MKMapView = {
        let m = MKMapView()
        m.overrideUserInterfaceStyle = .light
        m.delegate = self
        return m
    }()
    private lazy var loadingView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .large)
        v.tintColor = .red
        return v
    }()
    private var coordinator: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    fileprivate func configureUI() {
        view.addViews(view: [loadingView,mapView])
        configureConstraints()

    }
    fileprivate func configureConstraints() {
        loadingView.fillSuperview()
        mapView.fillSuperview()
    }

}
extension MapController: MKMapViewDelegate {
    
}
