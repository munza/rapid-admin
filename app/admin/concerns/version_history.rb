module VersionHistory
	extend ActiveSupport::Concern

	def self.included(base)
		base.instance_eval do


			action_item :show_history, only: :show, if: proc { current_admin_user.is_admin? } do
				model_underscore = resource.class.to_s.gsub(/::/, '').underscore
		    link_to 'Show History', send("history_#{model_underscore}_path", resource) + "?resource=#{resource.class.to_s}"
		  end

			member_action :history do
		    raise ActiveAdmin::AccessDenied(current_admin_user, :history, resource) unless current_admin_user.is_admin?
		    versions = PaperTrail::Version.where(item_type: params[:resource], item_id: params[:id])
		    render "layouts/history", locals: {versions: versions}
		  end
		end
	end
end
