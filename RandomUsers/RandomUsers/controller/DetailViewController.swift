//
//  DetailViewController.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import UIKit
import MessageUI
import MarqueeLabel

class DetailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func showLocation(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let mapViewController = storyboard.instantiateViewController(withIdentifier: mapViewControllerStoryboardID) as? MapViewController {
            mapViewController.latitude = Double(user.location.coordinates.latitude)
            mapViewController.longitude = Double(user.location.coordinates.longitude)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
    
    @IBAction func emialBarButtonItem(_ sender: UIBarButtonItem) {
        initEmail()
    }
    
    @IBAction func callBarButtonItem(_ sender: UIBarButtonItem) {
        initCall(user.phone)
    }
    
    var user: User!
    var imageView: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUserData()
        initTableView()
    }
   
    private func initUserData() {
        setImage()
    }
    
    private func setImage() {
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.image = imageView
    }
    
    private func initCall(_ number: String)  {
        guard let url: URL = URL(string: "TEL://\(number)") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    private func initEmail() {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Title"
            let messageBody = "message"
            let toRecipents = [user.email!]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            self.present(mc, animated: true, completion: nil)
        } else {
            initToastView(message: "Mail services are not available")
            return
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func initToastView(message: String) {
        let x = self.view.frame.size.width / 16
        let y = self.view.frame.size.height - 150
        let width = self.view.frame.size.width * 7 / 8
        let height = CGFloat(35)
        let toastLabel = UITextView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = "\(message)"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.font = UIFont(name: (toastLabel.font?.fontName)!, size: 16)
        toastLabel.center.x = self.view.frame.size.width / 2
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    private func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as? DetailCell else {
            return DetailCell()
        }
        
        cell.gender.text = "gender:     \(user.gender!)     "
        cell.title.text = "title name:      \(user.name.title!)     "
        cell.first.text = "first name:      \(user.name.first!)     "
        cell.last.text = "last name:        \(user.name.last!)      "
        cell.email.text = "email:       \(user.email!)      "
        cell.phone.text = "phone:       \(user.phone!)      "
        cell.call.text = "cell:     \(user.cell!)       "
        cell.street.text = "street:     \(user.location.street!)        "
        cell.city.text = "city:     \(user.location.city!)      "
        cell.state.text = "state:       \(user.location.state!)     "
        cell.latitude.text = "latitude:     \(user.location.coordinates.latitude!)      "
        cell.longitude.text = "longitude:       \(user.location.coordinates.longitude!)     "
        cell.timezoneOffset.text = "timezone offset:        \(user.location.timezone.offset!)       "
        cell.timezoneDescription.text = "timezone description:      \(user.location.timezone.description!)      "
        cell.uuid.text = "uuid:     \(user.login.uuid!)     "
        cell.username.text = "username:     \(user.login.username!)     "
        cell.password.text = "password:     \(user.login.password!)     "
        cell.salt.text = "salt:     \(user.login.salt!)     "
        cell.md5.text = "md5:       \(user.login.md5!)      "
        cell.sha1.text = "sha1:     \(user.login.sha1!)     "
        cell.sha256.text = "sha256:     \(user.login.sha256!)       "
        cell.registeredDate.text = "registered date:        \(user.registered.date!)        "
        cell.registeredAge.text = "registered age:      \(user.registered.age!)     "
        cell.dobDate.text = "dob date:      \(user.dob.date!)       "
        cell.dobAge.text = "dob age:        \(user.dob.age!)        "

        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 21 * 25 + 25
    }
}
