//
//  NetworkManager.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 08/11/24.
//

import Foundation

final class NetworkManager {
    private let client: URLSession
    public static let instance = NetworkManager()
    
    private init(client: URLSession = URLSession.shared) {
        self.client = client
    }
    
    private enum Constants {
        static let baseURL = "https://app.aisle.co/V1"
        static let phoneNumberURL = baseURL + "/users/phone_number_login"
        static let otpURL = baseURL + "/users/verify_otp"
        static let notesURL = baseURL + "/users/test_profile_list"
    }
    
    public func requestOTP(countryCode: String, 
                           phoneNumber: String,
                           completion: @escaping (Bool) -> ()) {
        var request = URLRequest(url: URL(string: Constants.phoneNumberURL)!)
        let body = try? JSONEncoder().encode(PhoneNumberRequest(number: countryCode+phoneNumber))
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        let task = client.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(false)
                return
            }
            if let data, !data.isEmpty {
                let response = try? JSONDecoder().decode(PhoneNumberResponse.self, from: data)
                if let response {
                    completion(response.status)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    public func verifyOTP(countryCode: String,
                          phoneNumber: String,
                          otp: String,
                          completion: @escaping (Result<NotesViewModel, Error>) -> ()) {
        var request = URLRequest(url: URL(string: Constants.otpURL)!)
        let body = try? JSONEncoder().encode(OTPRequest(number: countryCode+phoneNumber, otp: otp))
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        let task = client.dataTask(with: request) { [weak self] data, _, error in
            guard let self, error == nil else {
                completion(.failure(NSError(domain: error.debugDescription, code: -1)))
                return
            }
            if let data, !data.isEmpty {
                let response = try? JSONDecoder().decode(OTPResponse.self, from: data)
                if let response, !response.token.isEmpty {
                    getProfilesList(token: response.token, completion: completion)
                } else {
                    completion(.failure(NSError(domain: "invalid token", code: -1)))
                }
            } else {
                completion(.failure(NSError(domain: "invalid data", code: -1)))
            }
        }
        task.resume()
    }
    
    private func getProfilesList(token: String, 
                                 completion: @escaping (Result<NotesViewModel, Error>) -> ()) {
        var request = URLRequest(url: URL(string: Constants.notesURL)!)
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        let task = client.dataTask(with: request) { [weak self] data, _, error in
            guard let self, error == nil else {
                completion(.failure(NSError(domain: error.debugDescription, code: -1)))
                return
            }
            if let data, !data.isEmpty {
                let response = try? JSONDecoder().decode(ProfileListResponse.self, from: data)
                var invites: [NotesViewModel.Profile] = []
                var likes: [NotesViewModel.Profile] = []
                
                let invitations = response?.invites.profiles ?? []
                for invitation in invitations {
                    invites.append(NotesViewModel.Profile(imageURL: invitation.photos.first?.photo ?? "", 
                                                          name: invitation.generalInformation.firstName,
                                                          dob: invitation.generalInformation.dateOfBirth))
                }
                for like in response?.likes.profiles ?? [] {
                    likes.append(NotesViewModel.Profile(imageURL: like.avatar,
                                                        name: like.firstName, 
                                                        dob: nil))
                }
                completion(.success(NotesViewModel(invites: invites, likes: likes)))
            }
        }.resume()
    }
}
