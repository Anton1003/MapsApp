//
//  ViewController.swift
//  MapsAPP
//
//  Created by User on 26.04.2021.
//

import CoreLocation
import GoogleMaps
import RealmSwift
import RxSwift
import UIKit

final class MapViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView!

    private var locationManager = LocationManager.instance
    private let disposeBag = DisposeBag()

    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?

    private var isTraking = false

    private let realm = try? Realm()

    private let mainRouter = MainRouter()
    
    var onTakePicture: ((UIImage) -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        mainRouter.controller = self
    }

    private func configureLocationManager() {
        locationManager
            .location
            .asObservable()
            .subscribe(onNext: { [weak self] location in
                guard let location = location else { return }
                self?.routePath?.add(location.coordinate)
                self?.route?.path = self?.routePath
                let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
                self?.mapView.animate(to: position)
            })
    }

    private func endTraking() {
        locationManager.stopLocation()
        isTraking = false
        saveTraking()
    }

    private func saveTraking() {
        guard let routePath = routePath else { return }
        let pointCount = routePath.count()
        let trackToSave = List<Location>()
        for index in 0 ..< pointCount {
            let coorPoint = routePath.coordinate(at: index)
            let point = Location()
            point.latitude = coorPoint.latitude
            point.longtitude = coorPoint.longitude
            trackToSave.append(point)
        }
        do {
            realm?.beginWrite()
            realm?.deleteAll()
            realm?.add(trackToSave)
            try realm?.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadSaveTrack() {
        let saveTrack = realm?.objects(Location.self)
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        guard let savetrack = saveTrack else { return }
        for point in savetrack {
            let location = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longtitude)
            routePath?.add(location)
        }
        route?.path = routePath
        guard let firstCoord = routePath?.coordinate(at: 0),
              let lastCoord = routePath?.coordinate(at: (routePath?.count() ?? 1) - 1)
        else { return }
        let bounds = GMSCoordinateBounds(coordinate: firstCoord, coordinate: lastCoord)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 40.0)
        mapView.moveCamera(update)
    }

    @IBAction func showCamera(_ sender: Any) {
        showImageController()
    }
    @IBAction func exitButton(_ sender: Any) {
        mainRouter.toLaunch()
        UserDefaults.standard.set(false, forKey: "isLogin")
    }

    @IBAction func startTrack(_ sender: Any) {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        locationManager.startLocation()
        isTraking = true
    }

    @IBAction func cancelTrack(_ sender: Any) {
        endTraking()
    }

    @IBAction func getLastTrack(_ sender: Any) {
        guard !isTraking else {
            let alertController = UIAlertController(
                title: "Внимание!",
                message: "Остановите отслеживание перед получением маршрута",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.endTraking()
                self?.getLastTrack(sender)
            }
            let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            return
        }

        loadSaveTrack()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        routePath?.add(location.coordinate)
        route?.path = routePath

        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        mapView.animate(to: position)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func showImageController() {
        let alertController = UIAlertController(title: "Выбор изображения", message: nil, preferredStyle: .alert)
        let photoAction = UIAlertAction(title: "Выбрать из галерей", style: .default) { [weak self] _ in
            self?.takePicture(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Сделать снимок", style: .default) { [weak self] _ in
            self?.takePicture(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)

    }
    
    func takePicture(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        picker.dismiss(animated: true) { [weak self] in
            guard let image = self?.extractImage(from: info) else {return}
            self?.onTakePicture?(image)
        }
    }

    private func extractImage(from info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            return image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            return image
        } else {
            return nil
        }
    }
}
