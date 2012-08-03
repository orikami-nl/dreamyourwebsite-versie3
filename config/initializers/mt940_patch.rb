module MT940

  class Base

    def parse_tag_60F
      @currency = @line[12..14]
      @balance = @line[15..@line.length]
    end

    def parse_tag_61
      if @line.match(/^:61:(\d{6})(C|D)(\d+),(\d{0,2})/)
        type = $2 == 'D' ? -1 : 1
        @transaction = MT940::Transaction.new(:bank_account => @bank_account, :amount => type * ($3 + '.' + $4).to_f, :bank => @bank, :currency => @currency, :balance => 100)
        @transaction.date = parse_date($1)
        @transactions << @transaction
        @tag86 = false
      end
    end

  end

  class Transaction

    attr_accessor :bank_account, :contra_account, :amount, :description, :contra_account_owner, :date, :bank, :currency, :balance

    def initialize(attributes = {})
      @bank_account        = attributes[:bank_account]
      @bank                = attributes[:bank]
      @amount              = attributes[:amount]
      @description         = attributes[:description]
      @date                = attributes[:date]
      @contra_account      = attributes[:contra_account]
      @contra_account_name = attributes[:contra_account_owner]
      @currency            = attributes[:currency]
      @balance             = attributes[:balance]
    end

  end

end