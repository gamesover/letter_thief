# frozen_string_literal: true

module LetterThief
  class EmailMessagesController < ApplicationController
    layout "letter_thief/application"

    PAGE_SIZE = 20

    def index
      @search = LetterThief::EmailSearch.new(params).perform
    end

    def show
      @email = EmailMessage.find(params[:id])
    end
  end
end
