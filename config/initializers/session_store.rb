# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_mpd_slnz_session', domain: {
  production: '.studentlife.org.nz',
  development: '.lvh.me'
}.fetch(Rails.env.to_sym, :all)
