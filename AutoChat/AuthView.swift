//
//  ContentView.swift
//  AutoChat
//
//  Created by Yurka Babayan on 22.09.23.
//

import SwiftUI
import ComposableArchitecture

struct RegisterReducer: Reducer {
    
    struct State: Equatable {
        var emailText = ""
        var passwordText = ""
        var confirmPassword = ""
        var secureBtn = false
        var createAccaunt = false
    }
    
    enum Action: Equatable {
        case emailChange(String)
        case passwordTextChange(String)
        case passwordConfirm(String)
        case secureChange
        case accauntCreate
    }
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .emailChange(let newText):
            state.emailText = newText
            return .none
            
        case .passwordTextChange(let newPasText):
            state.passwordText = newPasText
            return .none
            
        case .secureChange:
            state.secureBtn.toggle()
            return .none
            
        case .passwordConfirm(let newCnfPass):
            state.confirmPassword = newCnfPass
            return .none
            
        case .accauntCreate:
            state.createAccaunt.toggle()
            return .none
        }
    }
    
}

struct AuthView: View {
    
    let store: StoreOf<RegisterReducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(viewStore.createAccaunt ? "Create an Accaunt" : "Log In")
                                .font(.system(size: viewStore.createAccaunt ? 45 : 55))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("custYello"))
                            
                            Spacer()
                            
                            if viewStore.createAccaunt {
                                Image(systemName: "person")
                                    .foregroundColor(Color("custYello"))
                                    .font(.system(size: 55))
                                    .padding(20)
                                    .background(Color("textFieldViewBlue"))
                                    .clipShape(Circle())
                            }
                        }
                        
                        if !viewStore.createAccaunt {
                            Text("Sign in to continue")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(.gray.opacity(0.5))
                        }
                    }
                    .padding(.horizontal, 30)
                    Spacer()
                }
                
                VStack {
                    TextField(
                        "",
                        text: viewStore.binding(
                            get: \.emailText,
                            send: {.emailChange($0)}
                        ),
                        prompt: Text("Email")
                            .font(.title3)
                            .foregroundColor(.gray.opacity(0.5))
                    )
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.vertical, 12)
                    
                    Divider()
                        .background(Color.white.opacity(0.5))
                    
                    
                    HStack {
                        if !viewStore.secureBtn {
                            SecureField(
                                "",
                                text: viewStore.binding(
                                    get: \.passwordText,
                                    send: {.passwordTextChange($0)}
                                ),
                                prompt: Text("Password")
                                    .font(.title3)
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(.vertical, 12)
                            
                            Image(systemName: "eye.slash")
                                .foregroundColor(.gray.opacity(0.5))
                                .onTapGesture {
                                    viewStore.send(.secureChange)
                                }
                        } else {
                            TextField(
                                "",
                                text: viewStore.binding(
                                    get: \.passwordText,
                                    send: {.passwordTextChange($0)}
                                ),
                                prompt: Text("Password")
                                    .font(.title3)
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(.vertical, 12)
                            
                            Image(systemName: "eye")
                                .foregroundColor(.gray.opacity(0.5))
                                .onTapGesture {
                                    viewStore.send(.secureChange)
                                }
                        }
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                    
                    
                    Button {
                        //
                    } label: {
                        Text("LOG IN")
                            .foregroundColor(Color("textFieldViewBlue"))
                            .font(.title3)
                            .fontWeight(.heavy)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color("custYello"))
                            .cornerRadius(12)
                            .padding(.vertical)
                    }
                    
                    HStack {
                        Text("Don't have an accaunt?")
                            .foregroundColor(.gray.opacity(0.6))
                        
                        Text("Create Accaunt")
                            .foregroundColor(.gray.opacity(0.6))
                            .fontWeight(.bold)
                            .padding(.vertical, 8)
                            .onTapGesture {
                                viewStore.send(.accauntCreate)
                            }
                        
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("textFieldViewBlue"))
                .cornerRadius(13)
                .padding(.horizontal)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("custBlue"))
            .animation(Animation.easeInOut(duration: 0.3))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(store: Store(initialState: RegisterReducer.State(), reducer: {
            RegisterReducer()
        }))
    }
}
