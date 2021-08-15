//
//  SplashScreenView.swift
//  3205team
//
//  Created by Алексей Муренцев on 15.08.2021.
//

import UIKit

final class SplashScreenView: UIView {
    
    private var timer: Timer?
    private var counter: Int = 1
    
    public var endAnimation: (()->())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Repositories"
        label.font = UIFont.systemFont(ofSize: 34)
        label.alpha = 0
        return label
    }()
    
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .black
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.titleLabel.alpha = 1.0
        }
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.85, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        self.counter += 1
        if counter == 6 {
            self.timer?.invalidate()
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0.0
            } completion: { _ in
                self.endAnimation?()
            }
        }
    }
    
    private func setConstraints() {
            addSubview(titleLabel)
            
            //-- Title label
            NSLayoutConstraint.activate([
                titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
                titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    
}
