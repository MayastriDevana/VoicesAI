//
//  SpeechVM.swift
//  VoicesAI
//
//  Created by User on 25/04/24.
//

import Foundation
import AVFoundation
@MainActor
class SpeechVM: NSObject,ObservableObject, AVAudioPlayerDelegate{
    @Published var isLoading = false
    @Published var isPlaying = false
    @Published var errorMessage: String?
    
    private var elevenLabsService: ElevenLabsService?
    private var audioPlayer: AVAudioPlayer?
    
    
    // MARK: - Generate and play speech
    func generatedAndPlaySpeech(from text: String, apiKey: String)
    async {
        isLoading = true
//        defer { isLoading = false}
//        defer { isPlaying = false}
        errorMessage = nil
        
        elevenLabsService = ElevenLabsService(apiKey: apiKey)
        do{
            guard let audioData = try await elevenLabsService?.generateSpeech(for: text) else{
                errorMessage = "Failed to generate audio data"
                isLoading = false
                isPlaying = true
//                print(errorMessage!)
                return
            }
            playAudio(from: audioData)
        }catch{
            print("Error generating or playing speech: \(error)")
            isPlaying = false
            isLoading = false
            
        }
    }

}

// MARK: - Function Play Audio
extension SpeechVM{
    func playAudio(from data: Data){
        do{
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.delegate = self
            isPlaying = true
            audioPlayer?.play()
            isLoading = false
        }catch{
            print("Audio player error: \(error.localizedDescription)")
            isPlaying = false
            isLoading = false
        }
    }
}

