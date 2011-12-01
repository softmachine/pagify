class PageEditorController < MercuryController
  before_filter :auth
  layout "seppi"

  def edit
    logger.info "start edit"
    super
  end

  def auth
    logger.info "asking for authorization..."
    #raise "unauthorized access"
  end
end