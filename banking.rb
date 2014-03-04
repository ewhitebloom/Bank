require 'CSV'
require_relative 'bank_transaction'
require_relative 'bank_account'

def format_currency(currency)
  sprintf('%.2f', currency)
end

def feedback(account_name, transactions, accounts)
  puts "===== #{account_name} ======\n\n"
  puts "Starting Balance: $" + format_currency(accounts.starting_balance("#{account_name}")).to_s
  puts "Ending Balance: $" +  format_currency(accounts.ending_balance("#{account_name}")).to_s + "\n\n"
  return_data = BankTransaction.new.summary(account_name.to_s, transactions)
  return_data.each do |transaction|
    puts "$#{format_currency(transaction[0])} #{transaction[1]} #{transaction[2]} - #{transaction[3]}"
  end
  puts "\n==========================================\n\n"
end

transactions = BankTransaction.new.balances('balances.csv')
accounts = BankAccount.new(transactions,'balances.csv')

feedback("Purchasing Account", transactions, accounts)
feedback("Business Checking", transactions, accounts)
