class BankAccount

  def initialize(get_bank_transactions)
    @bank_transactions =  get_bank_transactions
  end

  def accounts
    counter = 0
    accounts = []
    CSV.foreach('balances.csv', headers: true) do |row|
      accounts[counter] = {}
      accounts[counter][:account] = "#{row[0]}"
      accounts[counter][:balance] = "#{row[1]}"
      counter += 1
    end
    accounts
  end

  def starting_balance(account_name)
   account = accounts.find{ |account| account[:account] == account_name.to_s}
   account[:balance]
 end

 def ending_balance(account_name)
   ending_balance = 0
   @bank_transactions.each do |transaction|
     if transaction[:account] == account_name.to_s
      ending_balance += transaction[:amount].to_f
    end
  end
  ending_balance
end

def summary(account_name)
  date_sorted = @bank_transactions.sort_by{ |transaction| transaction[:date]}
  date_sorted.each do |transaction|
   if transaction[:account] == account_name.to_s
     transaction[:amount]
   end
 end
end

end
