class ApplicationController < ActionController::Base
  protect_from_forgery


  def index
    @profit = Record.sum(:profit)
  end

  def import
    if params.has_key? :tab
      records = params[:tab].read.split("\n")

      #we do not need first record with fields definition
      records.delete(0)

      records.each{|record|
        #straight solution

        record = record.split("\t")
        rec = Record.new
        rec.purchaser_name = record[0]
        rec.item_description = record[1]
        rec.item_price = record[2].to_f
        rec.purchase_count = record[3]
        rec.merchant_address = record[4]
        rec.merchant_name = record[5]
        rec.profit = rec.purchase_count * rec.item_price
        rec.save
      }

      redirect_to :root, notice: "Well done!"
    end
  end


end
