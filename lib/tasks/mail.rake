namespace :mail do
  desc 'Run tests'
  # そもそも rake には Prerequisites といういわば事前タスクを設定する機能
  # つまり、task sample: :environment doとする事で、
  # DailyMailer.send_mail.deliver_nowの中身を実行する前に、
  # :environmentが呼び出される
  task sample: :environment do
    DailyMailer.send_mail.deliver_now
  end
end