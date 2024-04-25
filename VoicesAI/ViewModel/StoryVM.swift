//
//  StoryVM.swift
//  VoicesAI
//
//  Created by User on 25/04/24.
//

import Foundation
import GoogleGenerativeAI


@MainActor
class StoryVM: ObservableObject {
    @Published var storyText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - GENERATE STORY
    func generateStory(topic: Topics, mood: Mood) async {
        
        isLoading = true
        defer { isLoading = false}
        errorMessage = nil
        storyText = ""
        
        let apiKey = UserDefaults.standard.string(forKey: "GeminiAIKey") ?? ""
        
        guard !apiKey.isEmpty else{
            errorMessage = " API Key is missing. Please set it in Settings page!"
            return
        }
        let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)
        let topicString = topic.rawValue
        let moodString = mood.rawValue
        
        let prompt = "Tuliskan kutipan tentang \(topicString) dengan mood emosi \(moodString). Maksimal terdiri dari 40 kata."
        
        do{
            let response =  try await model.generateContent(prompt)
            if let text = response.text{
                storyText = text
            }

        }catch{
            errorMessage = "Failed to generate story: \(error.localizedDescription)"
            
        }
    }

}
