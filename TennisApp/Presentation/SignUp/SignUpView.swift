//
//  SignUpView.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 28/08/23.
//  Copyright © 2023 Andrea Stevanato. All rights reserved.
//

import SwiftUI

struct SignUpView: View {

    let designLibrary = DesignLibrary()
    let bundle = Bundle.main

    @ObservedObject var viewModel: SignUpViewModel

    var body: some View {
        VStack {
            Text(bundle.appDisplayName)
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            if let image = UIImage(named: AppIconProvider.appIcon()) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                    .overlay(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)).stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.bottom, 50)
            }
            VStack(alignment: .leading, spacing: 15) {
                buildSignInForm()
            }
            .padding([.leading, .trailing], 27.5)
            Spacer()
            Button(action: {
                self.viewModel.signUp()
            }, label: {
                Text("Sign In")
                    .font(.headline)
                    .padding()
                    .frame(width: 300, height: 50)
            })
            .tint(Color(designLibrary.color.background.buttonPrimary))
            .buttonStyle(.borderedProminent)
            .disabled(!viewModel.canSubmit)
            Spacer()
        }
        .background(
            Image(designLibrary.miscellaneous.asset.signUpBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 10)
                .edgesIgnoringSafeArea(.all))
    }

    @ViewBuilder
    func buildSignInForm() -> some View {
        Group {
            TextField("First name", text: $viewModel.firstName)
            TextField("Last name", text: $viewModel.lastName)
        }
        .padding()
        .background(.white)
        .cornerRadius(15.0)
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel(userSaveUserCase:
                                            DefaultUserSaveUserCase(usersRepository:
                                                                        DefaultUsersRepository(usersLocalStorage: UsersCoreDataStorage()))))
}
