//
//  SpeciesEditView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/8.
//

import SwiftUI


struct SpeciesEditView: View {
    @EnvironmentObject var userData: UserData
//    @State private var specieses: Array<Species>
//    private var draftType: State<String>
    @State private var draftSpecies = ""
    @State private var showDropDown = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("Type", text: $draftSpecies, onCommit: {
                if !userData.specieses.contains(where: {$0.title == draftSpecies}) {
                    userData.specieses.append(Species(title: draftSpecies))
                }  //如果是新物种，添加到sepcieses
            })
                .onTapGesture {
                    showDropDown = true  //显示下拉式菜单
                }
                .onChange(of: draftSpecies) { value in
                    showDropDown = true
                }
            //下拉式菜单
            if showDropDown {
                List {
                    ForEach(userData.specieses.filter {$0.title.lowercased().hasPrefix(draftSpecies.lowercased())}) { species in
                        Button(action: {
                            draftSpecies = species.title
                            showDropDown = false  //关闭下拉式菜单
                        }) {
                            Text(species.title)
                        }
                    }
                }
            }
        }
    }
    
}
