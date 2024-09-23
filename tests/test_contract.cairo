use array::ArrayTrait;
use result::ResultTrait;
use option::OptionTrait;
use traits::TryInto;
use starknet::ContractAddress;
use starknet::Felt252TryIntoContractAddress;

use snforge_std::{declare, ContractClassTrait};

use man::IHelloStarknetSafeDispatcher;
use man::IHelloStarknetSafeDispatcherTrait;

use snforge_std::{declare, ContractClassTrait, ContractClass, start_cheat_caller_address, stop_cheat_caller_address, EventSpy, EventSpyAssertionsTrait, spy_events, load, cheatcodes::storage::load_felt252};
use gida_book_store::{GidaBookStore, Book};

fn test_add_book() {
    // Deploy the contract
    let contract = declare("GidaBookStore").unwrap().contract_class();

    // Add a book
    contract.add_book("Book 1", "Author 1", 10);

    // Check that the book was added
    let book = contract.get_book(0);
    assert_eq!(book.title, "Book 1");
    assert_eq!(book.author, "Author 1");
    assert_eq!(book.price, 10);
}