//
//  StubView.swift
//  vkSwiftUI
//
//  Created by Ke4a on 14.03.2023.
//

import SwiftUI

struct StubView: View {
    var body: some View {
        Text("Функционал отключен...")
            .font(.system(size: 24))
            .fontWeight(.bold)
            .foregroundColor(.red)
    }
}

struct StubView_Previews: PreviewProvider {
    static var previews: some View {
        StubView()
    }
}
