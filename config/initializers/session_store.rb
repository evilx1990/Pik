Rails.application.config.session_store :cookie_store, prefix: 'login_',
                                                      expire_after: 30.second