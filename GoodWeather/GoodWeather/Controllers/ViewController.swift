//
//  ViewController.swift
//  GoodWeather
//
//  Created by Kas Song on 1/11/21.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLbel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    final private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            temperatureLbel.text = "\(weather.temp) ₣"
            humidityLabel.text = "\(weather.humidity) 💧"
        } else {
            temperatureLbel.text = "💩"
            humidityLabel.text = "🍺"
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        let resource = Resource<WeatherResult>(url: url)
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.empty)
            .subscribe(onNext: { result in
                let weather = result.main
                self.displayWeather(weather)
            }).disposed(by: disposeBag)
    }
}
