# 🎓 University Management Smart Contract

A decentralized and transparent smart contract built with Solidity to manage university or college operations, including student registration, course enrollment, semester and credit tracking, grading, and attendance logging — all on the blockchain.

---

## 📌 What is this?

This smart contract represents a **University Management System** that allows the **admin**, **professors**, and **students** to interact with core academic processes in a **decentralized** and **trustless** way.

### Features:

- Register departments, professors, and students
- Create and assign courses to professors
- Enroll students into courses
- Track student semesters, enrolled & completed credits
- Assign and view grades
- Log and view attendance per course

---

## 💡 Why did we build this?

Traditional university systems suffer from issues like:

- Lack of transparency in grading and attendance
- Manual errors in credit tracking
- Centralized control with poor auditability
- Difficult access to verifiable student data

By building this on **blockchain**, we achieve:

- ✅ **Immutability** — data can't be tampered with
- ✅ **Transparency** — grade and attendance records are publicly verifiable
- ✅ **Automation** — smart contract logic enforces academic rules
- ✅ **Decentralized control** — no single point of failure or manipulation

---

## 🚀 How it Works

### 👤 Admin Role

- Deployer of the contract
- Can add departments, professors, students, and courses
- Can enroll students into courses

### 👨‍🏫 Professors

- Assigned to specific courses
- Can assign grades to students
- Can mark attendance

### 🎓 Students

- Registered with name, student ID, department, and semester
- Can view grades, attendance, and credit status

---

## 🔐 Access Control

- `onlyAdmin` modifier ensures sensitive actions are restricted to the university admin.
- `onlyProfessor(courseCode)` ensures only the assigned professor can grade or log attendance for their course.

---

## ⚙️ Contract Functional Overview

| Function               | Description                                                      |
| ---------------------- | ---------------------------------------------------------------- |
| `addDepartment()`      | Adds a new department                                            |
| `addProfessor()`       | Assigns a professor to a department                              |
| `registerStudent()`    | Registers a new student                                          |
| `addCourse()`          | Creates a new course with credits and assigned professor         |
| `enrollStudent()`      | Enrolls a student into a course and updates enrolled credits     |
| `assignGrade()`        | Professors assign grades to students and track completed credits |
| `markAttendance()`     | Professors mark attendance per course per student                |
| `viewAttendance()`     | Students view their attendance in a specific course              |
| `getCreditStatus()`    | Returns total enrolled and completed credits of a student        |
| `getStudentSemester()` | Returns a student's current semester                             |

---

## 📦 Sample Use Cases

- **Universities** looking to digitize their backend records with tamper-proof storage.
- **EdTech platforms** integrating decentralized verification of course completion.
- **Web3 learning platforms** that reward or gate access based on verified credit completion.

---

## 🧪 Testing & Deployment

To test and deploy the contract:

1. Clone the repo
2. Compile with Hardhat or Remix
3. Deploy to a testnet
4. Interact using `ethers.js` or `web3.js`

```bash
npx hardhat compile
npx hardhat run scripts/deploy.js --network goerli
```

📄 License

MIT License. Use, modify, and distribute freely.
