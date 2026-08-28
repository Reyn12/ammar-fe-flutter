import '../models/user_academic_model.dart';
import '../models/user_model.dart';
import '../models/user_role_model.dart';

class UserMocks {
  const UserMocks._();

  static const user = UserModel(
    id: 2,
    name: 'Mahasiswa Demo',
    email: 'student@example.com',
    nim: '2021012345',
    role: 'user',
    roles: [
      UserRoleModel(id: 3, name: 'user', description: 'Standard user access'),
    ],
    academic: UserAcademicModel(
      gpa: 3.45,
      latestSemesterGpa: 3.6,
      creditsPassed: 96,
      programName: 'Teknik Informatika',
      facultyName: 'Fakultas Ilmu Komputer',
      studentStatus: 'A',
      advisorName: 'Dr. Andi Wijaya, M.Kom.',
      entryPeriod: '20211',
      studySemester: 6,
      degreeLevel: 'S1',
      campus: 'Jakarta',
    ),
    createdAt: '2026-08-12T17:43:09Z',
    updatedAt: '2026-08-12T17:43:09Z',
  );
}
