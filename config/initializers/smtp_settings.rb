ActionMailer::Base.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                  587,
    domain:               'gmail.com',
    user_name:            'vladpavlishchuk@gmail.com',
    password:             'ppnnxx112233bxluayd',
    authentication:       :plain,
    enable_starttls_auto: true
}