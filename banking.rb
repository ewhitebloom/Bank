require 'CSV'
require_relative 'bank_transaction'
require_relative 'bank_account'

def format_currency(currency)
  sprintf('%.2f', currency)
end

def feedback(account_name, transactions)
  puts "===== #{account_name} ======"
  puts "Starting Balance: $" + format_currency(BankAccount.new(transactions).starting_balance("#{account_name}")).to_s
  puts "Ending Balance: $" +  format_currency(BankAccount.new(transactions).ending_balance("#{account_name}")).to_s + "\n"
  return_data = BankTransaction.new.summary(account_name.to_s, transactions)
  return_data.each do |transaction|
    puts "$#{format_currency(transaction[0])} #{transaction[1]} #{transaction[2]} - #{transaction[3]}"
  end
  puts "\n==========================================\n\n"
end

transactions = BankTransaction.new.balances('balances.csv')

feedback("Purchasing Account", transactions)
feedback("Business Checking", transactions)
