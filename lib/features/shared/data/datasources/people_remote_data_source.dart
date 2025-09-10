import 'package:edmentoresolve/features/shared/domain/entities/person.dart';

/// Remote data source for people/staff data
abstract class IPeopleRemoteDataSource {
  Future<List<Person>> getPeople({
    String? searchQuery,
    StaffRole? role,
    int page = 1,
    int limit = 50,
  });
}

/// Mock implementation of people remote data source using real API data
class PeopleRemoteDataSource implements IPeopleRemoteDataSource {
  @override
  Future<List<Person>> getPeople({
    String? searchQuery,
    StaffRole? role,
    int page = 1,
    int limit = 50,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Real API data from the provided response
    final allPeople = [
      // Users with assigned roles
      const Person(
        id: '5506fe3f-7929-4d9d-aae8-4b57db6de6ba',
        name: 'Hameesh',
        email: 'coordinator@edmentoresolve.com',
        phone: '1234567890',
        positionName: 'Coordinator',
        assignedRoles: [
          AssignedRole(
            roleId: 5,
            positionName: 'Coordinator',
            category: 'Academic',
          ),
        ],
      ),
      const Person(
        id: 'a0096926-7ca6-43db-a8f1-3674c80fd005',
        name: 'Rabeeh',
        email: 'teacher@edmentoresolve.com',
        phone: '1234512345',
        positionName: 'Teacher',
        assignedRoles: [
          AssignedRole(
            roleId: 6,
            positionName: 'Teacher',
            category: 'Academic',
          ),
        ],
      ),
      const Person(
        id: '10b18ebc-4989-49ad-84ba-29953e2b5b6d',
        name: 'Rafi',
        email: 'principal@edmentoresolve.com',
        phone: '123456',
        positionName: 'Principal',
        assignedRoles: [
          AssignedRole(
            roleId: 3,
            positionName: 'Principal',
            category: 'Administrative',
          ),
        ],
      ),
      const Person(
        id: 'a24cc1d3-5f62-46a2-bb92-7b8df4b60840',
        name: 'Coordinator',
        email: 'muheenudeeq313@gmail.com',
        phone: '7654322411e',
        positionName: 'Coordinator',
        assignedRoles: [
          AssignedRole(
            roleId: 5,
            positionName: 'Coordinator',
            category: 'Academic',
          ),
        ],
      ),
      const Person(
        id: 'd620e43e-71ce-4f4e-a008-903b898aa0b5',
        name: 'rabii',
        email: 'rabirabz001@gmail.com',
        phone: '765432',
        positionName: 'Coordinator',
        assignedRoles: [
          AssignedRole(
            roleId: 5,
            positionName: 'Coordinator',
            category: 'Academic',
          ),
        ],
      ),

      // Users without assigned roles (students/staff)
      const Person(
        id: '2e4a8908-2933-4683-985b-81aa220d7e45',
        name: 'muhamemd',
        email: 'rafipmkm@gmail.com',
        phone: '7896541233',
      ),
      const Person(
        id: '689ca77a-5b1d-4948-b67b-b653df62bd55',
        name: 'Ira Jain',
        email: 'ira.jain2@example.com',
        phone: '6577442871',
      ),
      const Person(
        id: '2e57fdd4-471d-4a98-a3cf-c5abc7583f8e',
        name: 'Aarav Ansari',
        email: 'aarav.ansari10@example.com',
        phone: '6652614498',
      ),
      const Person(
        id: 'd5765dec-c518-4e7b-b067-75bcc302d160',
        name: 'Kavya Pillai',
        email: 'kavya.pillai15@example.com',
        phone: '7070003524',
      ),
      const Person(
        id: '33d575d3-a140-4667-8c8c-72788e17c3a3',
        name: 'Ajay Farooq',
        email: 'ajay.farooq14@example.com',
        phone: '7736384200',
      ),
      const Person(
        id: '43f89e5e-cda4-4bf6-83ea-f09b91f86c2b',
        name: 'Ajay Patel',
        email: 'ajay.patel16@example.com',
        phone: '9244063480',
      ),
      const Person(
        id: 'd530dbf9-1cd9-4778-95ca-659df85b4115',
        name: 'Nikita Sharma',
        email: 'nikita.sharma12@example.com',
        phone: '8413982250',
      ),
      const Person(
        id: '16dbd4cf-ef89-4c7e-9c8b-ab10f0a847e6',
        name: 'Ira Pillai',
        email: 'ira.pillai31@example.com',
        phone: '6632073568',
      ),
      const Person(
        id: '937565aa-9c9d-4a77-8941-566d259461f1',
        name: 'Sanjay Reddy',
        email: 'sanjay.reddy33@example.com',
        phone: '9810458697',
      ),
      const Person(
        id: 'd50d0e4e-235e-4711-944b-cc55cfd076fe',
        name: 'Harsh Shetty',
        email: 'harsh.shetty26@example.com',
        phone: '9290680319',
      ),
      const Person(
        id: '20db927b-393c-479b-a5b0-7be64148faa6',
        name: 'Ravi Sethi',
        email: 'ravi.sethi55@example.com',
        phone: '8473722111',
      ),
      const Person(
        id: '519f1b64-6e58-4658-b811-30bbb5b25d86',
        name: 'Priya Khanna',
        email: 'priya.khanna42@example.com',
        phone: '6126704542',
      ),
      const Person(
        id: '9136df66-8d8d-4e82-9a53-04978174fcaf',
        name: 'Ravi Joshi',
        email: 'ravi.joshi41@example.com',
        phone: '8782742472',
      ),
      const Person(
        id: '5bab8bcb-216b-4370-ac8c-7ef8db83b5e2',
        name: 'Ayesha Arora',
        email: 'ayesha.arora60@example.com',
        phone: '9448936679',
      ),
      const Person(
        id: 'f2b94e75-266d-4419-9b79-ec6fada54f32',
        name: 'Harsh Ansari',
        email: 'harsh.ansari59@example.com',
        phone: '6189025456',
      ),
      const Person(
        id: '0066502a-db0b-4853-af95-b6c2f1888745',
        name: 'Harsh Ghosh',
        email: 'harsh.ghosh51@example.com',
        phone: '7479285447',
      ),
      const Person(
        id: 'e35bdb1d-b0f6-4136-8151-6f1b66615259',
        name: 'Rohan Pillai',
        email: 'rohan.pillai47@example.com',
        phone: '6767910116',
      ),
      const Person(
        id: '7cecb1a1-63c9-47ab-87a2-412c26b2033f',
        name: 'Ajay Pillai',
        email: 'ajay.pillai63@example.com',
        phone: '7980137521',
      ),
      const Person(
        id: 'f2f4b706-411b-45e5-b2f2-ac85efcc9c5a',
        name: 'Pari Chauhan',
        email: 'pari.chauhan73@example.com',
        phone: '9270778368',
      ),
      const Person(
        id: 'd013aa6e-3e08-45ec-a2b3-a637882259ed',
        name: 'Harsh Pathak',
        email: 'harsh.pathak77@example.com',
        phone: '6469072315',
      ),
      const Person(
        id: '4093235f-9523-49ca-a076-a6c411465607',
        name: 'Simran Chauhan',
        email: 'simran.chauhan65@example.com',
        phone: '6962074691',
      ),
      const Person(
        id: 'd2303d25-bbea-4912-8e8c-31527edc4d50',
        name: 'Diya Mishra',
        email: 'diya.mishra66@example.com',
        phone: '9944311446',
      ),
      const Person(
        id: '3c9abcb8-5730-4714-a9d9-ace9b5b8ffb8',
        name: 'Rahul Goel',
        email: 'rahul.goel76@example.com',
        phone: '9800699740',
      ),
      const Person(
        id: 'f39a2b52-161d-4a29-8560-ca4c171aacb2',
        name: 'Pari Tyagi',
        email: 'pari.tyagi88@example.com',
        phone: '7339655786',
      ),
      const Person(
        id: 'de68e4e7-8639-4c72-8f86-65f74ee2bdba',
        name: 'Sneha Mishra',
        email: 'sneha.mishra95@example.com',
        phone: '6490060265',
      ),
      const Person(
        id: 'a2cbe2de-9d86-49a7-a612-187e0fe8be4b',
        name: 'Neha Arora',
        email: 'neha.arora84@example.com',
        phone: '8828487319',
      ),
      const Person(
        id: '1826981d-a55e-48f7-ae07-839efce179ed',
        name: 'Ira Mukherjee',
        email: 'ira.mukherjee82@example.com',
        phone: '8212776106',
      ),
      const Person(
        id: '27411704-0250-4cf1-9275-02baa36506da',
        name: 'Vikram Jain',
        email: 'vikram.jain94@example.com',
        phone: '7907854904',
      ),
      const Person(
        id: '74cbda9a-45be-4b62-a89f-93ce470b99e2',
        name: 'David Lee',
        email: 'david@example.com',
        phone: '9001122334',
      ),
      const Person(
        id: 'b75c95a0-00e8-4788-a794-d31997a011b5',
        name: 'Aisha Khan',
        email: 'aisha@example.com',
        phone: '9112233445',
      ),
      const Person(
        id: '3eb37484-8a92-4fcd-934d-0aff0b2db436',
        name: 'Ravi Kumar',
        email: 'ravi@example.com',
        phone: '9988776655',
      ),
      const Person(
        id: '957ca6f7-50f0-4337-8028-77315e988bed',
        name: 'Jane Smith',
        email: 'jane@example.com',
        phone: '9123456780',
      ),
      const Person(
        id: '5cf1ab5b-d9a2-4044-b47d-84590e88d664',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '9876543210',
      ),
    ];

    // Apply filters
    var filteredPeople = allPeople;

    // Filter by role
    if (role != null) {
      filteredPeople = filteredPeople
          .where(
            (person) =>
                person.role.toLowerCase() == role.displayName.toLowerCase(),
          )
          .toList();
    }

    // Filter by search query
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredPeople = filteredPeople
          .where(
            (person) =>
                person.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                person.email.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                person.role.toLowerCase().contains(searchQuery.toLowerCase()) ||
                (person.phone?.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ) ??
                    false),
          )
          .toList();
    }

    // Apply pagination
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= filteredPeople.length) {
      return [];
    }

    return filteredPeople.sublist(
      startIndex,
      endIndex > filteredPeople.length ? filteredPeople.length : endIndex,
    );
  }
}
