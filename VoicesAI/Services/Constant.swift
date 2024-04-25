//
//  Constant.swift
//  VoicesAI
//
//  Created by User on 24/04/24.
//

import Foundation

struct Constant{
    static let baseURL = "https://api.elevenlabs.io/"
    static let appVersion = "v1"
    
    enum Endpoint: String{
        case textToSpeech = "text-to-speech"
        case speechToSpeech = "speech-to-speech"
    }
    enum VoiceID: String {
        case lady = "07nwoJgDl8KYG04XmIRf"
        case arthur = "peHtuEawPBDJyfzxxP8X"
    }
    // let urlString = Constant.fullURL(forVoice: .thomas)
    //https://api.elevenlabs.io/v1/text-to-speech/07nwoJgDl8KYG04XmIRf
    static func fullURL(forVoice voice: VoiceID) -> String{
        let results = baseURL + appVersion + "/" + Endpoint.textToSpeech.rawValue + "/" + voice.rawValue
        return results
    }
}
