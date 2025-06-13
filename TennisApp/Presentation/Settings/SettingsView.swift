//
//  SettingsView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/07/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        List {
            Section {
                ForEach(viewModel.getSettings(), id: \.rawValue) { item in
                    SettingsViewRow(title: item.title, iconName: item.iconName)
                        .onTapGesture {
                            viewModel.route(for: item)
                        }
                }
            } footer: {
                Text(viewModel.getFooterText())
                    .foregroundColor(Color(designLibrary.color.text.light))
                    .font(Font(designLibrary.font.textNormalSize.light))
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
    }
}

struct SettingsViewRow: View {

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    var title: String
    var iconName: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .renderingMode(.template)
                .foregroundColor(Color(designLibrary.color.text.brandPrimary))
            Text(title)
                .font(Font(designLibrary.font.textNormalSize.regular))
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
