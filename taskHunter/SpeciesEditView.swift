//
//  SpeciesEditView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/8.
//

import SwiftUI


struct SpeciesEditView: View {
    @EnvironmentObject var userData: UserData
    @Binding var task: Task
    @State private var draftSpecies: String
    @State private var showDropDown = false
    
    init(task: Binding<Task>) {
        self._task = task
        _draftSpecies = State(initialValue: task.species.wrappedValue)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("Species", text: $draftSpecies, onCommit: {
                if !userData.specieses.contains(where: {$0.title == draftSpecies}) {
                    userData.specieses.append(Species(title: draftSpecies))
                }  //如果是新物种，添加到sepcieses
                task.species = draftSpecies
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
                        Button(species.title) {
                            draftSpecies = species.title
                            showDropDown = false  //关闭下拉式菜单
                        }
                    }
                    Button("Delete all species") {
                        userData.specieses.removeAll()
                    }.foregroundColor(.red)
                }
            }
        }
    }
}
