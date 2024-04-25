//
//  StoriesView.swift
//  VoicesAI
//
//  Created by User on 24/04/24.
//

import SwiftUI

struct StoriesView: View {
    @StateObject private var storyVM = StoryVM()
    @StateObject private var speechVM = SpeechVM()
    
    @State private var selectedTopic: Topics = .persahabatan
    @State private var selectedMood: Mood = .bahagia
    //    @State private var todayStory: String = ""
    
    var body: some View {
        NavigationStack{
            Form{
                // MARK: - PICKER VIEW
                
                Section{
                    Picker(selection: $selectedTopic) {
                        ForEach(Topics.allCases){ topic in Text(topic.rawValue)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                .tag(topic)
                        }
                    }label:{
                        Text("Choose topics")
                            .foregroundStyle(.gray)
                    }
                    Picker(selection: $selectedMood) {
                        ForEach(Mood.allCases){ mood in Text(mood.rawValue)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                                .tag(mood)
                        }
                    }label:{
                        Text("Choose mood")
                            .foregroundStyle(.gray)
                    }
                }
            header: {
                Text("Topics")
            }footer: {
                Text("Choose any topics and mood that you want to listen.")
            }
                // MARK: - TEXT EDITOR
                Section{
                    TextEditor(text: $storyVM.displayStoryText)
                        .frame(height: 200)
                        .font(.system(.headline, design: .rounded))
                        .foregroundStyle(.blue)
                        .disabled(storyVM.isLoading)
                        .overlay{
                            storyVM.isLoading ? ProgressView() : nil
                        }
                    
                }header: {
                    Text("Today Story")
                } footer: {
                    Text("This storie are being generated by Gemini AI.")
                }
                
                // MARK: - GENERATE STORY
                Button{
                    todayStory()
                    
                }label: {
                    if storyVM.isLoading{
                        ProgressView().scaleEffect(1)
                    }else{
                        Text(storyVM.storyText.isEmpty ? "Generate".uppercased() : "Speech".uppercased())
                            .font(.system(.callout, design: .rounded))
                            .fontWeight(.bold)
                    }
                    
                }
                .buttonStyle(PlainButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                
                
            }
            .navigationTitle("Stories")
            //            .navigationBarTitleDisplayMode(.inline)
            .tint(.primary)
        }
    }
}
#Preview {
    StoriesView()
}

// MARK: - Play Speech

extension StoriesView{
    func playSpeech() {
        let apiKey = UserDefaults.standard.string(forKey: "ElevenLabsAPIKey") ?? ""
        
        Task{
            await speechVM.generatedAndPlaySpeech(from: storyVM.displayStoryText, apiKey: apiKey)
        }
    }
    func generateStory(){
        Task{
            await storyVM.generateStory(topic: selectedTopic, mood: selectedMood)
        }
    }
    func todayStory(){
        if storyVM.displayStoryText.isEmpty{
            generateStory()
        }else{
            playSpeech()
        }
    }
}



