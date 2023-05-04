//
//  SignInWithApple.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 03/05/23.
//

import SwiftUI
import AuthenticationServices
import CloudKit

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage ("userId") var userId : String = ""
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName : String = ""
    @AppStorage("lastName") var lastName : String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SignInWithAppleButton(.continue) { request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    switch result {
                    case .success(let auth):
                        switch auth.credential {
                        case let credential as ASAuthorizationAppleIDCredential:
                            let userId = credential.user
                            
                            let email = credential.email
                            let firstName = credential.fullName?.givenName
                            let lastName = credential.fullName?.familyName
                            
                            saveUserToCloudKit(userId: userId, email: email, firstName: firstName, lastName: lastName)
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                .frame(height: 50)
                .padding()
                .cornerRadius(10)
            }
        }
    }
    
    func saveUserToCloudKit(userId: String, email: String?, firstName: String?, lastName: String?) {
        let container = CKContainer.default()
        let privateDatabase = container.privateCloudDatabase
        
        let predicate = NSPredicate(format: "userId == %@", userId)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        privateDatabase.fetch(withQuery: query, inZoneWith: nil, desiredKeys: nil, resultsLimit: 0) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let records):
                if !records.matchResults.isEmpty {
                    // User already exists in CloudKit
                } else {
                    // Save new user to CloudKit
                    let record = CKRecord(recordType: "User")
                    record["userId"] = userId
                    record["email"] = email
                    record["firstName"] = firstName
                    record["lastName"] = lastName
                    
                    privateDatabase.save(record) { savedRecord, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            DispatchQueue.main.async {
                                self.userId = userId
                                self.email = email ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""
                            }
                        }
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

