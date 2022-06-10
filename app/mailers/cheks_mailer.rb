class ChecksMailer < applicationMailer

  def linter_results
    @user = params[:user]
    @check = params[:check]
    @result = JSON.parse(@check.result)
    mail(to: @user.email, subject: t('.linter_results_subject'))
  end
end