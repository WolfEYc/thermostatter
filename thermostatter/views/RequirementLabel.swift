//
//  RequirementLabel.swift
//  thermostatter
//
//  Created by wolfey on 7/21/24.
//

import SwiftUI

struct RequirementLabel: View {
    let text: String
    let checked: Bool
    
    var body: some View {
        Label(
            title: {
                Text(text)
                    .font(.callout)
            },
            icon: {
                Image(systemName: "checkmark")
                    .imageScale(.medium)
            }
        )
        .foregroundStyle(checked ? Color.green : Color.gray)
        .transition(.opacity)
        .animation(.linear, value: checked)
    }
}

#Preview {
    RequirementLabel(text: "example label", checked: true)
}
