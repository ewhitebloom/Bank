require 'CSV'
require_relative 'bank_transaction'
require_relative 'bank_account'

def format_currency(currency)
  sprintf('%.2f', currency)
end

def feedback(account_name, transactions, transaction_data, accounts)
  puts "===== #{account_name} ======\n\n"
  puts "Starting Balance: $" + format_currency(accounts.starting_balance("#{account_name}")).to_s
  puts "Ending Balance: $" +  format_currency(accounts.ending_balance("#{account_name}")).to_s + "\n\n"
  return_data = transactions.summary(account_name.to_s, transaction_data)
  return_data.each do |transaction|
    puts "$#{format_currency(transaction[0])} #{transaction[1]} #{transaction[2]} - #{transaction[3]}"
  end
  puts "\n==========================================\n\n"
end

transactions = BankTransaction.new
transaction_data = transactions.balances('balances.csv')
accounts = BankAccount.new(transaction_data,'balances.csv')

feedback("Purchasing Account", transactions, transaction_data, accounts)
feedback("Business Checking", transactions, transaction_data, accounts)
