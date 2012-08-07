class Dashboard::Bank < ActiveRecord::Base
  attr_accessible :current_balance, :last_update, :name
  has_many :transactions
  has_many :bank_balances
  # after_initialize :update_data, :only => :show

  def show
  end

  def update_data
  	if self.last_update == nil || !(self.last_update.to_date === Date.today)
  		self.download_data
  	end
  end

  def download_data
		agent = Mechanize.new
		page = agent.get("https://mijnzakelijk.ing.nl/internetbankieren/SesamLoginServlet")
		form = page.form_with :name => "login"
		username_field = form.fields.first.name
		password_field = form.fields.second.name
		remember_field = form.checkboxes.first.name

		form.field_with(:name => username_field).value = "ftk6p7h7"
		form.field_with(:name => password_field).value = "Andres314"

		results = agent.submit form

		urls = Array["https://mijnzakelijk.ing.nl/internetbankieren/jsp/IndexLogon.jsp",
					 "https://mijnzakelijk.ing.nl/internetbankieren/jsp/sesam_cockpit.jsp",
					 "https://mijnzakelijk.ing.nl/mpz/startframes.do",
					 "https://mijnzakelijk.ing.nl/mpz/startpagina.do",
					 "https://mijnzakelijk.ing.nl/mpz/startpaginarekeninginfo.do"]
		urls.each do |url|
			page = agent.get(url)
		end

		balance = page.at("#giro_0").at("[@align='right']").content.to_s
		balance = balance.gsub(".","").gsub(",",".").to_d
		self.bank_balances.create!(:datetime => DateTime.now, :value => balance);
		# p number_to_currency(value, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")

		if last_update != nil
			last_downloaded_statement_date = last_update.to_date
		else
			last_downloaded_statement_date = Date.parse("20110830")
		end
		page = agent.get("https://mijnzakelijk.ing.nl/mpz/girordpl/downloadperiodeselecteren.do")
		form = page.form_with :name => "form1"
		from_date = form.field_with(:name => "datumvan").value = last_downloaded_statement_date.strftime("%d-%m-%Y")
		to_date = form.field_with(:name => "datumtot").value = Date.today.strftime("%d-%m-%Y")
		format = form.field_with(:name => "formaat").options.third.tick
		agent.submit form

		response = agent.get("https://mijnzakelijk.ing.nl/mpz/girordpl/download.do?datumvan=" + last_downloaded_statement_date.strftime("%d-%m-%Y") + "&datumtot=" + Date.today.strftime("%d-%m-%Y") + "&formaat=kommacsv")
			# import_csv(response.content.to_s)

		csv = CSV.parse(response.content.to_s)

	 	csv[1...csv.length].each do |row|
			
			if row[5].index "Af"
				amount = -(row[6].gsub(",",".").to_d.abs)
			else
				amount = row[6].gsub(",",".").to_d.abs
			end

	 		if not self.transactions.where(:date => Date.parse(row[0]), :name => row[1], :account => row[2], :amount => amount).first
	 			self.transactions.create!(:date => Date.parse(row[0]), :name => row[1], :account => row[2], :contra_account => row[3], :code => row[4], :amount => amount, :transfer_type => row[7], :description => row[8])
	 		end

 		end

 		self.last_update = DateTime.now
		return true
  end

  def current_balance
  	return self.bank_balances.find(:all, :order => "datetime DESC", :limit => 1).first.value
  end

  def transactions_last_n_months(last_n_months=1)
		return self.transactions.find(:all, :conditions => {:date => Date.today.prev_month(last_n_months)..Date.today})
	end

	def revenue(last_n_months=1)
		revenue = 0
		
		self.transactions_last_n_months(last_n_months).each do |transaction|
			if transaction.amount > 0
				revenue = revenue + transaction.amount
			end
		end

		# return number_to_currency(revenue, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")
		return revenue
	end

	def profit(last_n_months=1)
		profit = 0
		self.transactions_last_n_months(last_n_months).each do |transaction|
			if not (transaction.description.downcase.index('winstopname') || transaction.description.downcase.index('inkomsten') || transaction.description.downcase.index('winstdeling') )
				profit = profit + transaction.amount
			end
		end
	
		# return number_to_currency(profit, :unit => "&euro;", :precision => 0, :delimiter => "&thinsp;")
		return profit
	end

	def extract_balance_from_transactions
		balance = 0;
		last_date = nil;
		self.transactions.find(:all).sort_by(&:date).each do |transaction|
			balance = balance + transaction.amount
			if !(self.bank_balances.find(:all, :conditions => {:datetime => last_date}).first) && !(last_date === transaction.date.to_datetime)
				self.bank_balances.create!(:datetime => transaction.date.to_datetime, :value => balance)
				last_date = transaction.date.to_datetime
			end
		end
		return true
	end

	def balances_array
		balances = Array.new
		self.bank_balances.sort_by(&:datetime).each do |balance|
			balances << balance
		end
		return balances
	end

end
