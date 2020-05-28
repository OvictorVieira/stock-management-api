class Products::RecordNotFound < StandardError

  def initialize(id)
    super(I18n.t('activerecord.errors.messages.record_not_found', model_type: I18n.t('products.label.product'), id: id))
  end
end