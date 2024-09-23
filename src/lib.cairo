#[starknet::interface]
%lang starknet

struct Book {
    title: felt,
    author: felt,
    price: felt,
}

contract GIDA_Bookstore {
    // Mapping of book IDs to Book structs
    book_map: felt => Book,

    // Event emitted when a new book is added
    event AddBook(felt, felt, felt);

    // Function to add a new book
    func add_book(title: felt, author: felt, price: felt) {
        // Generate a unique book ID
        let book_id = hash(title, author);

        // Create a new Book struct
        let book = Book{title, author, price};

        // Store the book in the mapping
        book_map[book_id] = book;

        // Emit the AddBook event
        emit AddBook(book_id, title, author);
    }

    // Function to remove a book
    func remove_book(book_id: felt) {
        // Remove the book from the mapping
        delete book_map[book_id];
    }

    // Function to query available books
    func get_books() -> (felt, felt, felt)[] {
        // Iterate over the book mapping and return an array of books
        let books = [];
        for ((book_id, book) in book_map.items()) {
            books.append((book_id, book.title, book.author));
        }
        return books;
    }
}
