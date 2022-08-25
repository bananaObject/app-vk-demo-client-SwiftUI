//
//  FriendsList.swift
//  vkSwiftUI
//
//  Created by Ke4a on 16.07.2022.
//

import CoreData
import SwiftUI

struct FriendsListScreen: View {
    @ObservedObject var viewModel: FriendsViewModel

    init(_ viewModel: FriendsViewModel ) {
        self.viewModel = viewModel
    }

    var body: some View {
        friendsList
            .navigationBarItems(trailing: EditButton())
            .onAppear {
                if viewModel.firstTime {
                    #warning("Пока при каждом запуске удаляются все данные из бд")
                    #warning("так как еще не сделал обновление старых данных и нормальную работу core data")
                    viewModel.fetchFriends()
                    #warning("Баг двойной запуск жизненого цикла фиксится только вот так")
                    viewModel.firstTime.toggle()
                }
            }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension FriendsListScreen {
    var friendsList: some View {
        VStack {
            List {
                ForEach(viewModel.letter, id: \.self) { name in
                    Section(name) {
                        if let section = viewModel.section[name] {
                            ForEach(section, id: \.id) { friend in
                                ListCell(friend)
                                    .onTapGesture {
                                        viewModel.selectedFriend = friend
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.inset)
        }
    }
}

//struct FriendsListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsListScreen(FriendsViewModel(nil))
//    }
//}
