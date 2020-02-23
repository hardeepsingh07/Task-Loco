//
//  SceneDelegate.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 2/23/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import UIKit
import os

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		os_log("Scene Created")
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        os_log("Scene Discarded")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        os_log("Scene Inactive -> Active")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        os_log("Scene Active -> Inactive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        os_log("Scene Background -> Foreground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        os_log("Scene Foreground -> Background")
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

