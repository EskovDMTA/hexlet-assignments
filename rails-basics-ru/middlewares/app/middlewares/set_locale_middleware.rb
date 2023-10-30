# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app, logger_indentificator = '*')
    @app = app
    @logger_indentificator = logger_indentificator
  end

  def call(env)
    dup._call(env)
  end

  def _call(env)
    locale = env['HTTP_ACCEPT_LANGUAGE']&.slice(0..1)
    locale_sym = locale&.to_sym
    I18n.locale = locale_sym && I18n.locale_available?(locale_sym) ? locale_sym : I18n.default_locale
    beauty_logging(locale)
    @app.call(env)
  end

  private

  def beauty_logging(locale)
    Rails.logger.debug(@logger_indentificator * 50)
    Rails.logger.debug("Locale: #{locale}")
    Rails.logger.debug(@logger_indentificator * 50)
  end
end
