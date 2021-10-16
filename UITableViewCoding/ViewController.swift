//
//  ViewController.swift
//  UITableViewCoding
//
//  Created by Aleksandr Rybachev on 14.10.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private let listForFirstSection = ["Авиарежим", "Wi-Fi", "Bluetooth",
                                       "Сотовая связь", "Режим модема", "VPN"]
    private let imagesForFirstSection = ["airplane.circle.fill", "wifi.square.fill", "b.square.fill",
                                         "antenna.radiowaves.left.and.right", "personalhotspot.circle.fill", "app.connected.to.app.below.fill"]
    
    private let listForSecondSection = ["Уведомления", "Звуки, тактилтные сигналы", "Не беспокоить", "Экранное время"]
    private let imagesForSecondSection = ["app.badge", "speaker.wave.3.fill", "moon.fill", "hourglass.circle.fill"]
    
    private let listForThirdSection = ["Основные", "Пункт управления", "Экран и яркость",
                                       "Экран Домой", "Универсальный доступ", "Обои",
                                       "Siri и Поиск", "Face ID и код-пароль", "Экстренный вызов - SOS",
                                       "Уведомление о контакте", "Аккумулятор", "Конфиденциальность"]
    private let imagesForThirdSection = ["gear.circle.fill", "switch.2", "textformat.size",
                                         "apps.iphone", "figure.wave.circle", "wallet.pass",
                                         "magnifyingglass.circle.fill", "faceid", "questionmark.circle",
                                         "sun.min.fill", "battery.100", "hand.raised.fill"]
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        hierarchy()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        updateLayout(with: view.frame.size)
        
    }
    
    private func hierarchy() {
        view.addSubview(tableView)
    }
    
    private func updateLayout(with size: CGSize) {
        tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return listForFirstSection.count
        case 1:
            return listForSecondSection.count
        default:
            return listForThirdSection.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        var content = cell.defaultContentConfiguration()
        
        
        
        switch indexPath.section {
        case 0:
            content.text = listForFirstSection[indexPath.row]
            content.image = UIImage(systemName: imagesForFirstSection[indexPath.row])
            
            if indexPath.row == 0 || indexPath.row == 5 {
                let switchView = UISwitch()
                switchView.setOn(false, animated: true)
                switchView.tag = indexPath.row // для определения того, какой переключатель строк изменился
                switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
                cell.accessoryView = switchView
            } else if indexPath.row == 1 {
                content.secondaryText = "Не подключено"
            } else if indexPath.row == 2 {
                content.secondaryText = "Вкл."
            }
            
        case 1:
            content.text = listForSecondSection[indexPath.row]
            content.image = UIImage(systemName: imagesForSecondSection[indexPath.row])
            
        default:
            content.text = listForThirdSection[indexPath.row]
            content.image = UIImage(systemName: imagesForThirdSection[indexPath.row])
        }
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        return cell
        
    }
    
    @objc private func switchChanged(_ sender : UISwitch!) {
        print("Переключатель \"\(listForFirstSection[sender.tag])\" в положение \(sender.isOn ? "ON" : "OFF")")
    }
    
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("Выбрана ячейка \"\(listForFirstSection[indexPath.row])\"")
        case 1:
            print("Выбрана ячейка \"\(listForSecondSection[indexPath.row])\"")
        default:
            print("Выбрана ячейка \"\(listForThirdSection[indexPath.row])\"")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
