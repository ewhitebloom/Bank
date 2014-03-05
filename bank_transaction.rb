class BankTransaction

  def  balances(bank_data_csv_file)
  counter = 0
  transactions = []
  CSV.foreach('bank_data.csv', headers: true) do |row|
    transactions[counter] = {}
    transactions[counter][:date] = "#{row[0]}"
    transactions[counter][:amount] = "#{row[1]}"
    transactions[counter][:description] = "#{row[2]}"
    transactions[counter][:account] = "#{row[3]}"
    counter += 1
  end
  transactions
  end

  def debit?(transaction)
    transaction[:amount].to_f < 0
  end

  def credit?(transaction)
    transaction[:amount].to_f > 0
  end

  def summary(account_name, bank_transactions)
    returns = []
    date_sorted = bank_transactions.sort_by{ |transaction| transaction[:date]}
    date_sorted.each do |transaction|
      if debit?(transaction)
        value = "DEBIT"
      elsif credit?(transaction)
        value = "CREDIT"
      end

      if transaction[:account] == account_name.to_s
        returns << [transaction[:amount].to_f.abs, value, transaction[:date], transaction[:description]]
      end
    end
    returns
  end

end
