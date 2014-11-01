class NotesController < ApplicationController
  def create
    fail
    @note = Note.new
  end
end