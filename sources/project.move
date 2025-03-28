module book_marketplace::BookMarket {
    use aptos_framework::coin::{Self, Coin};
    use aptos_framework::signer;
    use std::string::String;
    use std::vector;

    struct Book has key, store {
        owner: address,
        title: String,
        price: u64,
    }

    public entry fun list_book(account: &signer, title: String, price: u64) {
        let seller = signer::address_of(account);
        let book = Book { owner: seller, title, price };
        move_to(account, book);
    }

    public entry fun buy_book(buyer: &signer, seller: address)acquires Book {
        let book = move_from<Book>(seller);
        book.owner = signer::address_of(buyer);
        move_to(buyer, book);
    }
}
