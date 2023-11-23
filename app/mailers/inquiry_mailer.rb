class InquiryMailer < ApplicationMailer
    default from: "tomoyaa1477@gmail.com"   # 送信元アドレス。自分のgmailに変更しましょう。
   
    def received_email(inquiry)
      @inquiry = inquiry
      mail(:to => inquiry.email, :subject => 'お問い合わせを承りました')
    end
  end
  