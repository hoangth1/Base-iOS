//
//  UIViewControllerExtension.swift
//  BaseiOS
//
//  Created by M1 on 4/29/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
    
    // Show message
    private func showMessage(title:String, message:String, handler: ((_ action:UIAlertAction)->Void)? = nil){
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    
    // Method to prensent specific screen
    private func goToScreen(viewController:UIViewController, modalPresentationStyle:UIModalPresentationStyle = .fullScreen, modalTransitionStyle: UIModalTransitionStyle = .coverVertical,onShowComplete: (()->Void)? = nil){
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        present(viewController, animated: true, completion: onShowComplete)
    }
    
    // Method to blur ViewController
    private func overlayBlurredBackgroundView() {

        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        view.addSubview(blurredBackgroundView)
    }

    //Method to remove blur ViewController
    func removeBlurredBackgroundView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    func hideKeyboardWhenTappedArroudn() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
