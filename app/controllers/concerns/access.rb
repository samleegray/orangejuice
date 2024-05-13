# frozen_string_literal: true

module Access
  def user_is_admin
    return if current_user.admin?

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'You do not have access to this page.' }
      format.json { redirect_to root_url, status: :forbidden }
    end

  end
end
