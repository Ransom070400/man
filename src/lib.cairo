#[starknet::interface]
%lang starknet

struct Book {
    title: felt,
    author: felt,
    price: felt,
}

contract GIDA_Bookstore {
    
    book_map: felt => Book,

    
    event AddBook(felt, felt, felt);

    
    func add_book(title: felt, author: felt, price: felt) {
        
        let book_id = hash(title, author);

        
        let book = Book{title, author, price};

        
        book_map[book_id] = book;

        
        emit AddBook(book_id, title, author);
    }

    
    func remove_book(book_id: felt) {
        
        delete book_map[book_id];
    }

    
    func get_books() -> (felt, felt, felt)[] {
        // Iterate over the book mapping and return an array of books
        let books = [];
        for ((book_id, book) in book_map.items()) {
            books.append((book_id, book.title, book.author));
        }
        return books;
    }
}
