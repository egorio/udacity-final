//
//  UIViewController.swift
//  VideoRotator
//
//  Created by Egorio on 4/4/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

extension UIViewController {

    /*
     * Calls function to update UI in main thread
     */
    func runInMainQueue(block: () -> Void) {
        dispatch_async(dispatch_get_main_queue(), block);
    }

    /*
     * Shows alert with one button to dismiss the alert
     */
    func showErrorAlert(title: String, message: String, dismissButtonTitle: String = "OK") {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        controller.addAction(UIAlertAction(title: dismissButtonTitle, style: .Default) { (action: UIAlertAction!) in
            controller.dismissViewControllerAnimated(true, completion: nil)
        })

        presentViewController(controller, animated: true, completion: nil)
    }

    /*
     * Shows alert with two buttons - one to dismiss the alert, second for special action
     */
    func showConfirmationAlert(title: String, message: String, dismissButtonTitle: String = "Cancel", actionButtonTitle: String = "OK", handler: ((UIAlertAction!) -> Void)) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        controller.addAction(UIAlertAction(title: dismissButtonTitle, style: .Default) { (action: UIAlertAction!) in
            controller.dismissViewControllerAnimated(true, completion: nil)
        })

        controller.addAction(UIAlertAction(title: actionButtonTitle, style: .Default, handler: handler))

        presentViewController(controller, animated: true, completion: nil)
    }
}
