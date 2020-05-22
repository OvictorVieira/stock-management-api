module ErrorHandler

  def build_error(message)
    {
      'error': {
        'message': message
      }
    }
  end
end