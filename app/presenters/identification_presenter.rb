class IdentificationPresenter < BasePresenter
  presents :identification

  def css_id
    "identification_#{identification.id}"
  end
end