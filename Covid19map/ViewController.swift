//
//  ViewController.swift
//  Covid19map
//
//  Created by Szépfalusi István on 2020. 12. 06..
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    public var countryStats: [CountryStat] = []
   
    
    @IBOutlet private var mapView: MKMapView!
    let pull = PullWithAPI()
    let notations = CountriesAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 55.430306, longitude: 10.745164)

        mapView.centerToLocation(initialLocation)
        mapView.delegate = self
        mapView.addAnnotations(notations.countriesNotations())
        countryStats = pull.pullwithAPIandAdd()
        
        
        // Do any additional setup after loading the view.
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue" )
        {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.country = (sender as! MKAnnotationView).annotation?.title! ?? "Not Found"
            destinationVC.stats = countryStats
        }
        if (segue.identifier == "worldSegue" )
        {
            let destinationVC = segue.destination as! WorldViewController
            destinationVC.stats = countryStats
        }
    }



}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 2500000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension ViewController: MKMapViewDelegate{

    func mapView(
      _ mapView: MKMapView,
      viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        guard let annotation = annotation as? CountryMap else {
            return nil
        }
        let id = ""
        var view: MKMarkerAnnotationView
        
        if let deqView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView{
            deqView.annotation = annotation
            view = deqView
        }else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type:.detailDisclosure)
            let image = UIImage(named: "corona")
            view.glyphImage = image
            view.markerTintColor = UIColor.white
            if let obj = countryStats.first(where: {$0.name == annotation.title}){
                if obj.totalconfirmed!>1000000 {
                    view.markerTintColor = UIColor(red: 0.75, green: 0.00, blue: 0.00, alpha: 1.00)
                }
                if obj.totalconfirmed!>500000 && obj.totalconfirmed!<1000000 {
                    view.markerTintColor = UIColor(red: 0.75, green: 0.00, blue: 0.00, alpha: 0.80)
                }
                if obj.totalconfirmed!>250000 && obj.totalconfirmed!<500000 {
                    view.markerTintColor = UIColor(red: 0.75, green: 0.00, blue: 0.00, alpha: 0.60)
                }
                if obj.totalconfirmed!>100000 && obj.totalconfirmed!<250000 {
                    view.markerTintColor = UIColor(red: 0.75, green: 0.00, blue: 0.00, alpha: 0.50)
                }
                if obj.totalconfirmed!<100000 {
                    view.markerTintColor = UIColor(red: 0.75, green: 0.00, blue: 0.00, alpha: 0.30)
                }
                if obj.totalconfirmed!==0 && obj.totalrecovered!==0 && obj.totaldeaths==0 {
                    return nil
                }
            }
        }
            return view
    }
    func mapView(
      _ mapView: MKMapView,
      annotationView view: MKAnnotationView,
      calloutAccessoryControlTapped control: UIControl
    ) {
      guard let country = view.annotation as? CountryMap else {
        return
      }
        
        
        let destinationVC = DetailViewController()
        destinationVC.country = country.title!
        

        performSegue(withIdentifier: "detailSegue", sender: view)
    
    }
    

    
}



