//: A UIKit based Playground for presenting user interface
// Rodolfo Galarza Jr.
// 04/13/2019

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    
    let countingLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let helloWorldLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var startValue:Double  = 0
    let endValue:Double    = 2019
    let animationStartDate  = Date()
    let animationDuration   = 1.5
    var displayLink: CADisplayLink?
    
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        NumberAnimation()
        setupCountingLabelConstraints()
        StringAnimation()
        setupHelloWorldLabelContraints()
    }
    
    func setupCountingLabelConstraints(){
        countingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupHelloWorldLabelContraints(){
        helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorldLabel.topAnchor.constraint(equalTo: countingLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func NumberAnimation(){
        view.addSubview(countingLabel)
        countingLabel.frame = view.frame
        // create a CADisplayLink
        let displayLink = CADisplayLink(target: self, selector: #selector(handleCountingUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    @objc func handleCountingUpdate(){
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration  {
            self.countingLabel.text = "\(Int(endValue))"
        }else {
            let percentage = elapsedTime / animationDuration
            let value = percentage * (endValue - startValue)
            self.countingLabel.text = "\(Int(value))"
        }
    }
    
    func StringAnimation(){
        view.addSubview(helloWorldLabel)
        displayLink = CADisplayLink(target: self, selector: #selector(handleStringUpdate))
        displayLink!.add(to: .main, forMode: .default)
    }
    
    @objc func handleStringUpdate(){
        let now = Date()
        let animationDuration   = 2.0
        let endStringValue:String = "Hello World!"
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        if elapsedTime > animationDuration  {
            self.helloWorldLabel.text = "Hello World!"
            displayLink?.invalidate()
        }else {
            let percentage = elapsedTime / animationDuration
            let stringOffset = Int(percentage * Double(endStringValue.count))
            let endStringIndex = endStringValue.index(endStringValue.startIndex, offsetBy: stringOffset)
            let stringRange = endStringValue.startIndex..<endStringIndex
            let labelString = String(endStringValue[stringRange])
            self.helloWorldLabel.text = labelString
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
