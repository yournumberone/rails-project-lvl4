class ChecksMailer < ApplicationMailer

  def linter_results
    @user = params[:user]
    @check = params[:check]
    @result = JSON.parse(@check.result)
    mail(to: @user.email, subject: 's')
  end
end
