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
                    TextField("ElevenLabs Key", text: $elevenLabsKey)
                } header: {
                    Text("API KEYS")
                } footer: {
                    Text("Please input your API Key above.")
                }
                Section {
                    Link("GET API KEY GEMINI AI", destination: URL(string: signUPGemini)!)
                    
                    Link("GET API KEY ELEVENLABS", destination: URL(string: signUpElevenLabs)!)
                        
                    
                } header: {
                    Text("DON'T HAVE API KEY?")
                }footer: {
                    Text("Sign up to get your own api key link above")
                }

                    
                }
            .navigationTitle("Configuration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button{
                    
                }label: {
                    Text("Save")
                        .padding(.trailing, 8)
                }
            }
        }
        }
    }


#Preview {
    SettingsView()
}
