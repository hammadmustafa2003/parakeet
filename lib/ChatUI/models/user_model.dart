class User {
  final String id;
  final String name;
  final String surname;

  const User({
    required this.id,
    required this.name,
    required this.surname,
  });

  static const List<User> users = [
    User(
      id: '1',
      name: 'Talal',
      surname: 'Nadeem',
    ),
    User(
      id: '2',
      name: 'Hammad',
      surname: 'Mustafa',
      ),
    User(
      id: '3',
      name: 'Saad',
      surname: 'Waseem',
      ),
    User(
      id: '4',
      name: 'Jamal',
      surname: 'Ch',
      ),
    User(
      id: '5',
      name: 'Amjad',
      surname: 'Bond',
      ),
    User(
      id: '6',
      name: 'Mark',
      surname: 'Lost',
      ),
  ];
}
