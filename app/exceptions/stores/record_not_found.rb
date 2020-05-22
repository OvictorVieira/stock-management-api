class Stores::RecordNotFound < StandardError

  def initialize(id)
    super(I18n.t('activerecord.errors.messages.record_not_found', model_type: I18n.t('stores.label.store'), id: id))
  end
end