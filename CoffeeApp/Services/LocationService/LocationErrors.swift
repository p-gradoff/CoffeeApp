//
//  LocationErros.swift
//  CoffeeApp
//
//  Created by Павел Градов on 09.11.2024.
//

final class LocationError {
    static let ERR_CANT_GET_USER_LOCATION = "error_process_of_user_location_server_has_crashed"
    static let ERR_UNDEFINED_ERROR_WITH_LOCATION_SERVICE = "error_something_went_wrong_with_location_service_work"
    
    static func messageFor(err: String) -> String {
        switch err {
        case ERR_CANT_GET_USER_LOCATION:
            return "Location service cannot retrieve data on the user's current location"
        case ERR_UNDEFINED_ERROR_WITH_LOCATION_SERVICE:
            return "Something went wrong with location service work"
        default:
            return "An error has occured. Please check your internet connection and try again"
        }
    }
}
