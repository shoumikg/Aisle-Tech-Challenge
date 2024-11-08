//
//  AisleModels.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 08/11/24.
//

import Foundation

struct PhoneNumberRequest {
    let number: String
}

struct PhoneNumberResponse {
    let status: String
}

struct OTPRequest {
    let number: String
    let otp: String
}

struct OTPResponse {
    let token: String
}

struct ProfileListRequest {}

struct ProfileListResponse {
    let invites: Invites
    let likes: Likes
}

// MARK: - Invites
struct Invites: Codable {
    let profiles: [InvitesProfile]
    let totalPages, pendingInvitationsCount: Int

    enum CodingKeys: String, CodingKey {
        case profiles, totalPages
        case pendingInvitationsCount = "pending_invitations_count"
    }
}

// MARK: - InvitesProfile
struct InvitesProfile: Codable {
    let generalInformation: GeneralInformation
    let approvedTime, disapprovedTime: Double
    let photos: [Photo]
    let userInterests: [JSONAny]
    let work: Work
    let preferences: [ProfilePreference]
    let instagramImages: JSONNull?
    let lastSeenWindow: String
    let isFacebookDataFetched: Bool
    let icebreakers, story, meetup: JSONNull?
    let verificationStatus: String
    let hasActiveSubscription, showConciergeBadge: Bool
    let lat, lng: Double
    let lastSeen: JSONNull?
    let onlineCode: Int
    let profileDataList: [ProfileDataList]

    enum CodingKeys: String, CodingKey {
        case generalInformation = "general_information"
        case approvedTime = "approved_time"
        case disapprovedTime = "disapproved_time"
        case photos
        case userInterests = "user_interests"
        case work, preferences
        case instagramImages = "instagram_images"
        case lastSeenWindow = "last_seen_window"
        case isFacebookDataFetched = "is_facebook_data_fetched"
        case icebreakers, story, meetup
        case verificationStatus = "verification_status"
        case hasActiveSubscription = "has_active_subscription"
        case showConciergeBadge = "show_concierge_badge"
        case lat, lng
        case lastSeen = "last_seen"
        case onlineCode = "online_code"
        case profileDataList = "profile_data_list"
    }
}

// MARK: - GeneralInformation
struct GeneralInformation: Codable {
    let dateOfBirth, dateOfBirthV1: String
    let location: Location
    let drinkingV1: DrinkingV1Class
    let firstName, gender: String
    let maritalStatusV1: MaritalStatusV1Class
    let refID: String
    let smokingV1: DrinkingV1Class
    let sunSignV1, motherTongue, faith: Faith
    let height: Int
    let cast, kid, diet, politics: JSONNull?
    let pet, settle, mbti: JSONNull?
    let age: Int

    enum CodingKeys: String, CodingKey {
        case dateOfBirth = "date_of_birth"
        case dateOfBirthV1 = "date_of_birth_v1"
        case location
        case drinkingV1 = "drinking_v1"
        case firstName = "first_name"
        case gender
        case maritalStatusV1 = "marital_status_v1"
        case refID = "ref_id"
        case smokingV1 = "smoking_v1"
        case sunSignV1 = "sun_sign_v1"
        case motherTongue = "mother_tongue"
        case faith, height, cast, kid, diet, politics, pet, settle, mbti, age
    }
}

// MARK: - DrinkingV1Class
struct DrinkingV1Class: Codable {
    let id: Int
    let name, nameAlias: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAlias = "name_alias"
    }
}

// MARK: - Faith
struct Faith: Codable {
    let id: Int
    let name: String
}

// MARK: - Location
struct Location: Codable {
    let summary, full: String
}

// MARK: - MaritalStatusV1Class
struct MaritalStatusV1Class: Codable {
    let id: Int
    let name: String
    let preferenceOnly: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case preferenceOnly = "preference_only"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let photo: String
    let photoID: Int
    let selected: Bool
    let status: String?

    enum CodingKeys: String, CodingKey {
        case photo
        case photoID = "photo_id"
        case selected, status
    }
}

// MARK: - ProfilePreference
struct ProfilePreference: Codable {
    let answerID, id, value: Int
    let preferenceQuestion: PreferenceQuestion

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case id, value
        case preferenceQuestion = "preference_question"
    }
}

// MARK: - PreferenceQuestion
struct PreferenceQuestion: Codable {
    let firstChoice, secondChoice: String

    enum CodingKeys: String, CodingKey {
        case firstChoice = "first_choice"
        case secondChoice = "second_choice"
    }
}

// MARK: - ProfileDataList
struct ProfileDataList: Codable {
    let question: String
    let preferences: [ProfileDataListPreference]
    let invitationType: String

    enum CodingKeys: String, CodingKey {
        case question, preferences
        case invitationType = "invitation_type"
    }
}

// MARK: - ProfileDataListPreference
struct ProfileDataListPreference: Codable {
    let answerID: Int
    let answer, firstChoice, secondChoice: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case answer
        case firstChoice = "first_choice"
        case secondChoice = "second_choice"
    }
}

// MARK: - Work
struct Work: Codable {
    let industryV1: MaritalStatusV1Class
    let monthlyIncomeV1: JSONNull?
    let experienceV1: DrinkingV1Class
    let highestQualificationV1: MaritalStatusV1Class
    let fieldOfStudyV1: Faith

    enum CodingKeys: String, CodingKey {
        case industryV1 = "industry_v1"
        case monthlyIncomeV1 = "monthly_income_v1"
        case experienceV1 = "experience_v1"
        case highestQualificationV1 = "highest_qualification_v1"
        case fieldOfStudyV1 = "field_of_study_v1"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let profiles: [LikesProfile]
    let canSeeProfile: Bool
    let likesReceivedCount: Int

    enum CodingKeys: String, CodingKey {
        case profiles
        case canSeeProfile = "can_see_profile"
        case likesReceivedCount = "likes_received_count"
    }
}

// MARK: - LikesProfile
struct LikesProfile: Codable {
    let firstName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case avatar
    }
}
