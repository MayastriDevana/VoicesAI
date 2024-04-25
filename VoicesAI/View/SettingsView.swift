//
//  SettingsView.swift
//  VoicesAI
//
//  Created by User on 24/04/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var geminiAIKey = ""
    @State private var elevenLabsKey = ""
    
    let signUPGemini = "https://ai.google.dev"
    let signUpElevenLabs = "https://elevenlabs.io/api"
    
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    TextField("Gemini AI Key", text: $geminiAIKey)
                        .onAppear{
                            geminiAIKey = UserDefaults.standard.string(forKey: "GeminiAIKey") ?? ""
                        }
                    TextField("ElevenLabs Key", text: $elevenLabsKey)
                        .onAppear{
                            elevenLabsKey = UserDefaults.standard.string(forKey: "ElevenLabsAPI") ?? ""
                        }
                } header: {
                    Text("API KEYS")
                } footer: {
                    Text("Please input your API Key above.")
                }
                Section {
                    Link("GET API KEY GEMINI AI", destination: URL(string: signUPGemini)!)
                        .foregroundStyle(.blue)
                    
                    Link("GET API KEY ELEVENLABS", destination: URL(string: signUpElevenLabs)!)
                        .foregroundStyle(.blue)
                        
                    
                } header: {
                    Text("DON'T HAVE API KEY?")
                }footer: {
                    Text("Sign up to get your own api key link above")
                }

                    
                }
            .navigationTitle("Configuration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                // MARK: - SAVE KEY
                Button{
                    saveKey()
                }label: {
                    Text("Save")
                        .padding(.trailing, 8)
                        
                }
                .disabled(geminiAIKey.isEmpty || elevenLabsKey.isEmpty)
            }
        }
        }
    }


#Preview {
    SettingsView()
}

extension SettingsView {
    func saveKey(){
        UserDefaults.standard.set(geminiAIKey, forKey: "GeminiAIKey")
        UserDefaults.standard.set(elevenLabsKey, forKey: "ElevenLabsAPI")
    }
}
