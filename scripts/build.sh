rustup target add wasm32-unknown-unknown
cargo install ic-wasm
cargo build --release --target wasm32-unknown-unknown --package icrc7
ic-wasm target/wasm32-unknown-unknown/release/icrc7.wasm -o target/wasm32-unknown-unknown/release/icrc7.wasm shrink
gzip -f target/wasm32-unknown-unknown/release/icrc7.wasm

cargo build --release --target wasm32-unknown-unknown --package factory
ic-wasm target/wasm32-unknown-unknown/release/factory.wasm -o target/wasm32-unknown-unknown/release/factory.wasm shrink
gzip -f target/wasm32-unknown-unknown/release/factory.wasm

dfx stop
dfx start --background --clean
dfx deploy factory
# dfx deploy --network ic  factory --no-wallet
dfx canister call factory create_icrc7_collection '(record {
        name="Btc Flower";
        
        symbol="BTC";
    })'
dfx stop
# tx_window= 1;
#         permitted_drift=1;
    # description=[];
    #     royalties= ;        royalties_recipient= [];
