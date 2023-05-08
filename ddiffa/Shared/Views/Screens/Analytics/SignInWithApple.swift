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
    @Binding var isPopUpOpen: Bool
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage ("userId") var userId : String = ""
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName : String = ""
    @AppStorage("lastName") var lastName : String = ""
    
    @Binding var userNames: String
    @Binding var userEmail: String
    @AppStorage("login") private var login = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                .background(.ultraThinMaterial)
            
            ZStack {
                Rectangle()
                    .frame(width: 360, height: 220)
                    .cornerRadius(20)
                    .foregroundColor(Color.background.secondary)
                
                VStack (spacing: 0) {
                    
                    HStack (spacing: 20){
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Join  **FocusFlow**!")
                                .font(.system(.title2, design: .rounded))
                                .foregroundColor(.text.primary)
                            
                            Text("See your analytics chart and get your focus flow with us.")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.text.secondary)
                        }
                    }
                    .padding([.leading,.trailing],40)
                    
                    
                    SignInWithAppleButton(
                        // Request User FullName and Email
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]   // You can change them if needed.
                        },
                        // Once user complete login, get result
                        onCompletion: { result in
                            // Switch result
                            switch result {
                                // Auth Success
                            case .success(let authResults):
                                switch authResults.credential {
                                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                    let uID = appleIDCredential.user
                                    
                                    if let emailAddress = appleIDCredential.email,
                                       let givenName = appleIDCredential.fullName?.givenName,
                                       let familyName = appleIDCredential.fullName?.familyName {
                                        
                                        // For New user to signup, and save the 3 records to CloudKit
                                        let record = CKRecord(recordType: "UsersData", recordID: CKRecord.ID(recordName: uID))
                                        record["email"] = emailAddress
                                        record["firstName"] = givenName
                                        record["lastName"] = familyName
                                        CKContainer.default().publicCloudDatabase.save(record) { (_, _) in
                                            userId = record.recordID.recordName
                                        }
                                        
                                        // Save to local
                                        email = emailAddress
                                        firstName = givenName
                                        lastName = familyName
                                        
                                        self.userNames = "\(firstName ) \(lastName )"
                                        self.userEmail = email
                                        self.isPopUpOpen = false
                                        // Change login state
                                        self.login = true
                                        
                                    } else {
                                        // For returning user to signin, fetch the saved records from Cloudkit
                                        CKContainer.default().publicCloudDatabase.fetch(withRecordID: CKRecord.ID(recordName: userId)) { (record, error) in
                                            if let fetchedInfo = record {
                                                // Save to local
                                                userId = userId
                                                email = fetchedInfo["email"] as! String
                                                firstName = fetchedInfo["firstName"] as! String
                                                lastName = fetchedInfo["lastName"] as! String
                                                
                                                self.userNames = "\(firstName ) \(lastName )"
                                                self.userEmail = email
                                                self.isPopUpOpen = false
                                                // Change login state
                                                self.login = true
                                            }
                                        }
                                    }
                                    
                                    // default break (don't remove)
                                default:
                                    break
                                }
                            case .failure(let error):
                                print("failure", error)
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(colorScheme == .dark ? .black : .white)
                    .frame(width: 300, height: 50)
                    .padding()
                    .cornerRadius(10)
                    
                    Button(action: {
                        isPopUpOpen = false
                    }) {
                        Text("Cancel")
                    }
                }
            }
            
        }
    }
}
//    func saveUserToCloudKit(userId: String, email: String?, firstName: String?, lastName: String?) {
//        let container = CKContainer.default()
//        let privateDatabase = container.privateCloudDatabase
//
//        let predicate = NSPredicate(format: "userId == %@", userId)
//        let query = CKQuery(recordType: "User", predicate: predicate)
//
//        privateDatabase.fetch(withQuery: query, inZoneWith: nil, desiredKeys: nil, resultsLimit: 0) { result in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let records):
//                if !records.matchResults.isEmpty {
//                    // User already exists in CloudKit
//                } else {
//                    // Save new user to CloudKit
//                    let record = CKRecord(recordType: "User")
//                    record["userId"] = userId
//                    record["email"] = email
//                    record["firstName"] = firstName
//                    record["lastName"] = lastName
//
//                    privateDatabase.save(record) { savedRecord, error in
//                        if let error = error {
//                            print(error.localizedDescription)
//                        } else {
//                            DispatchQueue.main.async {
//                                self.userId = userId
//                                self.email = email ?? ""
//                                self.firstName = firstName ?? ""
//                                self.lastName = lastName ?? ""
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}


