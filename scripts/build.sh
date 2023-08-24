cargo build --release --target wasm32-unknown-unknown --package icrc7
ic-wasm target/wasm32-unknown-unknown/release/icrc7.wasm -o target/wasm32-unknown-unknown/release/icrc7.wasm shrink
gzip -f target/wasm32-unknown-unknown/release/icrc7.wasm

cargo build --release --target wasm32-unknown-unknown --package factory
ic-wasm target/wasm32-unknown-unknown/release/factory.wasm -o target/wasm32-unknown-unknown/release/factory.wasm shrink
gzip -f target/wasm32-unknown-unknown/release/factory.wasm
cargo build --release --target wasm32-unknown-unknown --package ext_based_dip721_lib
ic-wasm target/wasm32-unknown-unknown/release/ext_based_dip721_lib.wasm -o target/wasm32-unknown-unknown/release/ext_based_dip721_lib.wasm shrink
gzip -f target/wasm32-unknown-unknown/release/ext_based_dip721_lib.wasm

dfx stop
dfx start --background --clean
dfx deploy factory
# dfx deploy --network ic  factory --no-wallet
dfx canister call factory create_collection '(record {
        name="Btc Flower";
        wasm_name="dip721";
        symbol="BTC";
    })'
# tx_window= 1;
#         permitted_drift=1;
    # description=[];
    #     royalties= ;        royalties_recipient= [];
