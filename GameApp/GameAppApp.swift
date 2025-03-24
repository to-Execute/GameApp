//
//  GameAppApp.swift
//  GameApp
//
//  Created by SreeNath on 22/03/2025.
//

import SwiftUI

@main
struct GameAppApp: App {
    var body: some Scene {
        WindowGroup {
            GameAppView(viewModel: GameAppViewModel())
        }
    }
}
