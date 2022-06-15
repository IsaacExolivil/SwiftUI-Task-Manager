//
//  ContentView.swift
//  Notas Watch WatchKit Extension
//
//  Created by Jose Isaac on 14/06/22.
//

import SwiftUI

struct ContentView: View {
    
    
    //MARK: Matched Geometry Namespace
    @Namespace var animation
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                VStack(alignment: .leading, spacing: 18) {
                    Text("Welcome Isaac")
                        .font(.callout)
                    Text("Here's Update Today.")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
               
            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
