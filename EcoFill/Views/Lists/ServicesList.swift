//
//  ServicesList.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 01.12.2023.
//

import SwiftUI

struct ServicesList: View {
  var body: some View {
    NavigationStack {
      List(services) { service in
        ServiceCell(service: service)
      }
      .listStyle(.insetGrouped)
      .listRowSpacing(15)
    }
  }
}

#Preview {
  ServicesList()
}
