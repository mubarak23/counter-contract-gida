#[starknet::interface]
pub trait ICounter<TContractState> {
    fn increment(ref self: TContractState);
    fn decrement(ref self: TContractState);
    fn get_current_count(self: @TContractState) -> u128;
}


#[starknet::contract]
pub mod SimpleCouter {
    #[storage]
    struct Storage {
        counter: u128,
    }

    #[constructor]
    fn constructor(ref self: ContractState, inial_val: u128) {
        //store initial value
        self.counter.write(inial_val)
    }

    #[abi(embed_v0)]
    impl SimpleCounter of super::ICounter<ContractState> {
        fn increment(ref self: ContractState) {
            let current_count = self.counter.read();
            self.counter.write(current_count + 1)
        }

        fn decrement(ref self: ContractState) {
            let current_count = self.counter.read();
            self.counter.write(current_count - 1)
        }
        fn get_current_count(self: @ContractState) -> u128 {
            self.counter.read()
        }
    }
}

