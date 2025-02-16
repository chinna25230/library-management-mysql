create database librarydb;

use librarydb;

create table publisher(	publisher_publishername varchar(100) primary key,
						publisher_publisheraddress varchar(255),
						publisher_publisherphone varchar(100)
                        );

create table borrower(	borrower_cardno int auto_increment primary key,
						borrower_borrowername varchar(100),
						borrower_borroweraddress varchar(200),
						borrower_borrowerphone varchar(150)
                        );

create table library_branch( library_branch_branchid int auto_increment primary key,
							 library_branch_branchname varchar(200),
							 library_branch_branchaddress varchar(255)
                             );

create table book(	book_bookid int auto_increment primary key,
					book_book_title varchar(255),
					book_publishername varchar(100),
					foreign key(book_publishername) references publisher(publisher_publishername) on delete cascade on update cascade
				);

create table book_authors(	book_authors_authorid int auto_increment primary key,
							book_authors_bookid int,
							book_authors_authorname varchar(100),
							foreign key(book_authors_bookid) references book(book_bookid) on delete cascade on update cascade
					);

create table book_copies(	book_copies_copiesid int auto_increment primary key,
							book_copies_bookid int,
							book_copies_branchid int,
							book_copies_no_of_copies int,
							foreign key (book_copies_bookid) references book(book_bookid) on delete cascade on update cascade,
							foreign key(book_copies_branchid) references library_branch(library_branch_branchid) on delete cascade on update cascade
							);

create table book_loans( book_loans_loansid int auto_increment primary key,
						 book_loans_bookid int,
						 book_loans_branchid int,
						 book_loans_cardno int,
						 book_loans_dateout date,
						 book_loans_dueout date,
						 foreign key(book_loans_bookid) references book(book_bookid) on delete cascade on update cascade,
						 foreign key(book_loans_branchid) references library_branch(library_branch_branchid) on delete cascade on update  cascade,
						 foreign key(book_loans_cardno) references borrower(borrower_cardno) on delete cascade on update cascade
						);



select * from borrower;
select * from publisher;
select * from book;
select * from book_copies;
select * from book_loans;
select * from library_branch;
select * from book_authors;

-- how many copies of the book titled "The lost tribe" are owned by the library barnch whose name is "sharptown"?

select sum(book_copies.book_copies_no_of_copies) as totalcopies
from book
		join book_copies 
			on book.book_bookid=book_copies.book_copies_bookid
				join library_branch
						on book_copies.book_copies_branchid=library_branch.library_branch_branchid
									where book.book_book_title='The Lost Tribe'
										and library_branch.library_branch_branchname='Sharpstown';

-- How many copies of the book titled "The Lost Tribe" are owned by each library branch?

select library_branch.library_branch_branchname,sum(book_copies.book_copies_no_of_copies)
from book
		join book_copies
			on book.book_bookid=book_copies.book_copies_bookid
				join library_branch 
					on book_copies.book_copies_branchid=library_branch.library_branch_branchid
							where book.book_book_title='The Lost Tribe'
								group by library_branch.library_branch_branchname;

-- Retrieve the names of all borrowers who do not have any books checked out?
select borrower.borrower_borrowername
from borrower
		left join book_loans 
				on borrower.borrower_cardno=book_loans.book_loans_cardno
							where book_loans.book_loans_cardno is null;


-- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 

select book.book_book_title,borrower.borrower_borrowerName,borrower.borrower_borroweraddress 
from book  
			join book_loans 
				on book.book_bookid=book_loans.book_loans_bookid
					join borrower 
						on book_loans.book_loans_cardno=borrower.borrower_cardno
							join library_branch 
									on book_loans.book_loans_branchID = library_branch.library_branch_branchID
											where library_branch.library_branch_branchname="Sharpstown"
														and book_loans.book_loans_dueout="2/3/18";

-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

select library_branch.library_branch_branchname,count(book_loans.book_loans_loansid) as total_loans
from book_loans
			join library_branch 
					on book_loans.book_loans_branchid = library_branch.library_branch_branchid
							group by library_branch_branchname;

-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

select borrower_borrowername,borrower_borroweraddress,
count(book_loans.book_loans_loansid) as books_checked
from borrower
		join book_loans 
			on borrower_cardno=book_loans.book_loans_cardno
					group by borrower_borrowername,borrower_borroweraddress
						having
							count(book_loans.book_loans_loansid) > 5;

-- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

select book.book_book_title,book_copies.book_copies_no_of_copies
from book 
			join book_authors
					on book.book_bookId=book_authors.book_authors_bookID
							join book_copies 
									on book.book_bookid=book_copies.book_copies_bookid
											join library_branch 
													on library_branch.library_branch_branchid=book_copies.book_copies_branchid
															where book_authors.book_authors_authorname="Stephen King" 
																			and library_branch.library_branch_branchname="central";


