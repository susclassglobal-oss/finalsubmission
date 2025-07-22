# Sustainable Classroom – E-Learning Platform

An interactive e-learning web application designed to support students with features like video/text-based learning, coding workbench, progress tracking, and more — all managed via a scalable microservice architecture.

---

##  Features

-  Secure user authentication (Login & Register)
-  Video &  Text-based learning modules
-  Integrated coding workbench (Frontend simulation)
-  Student progress tracking
-  Knowledge testing through assessments
-  User profile management
-  React + Tailwind UI
-  Node.js + Express backend
-  MongoDB database
-  Microservices ready (future scaling)
-  Hosted with Vite dev server

---

## 🛠️ Tech Stack

| Layer       | Tools                                      |
|-------------|--------------------------------------------|
| Frontend    | React, Vite, Tailwind CSS                  |
| Backend     | Node.js, Express.js                        |
| Database    | MongoDB, Mongoose                          |
| Auth        | JSON Web Token (JWT), bcrypt (optional)    |
| Versioning  | Git + GitHub                               |
| Styling     | TailwindCSS                                |

---

##  Folder Structure

elearning-auth-project/
├── client/ # React frontend (Vite)
│ ├── public/
│ ├── src/
│ │ ├── assets/
│ │ ├── components/
│ │ └── pages/ # Login, Dashboard, Courses, etc.
│ ├── tailwind.config.js
│ └── vite.config.js
├── server/ # Node + Express backend
│ ├── models/ # MongoDB schemas
│ ├── routes/ # API routes (auth, user)
│ ├── controllers/ # Business logic
│ └── server.js # Entry point
└── README.md


---

##  Getting Started

###  Prerequisites

- Node.js v18+
- MongoDB local or Atlas instance

###  Setup

#### 1. Clone the repo
```bash
git clone https://github.com/yourusername/Sustainable-classroom.git
cd Sustainable-classroom
**2. Install client dependencies**
bash
Copy
Edit
cd client
npm install
**3. Install server dependencies**
bash
Copy
Edit
cd ../server
npm install
**4. Create .env in server**
env
Copy
Edit
PORT=5000
MONGO_URI=mongodb://localhost:27017/elearningDB
**5. Start the servers**
bash
Copy
Edit
# In client folder
npm run dev

# In server folder (separate terminal)
node server.js

API Endpoints

Auth
bash
Copy
Edit
POST /api/auth/register
POST /api/auth/login
More coming soon…
