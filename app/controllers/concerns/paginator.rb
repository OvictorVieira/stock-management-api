module Paginator

  DEFAULT_ITEMS_PER_PAGE = 10
  INITIAL_PAGE = 1

  private_constant :DEFAULT_ITEMS_PER_PAGE, :INITIAL_PAGE

  def paginate_items(items)
    items
      .page(@page)
      .per(@per_page)
  end

  def set_page
    @page = params['page'] || INITIAL_PAGE
  end

  def set_items_per_page
    @per_page = params['per_page'] || DEFAULT_ITEMS_PER_PAGE
  end
end