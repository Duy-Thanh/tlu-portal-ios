//
//  Definitions.swift
//  TLUPortal
//
//  Created by Thành Duy Nguyễn on 11/07/2023.
//

import Foundation

// Login section
struct PortalLogin: Decodable {
    var accessToken: String
    var tokenType: String
    var refreshToken: String
    var expiresIn: Int
    var scope: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case scope = "scope"
    }
}

var SwiftErrorReturn: String = ""
var SwiftErrorStatus: String = ""
var SwiftErrorDescription: String = ""

struct PortalLogin_Error: Decodable {
    var APIErrorReturn: String
    var APIErrorReturnDesc: String
    
    enum CodingKeys: String, CodingKey {
        case APIErrorReturn = "error"
        case APIErrorReturnDesc = "error_description"
    }
}

struct PortalUserInfo: Decodable {
    var createdDate: String?
    var createdBy: String?
    var modifiedDate: String?
    
    var id: Int
    var displayName: String
    var username: String
    
    var password: String?
    var confirmPassword: String?
    
    var changePass: Bool
    var active: Bool
    
    var lastName: String?
    var firstName: String?
    
    var dob: Int64
    
    var birthPlace: String
    var email: String
    
    var person: PersonData
    
    var hasPhoto: Bool
    
    var roles: [RolesData]
    
    var group: [String]?
    
    var setPassword: Bool
    
    enum CodingKeys: String, CodingKey {
        case createdDate
        case createdBy
        case modifiedDate
        case id
        case displayName
        case username
        case password
        case confirmPassword
        case changePass
        case active
        case lastName
        case firstName
        case dob
        case birthPlace
        case email
        case person
        case hasPhoto
        case roles
        case group
        case setPassword
    }
    
    struct PersonData: Decodable {
        var createdDate_person: String?
        var createdBy_person: String?
        var modifiedDate_person: String?
        var modifiedBy_person: String?
        
        var id_person: Int
        
        var firstName_person: String
        var lastName_person: String
        var displayName_person: String
        
        var shortName_person: String?
        var birthDate_person: Int
        var birthDateString_person: String
        
        var birthPlace_person: String
        
        var gender_person: String
        
        var startDate_person: String?
        var endDate_person: String?
        
        var phoneNumber_person: String
        var idNumber_person: String
        var idNumberIssueBy_person: String
        var idNumberIssueDate_person: Int
        var idNumberIssueDateString_person: String
        
        var email_person: String
        
        var nationally_person: String?
        
        var nativeVillage_person: String?
        
        var ethnics_person: String?
        
        var religion_person: String?
        
        // Photo
        var photo_person: String?
        var photoCropped_person: String?
        
        var address_person: [AddressData]
        
        struct AddressData: Decodable {
            var id_person_address: Int
            
            var address_person_address: String
            
            var address1_person_address: String?
            
            var city_person_address: String?
            
            var province_person_address: String?
            
            var country_person_address: String?
            
            var postalCode_person_address: String?
            
            var latitude_person_address: String?
            
            var longitude_person_address: String?
            
            var personId_person_address: Int
            
            var type_person_address: String?
            
            var provinceId_person_address: String?
            
            var cityId_person_address: String?
            
            var villageId_person_address: String?
        }
        
        var userId_person: Int?
        
        var communistYouthUnionJoinDate_person: Int?
        
        var communistYouthUnionJoinDateString_person: String?
        
        var communistPartyJoinDate_person: Int?
        
        var communistPartyJoinDateString_person: String?
        
        var career_person: String?
        
        var createIp_person: String?
        
        var modifyIp_person: String?
    }
    
    struct RolesData: Decodable {
        var id_roles: Int
        var name_roles: String
        var description_roles: String?
        var authority_roles: String
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode properties using the CodingKeys enum
        createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        createdBy = try container.decodeIfPresent(String.self, forKey: .createdBy)
        modifiedDate = try container.decodeIfPresent(String.self, forKey: .modifiedDate)
        id = try container.decode(Int.self, forKey: .id)
        displayName = try container.decode(String.self, forKey: .displayName)
        username = try container.decode(String.self, forKey: .username)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        confirmPassword = try container.decodeIfPresent(String.self, forKey: .confirmPassword)
        changePass = try container.decode(Bool.self, forKey: .changePass)
        active = try container.decode(Bool.self, forKey: .active)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        dob = try container.decode(Int64.self, forKey: .dob)
        birthPlace = try container.decode(String.self, forKey: .birthPlace)
        email = try container.decode(String.self, forKey: .email)
        person = try container.decode(PersonData.self, forKey: .person)
        hasPhoto = try container.decode(Bool.self, forKey: .hasPhoto)
        roles = try container.decode([RolesData].self, forKey: .roles)
        group = try container.decodeIfPresent([String].self, forKey: .group)
        setPassword = try container.decode(Bool.self, forKey: .setPassword)
    }
}
