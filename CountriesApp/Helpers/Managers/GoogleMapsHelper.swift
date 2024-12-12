////
////  GoogleMapsHelper.swift
////  CountryApp
////
////  Created by Bakhtiyar Pirizada on 10.12.24.
////
//import GoogleMaps
//
//final class GoogleMapsHelper {
//    private init () {}
//    static let instance = GoogleMapsHelper()
//
//
//    // Google Maps üçün GMSServices konfiqurasiyasını təmin edir
//    static func configureGoogleMapsAPI() {
//        GMSServices.provideAPIKey("AIzaSyCWZfNkW2XxAHt7xcX9aOqRv-fPYpj_290")
//    }
//
//    // Xəritə yaratmaq
////    static func createMapView(frame: CGRect, latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Float) -> GMSMapView {
////        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
////        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
////        return mapView
////    }
//
//    // Marker əlavə etmək
//    static func addMarker(to mapView: GMSMapView, latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String, snippet: String) {
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        marker.title = title
//        marker.snippet = snippet
//        marker.map = mapView
//    }
//}
//
