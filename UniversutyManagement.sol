// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UniversityManagement {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    struct Department {
        string name;
        address[] professors;
    }

    struct Course {
        string name;
        string courseCode;
        uint8 credits;
        address professor;
    }

    struct Student {
        string name;
        uint256 studentId;
        string department;
        uint8 semester;
        uint totalEnrolledCredits;
        uint totalCompletedCredits;
        mapping(string => string) grades; // courseCode => grade
        mapping(string => uint256) attendance; // courseCode => total attendance
    }

    mapping(string => Department) public departments;
    mapping(string => Course) public courses;
    mapping(address => Student) public students;

    event StudentRegistered(address student, string name);
    event GradeAssigned(address student, string course, string grade);
    event AttendanceMarked(address student, string course, uint timestamp);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    modifier onlyProfessor(string memory courseCode) {
        require(msg.sender == courses[courseCode].professor, "Not course professor");
        _;
    }

    function addDepartment(string memory _name) public onlyAdmin {
        departments[_name] = Department(_name, new address[](0));
    }

    function addProfessor(string memory dept, address professor) public onlyAdmin {
        departments[dept].professors.push(professor);
    }

    function registerStudent(address _student, string memory _name, uint256 _id, string memory dept, uint8 _semester) public onlyAdmin {
        Student storage s = students[_student];
        s.name = _name;
        s.studentId = _id;
        s.department = dept;
        s.semester = _semester;
        emit StudentRegistered(_student, _name);
    }

    function addCourse(string memory _name, string memory _code, uint8 _credits, address _professor) public onlyAdmin {
        courses[_code] = Course(_name, _code, _credits, _professor);
    }

    function enrollStudent(address _student, string memory _courseCode) public onlyAdmin {
        students[_student].totalEnrolledCredits += courses[_courseCode].credits;
    }

    function assignGrade(address _student, string memory _courseCode, string memory _grade) public onlyProfessor(_courseCode) {
        students[_student].grades[_courseCode] = _grade;

        // Consider passing = completion for credits
        if (keccak256(bytes(_grade)) != keccak256(bytes("F"))) {
            students[_student].totalCompletedCredits += courses[_courseCode].credits;
        }

        emit GradeAssigned(_student, _courseCode, _grade);
    }

    function markAttendance(address _student, string memory _courseCode) public onlyProfessor(_courseCode) {
        students[_student].attendance[_courseCode]++;
        emit AttendanceMarked(_student, _courseCode, block.timestamp);
    }

    function viewAttendance(string memory _courseCode) public view returns (uint256) {
        return students[msg.sender].attendance[_courseCode];
    }

    function getCreditStatus(address _student) public view returns (uint enrolled, uint completed) {
        enrolled = students[_student].totalEnrolledCredits;
        completed = students[_student].totalCompletedCredits;
    }

    function getStudentSemester(address _student) public view returns (uint8) {
        return students[_student].semester;
    }
}
