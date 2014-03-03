require 'CSV'
require_relative 'bank_transaction'
require_relative 'bank_account'

def format_currency(currency)
  sprintf('%.2f', currency)
end

def feedback(account_name)
  balances = BankTransaction.new.balances
  puts "===== #{account_name} ======"
  puts "Starting Balance: $" + format_currency(BankAccount.new.starting_balance("#{account_name}")).to_s
  puts "Ending Balance: $" +  format_currency(BankAccount.new.ending_balance("#{account_name}")).to_s
  puts
  return_data = BankTransaction.new.summary(account_name.to_s, balances)
  return_data.each do |transaction|
    puts "$#{format_currency(transaction[0])} #{transaction[1]} #{transaction[2]} - #{transaction[3]}"
  end
  puts
  puts "======"
end

feedback("Purchasing Account")
feedback("Business Checking")

