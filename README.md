# library-management-mysql
# 📚 Library Management System using MySQL  

## 📖 Project Overview  
This project is a **Library Management System** built using **MySQL**. It helps manage books, borrowers, and library branches efficiently by providing insights into book availability, borrower activity, overdue books, and author trends.  

## 🛠️ Tech Stack  
- **Database:** MySQL  
- **Query Language:** SQL  
- **Tools Used:** MySQL Workbench  

## 📂 Datasets & Relationships  
The system consists of multiple relational tables:  

- **Borrower**: Stores borrower details (borrower_id, name, address)  
- **Book**: Contains book information (book_id, title, publisher_id)  
- **Book Authors**: Links books to authors (book_id, author_name)  
- **Publisher**: Stores publisher details (publisher_id, name)  
- **Library Branch**: Stores library branch details (branch_id, name, location)  
- **Book Copies**: Tracks book copies available at each branch (book_id, branch_id, no_of_copies)  
- **Book Loans**: Records book loan transactions (book_id, borrower_id, branch_id, DueDate)  

## 🔍 Key Features  
✅ **Book Availability Tracking** – Find copies of books in different branches  
✅ **Borrower Analysis** – Identify active and inactive borrowers  
✅ **Overdue Book Management** – Track and manage book return deadlines  
✅ **Frequent Borrowers** – Identify users who borrow the most books  
✅ **Author Insights** – Retrieve book availability for specific authors  

## 🚀 How to Use  
1. Clone the repository:  
   ```bash
   git clone https://github.com/yourusername/library-management-system.git
