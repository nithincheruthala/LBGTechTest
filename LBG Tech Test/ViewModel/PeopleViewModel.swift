//
//  PeopleViewModel.swift
//  LBG Tech Test
//
//  Created by Nithin Cheruthala on 20/10/2022.
//

import Foundation
struct PeopleListViewModel {
    let people: [People]
}
extension PeopleListViewModel {
    
    func numberOfRowsInSection(_ section: Int) -> Int{
        return self.people.count
    }
    func peopleAtIndex(_ index: Int) -> PeopleViewModel {
        let people = self.people[index]
        return PeopleViewModel(people)
    }
}

struct PeopleViewModel {
    private let people: People
}
extension PeopleViewModel {
    init(_ people: People) {
        self.people = people
    }
}

extension PeopleViewModel {
    var firstName: String {
        return self.people.firstName
    }
    var lastName: String {
        return self.people.lastName
    }
    var avatar: String {
        return self.people.avatar
    }
    var email: String {
        return self.people.email
    }
    var jobtitle: String {
        return self.people.jobtitle
    }
    var favouriteColor: String {
        return self.people.favouriteColor
    }
    var id: String {
        return self.people.id
    }
    
}
