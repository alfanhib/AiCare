//
//  APIEndpoints.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import Foundation

enum APIEndpoints {
    static let baseURL = Env.current.baseURL
 
    static let plantIdentifierURL = "\(baseURL)/identification/?details=common_names%2Curl%2Cdescription%2Ctaxonomy%2Crank%2Cgbif_id%2Cinaturalist_id%2Cimage%2Csynonyms%2Cedible_parts%2Cwatering%2Cbest_light_condition%2Cbest_soil_type%2Ccommon_uses%2Ccultural_significance%2Ctoxicity%2Cbest_watering&language=en"
}
